import 'package:hive/hive.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

class HabitModelAdapter extends TypeAdapter<HabitModel> {
  @override
  final int typeId = 0;

  @override
  HabitModel read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final colorValue = reader.readInt();
    final iconName = reader.readString();
    final frequency = HabitFrequency.fromIndex(reader.readInt());
    final reminderEnabled = reader.readBool();
    final hasReminderHour = reader.readBool();
    final reminderHour = hasReminderHour ? reader.readInt() : null;
    final hasReminderMinute = reader.readBool();
    final reminderMinute = hasReminderMinute ? reader.readInt() : null;
    final createdAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final completedDates = reader.readStringList();

    return HabitModel(
      id: id,
      name: name,
      colorValue: colorValue,
      iconName: iconName,
      frequency: frequency,
      reminderEnabled: reminderEnabled,
      reminderHour: reminderHour,
      reminderMinute: reminderMinute,
      createdAt: createdAt,
      completedDates: completedDates,
    );
  }

  @override
  void write(BinaryWriter writer, HabitModel obj) {
    writer
      ..writeString(obj.id)
      ..writeString(obj.name)
      ..writeInt(obj.colorValue)
      ..writeString(obj.iconName)
      ..writeInt(obj.frequency.index)
      ..writeBool(obj.reminderEnabled)
      ..writeBool(obj.reminderHour != null);
    if (obj.reminderHour != null) {
      writer.writeInt(obj.reminderHour!);
    }
    writer.writeBool(obj.reminderMinute != null);
    if (obj.reminderMinute != null) {
      writer.writeInt(obj.reminderMinute!);
    }
    writer
      ..writeInt(obj.createdAt.millisecondsSinceEpoch)
      ..writeStringList(obj.completedDates);
  }
}
