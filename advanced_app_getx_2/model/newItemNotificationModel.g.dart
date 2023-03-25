// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newItemNotificationModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewItemNotifcationModelAdapter
    extends TypeAdapter<NewItemNotifcationModel> {
  @override
  final int typeId = 0;

  @override
  NewItemNotifcationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewItemNotifcationModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DateTime,
      fields[5] as bool,
      fields[11] as bool,
      fields[7] as bool?,
      fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NewItemNotifcationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.dateToShow)
      ..writeByte(5)
      ..write(obj.isRepeated)
      ..writeByte(11)
      ..write(obj.hasAutoDelete)
      ..writeByte(7)
      ..write(obj.isFavorite)
      ..writeByte(9)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewItemNotifcationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
