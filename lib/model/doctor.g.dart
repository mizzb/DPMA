// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorAdapter extends TypeAdapter<Doctor> {
  @override
  final int typeId = 1;

  @override
  Doctor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doctor(
      id: fields[0] as int?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      profilePic: fields[3] as String?,
      favorite: fields[4] as bool?,
      primaryContactNo: fields[5] as String?,
      rating: fields[6] as String?,
      emailAddress: fields[7] as String?,
      qualification: fields[8] as String?,
      description: fields[9] as String?,
      specialization: fields[10] as String?,
      languagesKnown: fields[11] as String?,
    )
      ..edit = fields[12] as bool?
      ..day = fields[13] as String?
      ..month = fields[14] as String?
      ..year = fields[15] as String?
      ..bloodGroup = fields[16] as String?
      ..height = fields[17] as String?
      ..weight = fields[18] as String?;
  }

  @override
  void write(BinaryWriter writer, Doctor obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.profilePic)
      ..writeByte(4)
      ..write(obj.favorite)
      ..writeByte(5)
      ..write(obj.primaryContactNo)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.emailAddress)
      ..writeByte(8)
      ..write(obj.qualification)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.specialization)
      ..writeByte(11)
      ..write(obj.languagesKnown)
      ..writeByte(12)
      ..write(obj.edit)
      ..writeByte(13)
      ..write(obj.day)
      ..writeByte(14)
      ..write(obj.month)
      ..writeByte(15)
      ..write(obj.year)
      ..writeByte(16)
      ..write(obj.bloodGroup)
      ..writeByte(17)
      ..write(obj.height)
      ..writeByte(18)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
