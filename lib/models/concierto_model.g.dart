// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concierto_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConciertoAdapter extends TypeAdapter<Concierto> {
  @override
  final int typeId = 0;

  @override
  Concierto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Concierto(
      nombre: fields[0] as String,
      fecha: fields[1] as DateTime,
      hora: fields[2] as String,
      lugar: fields[3] as String,
      notas: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Concierto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.fecha)
      ..writeByte(2)
      ..write(obj.hora)
      ..writeByte(3)
      ..write(obj.lugar)
      ..writeByte(4)
      ..write(obj.notas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConciertoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
