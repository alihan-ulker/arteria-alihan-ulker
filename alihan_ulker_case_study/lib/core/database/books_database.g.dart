// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksDatabaseAdapter extends TypeAdapter<BooksDatabase> {
  @override
  final int typeId = 1;

  @override
  BooksDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BooksDatabase(
      title: fields[0] as String?,
      subtitle: fields[1] as String?,
      authors: (fields[2] as List?)?.cast<String>(),
      publisher: fields[3] as String?,
      publishDate: fields[4] as String?,
      pageCount: fields[5] as int?,
      thumbnailUrl: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BooksDatabase obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.publisher)
      ..writeByte(4)
      ..write(obj.publishDate)
      ..writeByte(5)
      ..write(obj.pageCount)
      ..writeByte(6)
      ..write(obj.thumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
