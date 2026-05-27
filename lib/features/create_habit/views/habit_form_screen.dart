import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/create_habit/widgets/habit_color_picker.dart';
import 'package:habit_tracker_visual/features/create_habit/widgets/habit_frequency_selector.dart';
import 'package:habit_tracker_visual/features/create_habit/widgets/habit_icon_picker.dart';
import 'package:habit_tracker_visual/features/create_habit/widgets/habit_reminder_section.dart';
import 'package:habit_tracker_visual/features/habits/constants/habit_palette.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/habits/validators/habit_validators.dart';
import 'package:habit_tracker_visual/features/settings/utils/notification_sync_helper.dart';
import 'package:habit_tracker_visual/shared/widgets/habit_not_found_screen.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitFormScreen extends ConsumerStatefulWidget {
  const HabitFormScreen({super.key, this.habitId});

  final String? habitId;

  bool get isEditing => habitId != null;

  @override
  ConsumerState<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends ConsumerState<HabitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  int _colorValue = HabitPalette.toValue(AppColors.primary);
  String _iconName = 'activity';
  HabitFrequency _frequency = HabitFrequency.daily;
  bool _reminderEnabled = false;
  TimeOfDay? _reminderTime;
  bool _isSaving = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _tryLoadHabit());
    }
  }

  void _tryLoadHabit() {
    if (_initialized || !widget.isEditing) return;
    final habit = ref.read(habitByIdProvider(widget.habitId!));
    if (habit == null || !mounted) return;
    _loadHabit(habit);
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _loadHabit(HabitModel habit) {
    if (_initialized) return;
    _nameController.text = habit.name;
    _colorValue = habit.colorValue;
    _iconName = habit.iconName;
    _frequency = habit.frequency;
    _reminderEnabled = habit.reminderEnabled;
    if (habit.reminderHour != null && habit.reminderMinute != null) {
      _reminderTime = TimeOfDay(
        hour: habit.reminderHour!,
        minute: habit.reminderMinute!,
      );
    }
    _initialized = true;
  }

  Future<void> _save() async {
    final l10n = context.l10n;

    if (!_formKey.currentState!.validate()) return;

    if (_reminderEnabled && _reminderTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.formReminderTimeRequired)),
      );
      return;
    }

    setState(() => _isSaving = true);

    final repository = ref.read(habitRepositoryProvider);
    final name = _nameController.text.trim();

    try {
      if (widget.isEditing) {
        final existing = repository.getById(widget.habitId!);
        if (existing == null) {
          if (!mounted) return;
          context.pop();
          return;
        }

        final updated = existing.copyWith(
          name: name,
          colorValue: _colorValue,
          iconName: _iconName,
          frequency: _frequency,
          reminderEnabled: _reminderEnabled,
          reminderHour: _reminderEnabled ? _reminderTime?.hour : null,
          reminderMinute: _reminderEnabled ? _reminderTime?.minute : null,
          clearReminderHour: !_reminderEnabled,
          clearReminderMinute: !_reminderEnabled,
        );
        await repository.save(updated);
        await syncNotifications(
          ref,
          habits: repository.getAll(),
          requestPermissionIfNeeded: _reminderEnabled,
        );
      } else {
        final habit = HabitModel.create(
          name: name,
          colorValue: _colorValue,
          iconName: _iconName,
          frequency: _frequency,
          reminderEnabled: _reminderEnabled,
          reminderHour: _reminderEnabled ? _reminderTime?.hour : null,
          reminderMinute: _reminderEnabled ? _reminderTime?.minute : null,
        );
        await repository.save(habit);
        await syncNotifications(
          ref,
          habits: repository.getAll(),
          requestPermissionIfNeeded: _reminderEnabled,
        );
      }

      if (!mounted) return;
      context.pop();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (widget.isEditing) {
      final habit = ref.watch(habitByIdProvider(widget.habitId!));
      if (habit == null) {
        return const HabitNotFoundScreen(leadingIcon: LucideIcons.x);
      }
    }

    final accentColor = Color(_colorValue);

    return Scaffold(
      appBar: AppBar(
        title: AppText.subtitle(
          widget.isEditing ? l10n.formEditTitle : l10n.formCreateTitle,
        ),
        leading: IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: _isSaving ? null : () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppSpacing.screenPadding,
          children: [
            AppInput(
              controller: _nameController,
              label: l10n.formNameLabel,
              hint: l10n.formNameHint,
              prefixIcon: LucideIcons.pencil,
              maxLength: HabitValidators.maxNameLength,
              textInputAction: TextInputAction.done,
              validator: (value) => HabitValidators.name(value, l10n),
            ),
            const VGap.xl(),
            HabitColorPicker(
              selectedColorValue: _colorValue,
              onColorSelected: (value) => setState(() => _colorValue = value),
            ),
            const VGap.xl(),
            HabitIconPicker(
              selectedIconName: _iconName,
              accentColor: accentColor,
              onIconSelected: (name) => setState(() => _iconName = name),
            ),
            const VGap.xl(),
            HabitFrequencySelector(
              selected: _frequency,
              onChanged: (f) => setState(() => _frequency = f),
            ),
            const VGap.xl(),
            HabitReminderSection(
              enabled: _reminderEnabled,
              time: _reminderTime,
              onEnabledChanged: (value) {
                setState(() {
                  _reminderEnabled = value;
                  _reminderTime ??= const TimeOfDay(hour: 9, minute: 0);
                });
              },
              onTimeSelected: (time) => setState(() => _reminderTime = time),
            ),
            const VGap.xxxl(),
            AppButton(
              label: widget.isEditing
                  ? l10n.formSaveChanges
                  : l10n.formCreateButton,
              fullWidth: true,
              icon: LucideIcons.check,
              isLoading: _isSaving,
              onPressed: _isSaving ? null : _save,
            ),
            const VGap.md(),
            AppButton(
              label: l10n.cancel,
              variant: AppButtonVariant.ghost,
              fullWidth: true,
              onPressed: _isSaving ? null : () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
