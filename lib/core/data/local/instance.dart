import 'package:hadith/core/data/local/database.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'migrations/migration_1_to_2.dart';
import 'migrations/migration_2_to_3.dart';
import 'migrations/migration_3_to_4.dart';
import 'migrations/migration_4_to_5.dart';

Future<AppDatabase> getDatabase() async {

  const String dbName="hadithDb.db";
  final String databasePath = await getDatabasesPath();
  final String path = join(databasePath, dbName);
  final File file = File(path);
  if (!file.existsSync()) {
    ByteData data = await rootBundle.load(join('assets', dbName));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await file.writeAsBytes(bytes, flush: true);
  }

  return await $FloorAppDatabase.databaseBuilder(dbName)
  .addMigrations([
    migration1To2,migration2To3,migration3To4,migration4To5
  ]).build();
}