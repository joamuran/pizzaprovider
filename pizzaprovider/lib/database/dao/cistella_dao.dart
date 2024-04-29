import 'package:floor/floor.dart';
import 'package:pizzaprovider/database/entities/cistella.dart';

@dao
abstract class CistellaDao {
  @Query('SELECT * FROM Cistella')
  Stream<List<Cistella>> findAll();

  @insert
  Future<void> insertFilaProducte(Cistella cistella);

  @delete
  Future<void> deleteFilaProducte(Cistella cistella);
  
  @update
  Future<void> updateFilaProducte(Cistella cistella);
}