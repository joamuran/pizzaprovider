/* Model per als entrants */

import 'package:pizzaprovider/models/producte_model.dart';

class Entrant extends Producte{
  String? img;
  double? preu;

  Entrant({
    required super.id,
    required super.nom,
    this.img,
    this.preu,
    
  });

  factory Entrant.fromJSON(Map<String, dynamic> json) {
    // Podem fer ús d'un mètode de Factoria, i que ens convertisca
    // un JSON en una instància d'Entrant.
    // Aquesta és una forma alternativa de fer-ho a com ho hem
    // vist al curs.
    
    return Entrant(
      id: json['id'],
      nom: json['nom'],
      img: json['img'],
      // Com que pot que l'API ens retorne un enter, cal fer la conversió a doube
      preu: (json['preu'] is int) ? (json['preu'] as int).toDouble() : json['preu'],
    );
  }
}
