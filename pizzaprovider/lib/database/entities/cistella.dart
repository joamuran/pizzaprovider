import 'package:floor/floor.dart';

// Representem la taula amb la cistella de la compra
@entity
class Cistella {
  @primaryKey
  final String id;      // Serà l'id del producte
  final int quantitat;  // Indicarà la quantitat d'aquest producte

  Cistella({required this.id, required this.quantitat});
  
}
