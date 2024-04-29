import 'package:pizzaprovider/database/dao/cistella_dao.dart';
import 'package:pizzaprovider/database/database.dart';
import 'package:pizzaprovider/database/entities/cistella.dart';

class CistellaRepository {
  CistellaPizzaProviderDB? _database; // Referència a la BD
  CistellaDao? _dao; // Referència al DAO

  CistellaRepository._(); // Constructor privat

  // Instància única del repositori. La podem crear directament
  // en la inicialització

  static final CistellaRepository _instance = CistellaRepository._();

  // Quan se'ns demane el repositori retornem la instància.
  factory CistellaRepository() {
    return _instance;
  }

  // Connexió a la base de dades
  Future<void> connectaDB() async {
    if (_database == null) {
      // Creem la base de dades només si no s'ha creat ja
      _database = await $FloorCistellaPizzaProviderDB
          .databaseBuilder('pizzaprovider_database.db')
          .build();

      // Creem el DAO
      _dao = _database?.cistellaDao;
    }
  }

  // Mètodes de la classe DAO

  // Seleccionar tots els elements del carret
  Stream<List<Cistella>> findAll() {
    return _dao?.findAll() ?? const Stream.empty();
  }

  // Inserir producte al carret
  Future<void> insertFilaProducte(Cistella fila) {
    return _dao?.insertFilaProducte(fila) ?? Future.value();
  }

  // Eliminar producte del carret
  Future<void> deleteFilaProducte(Cistella fila) {
    return _dao?.deleteFilaProducte(fila) ?? Future.value();
  }


  // Modificar producte del carret
  Future<void> updateFilaProducte(Cistella fila) {
    return _dao?.updateFilaProducte(fila) ?? Future.value();
  }
}
