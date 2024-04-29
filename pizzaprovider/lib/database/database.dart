// database.dart

// Paquets necessaris
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:pizzaprovider/database/dao/cistella_dao.dart';
import 'package:pizzaprovider/database/entities/cistella.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:floor/floor.dart';


// Injectem el codi generat (fins que no generem el codi, donarà error)
part 'database.g.dart';

@Database(version: 1, entities: [Cistella])
abstract class CistellaPizzaProviderDB extends FloorDatabase {
  CistellaDao get cistellaDao;
}