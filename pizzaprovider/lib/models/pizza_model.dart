/* Model per a les pizzes */

import 'package:pizzaprovider/models/producte_model.dart';

class Pizza extends Producte{
  String? desc;
  bool? vegetariana;
  List<String>? alergens;
  String? img;
  double? preu;

  Pizza({
    required super.id,  // Com que deriva de producte, l'id el té producte
    required super.nom,
    this.desc,
    this.vegetariana,
    this.alergens,
    this.img,
    this.preu
    
  });

  factory Pizza.fromJSON(Map<String, dynamic> json) {
    // Podem fer ús d'un mètode de Factoria, i que ens convertisca
    // un JSON en una instància de Pizza.
    // Aquesta és una forma alternativa de fer-ho a com ho hem
    // vist al curs.
    
    return Pizza(
      id: json['id'],
      nom: json['nom'],
      desc: json['desc'],
      vegetariana: json['vegetariana'],
      alergens: List<String>.from(json['alergens']),
      img: json['img'],
      // Com que pot que l'API ens retorne un enter, cal fer la conversió a doube
      preu: (json['preu'] is int) ? (json['preu'] as int).toDouble() : json['preu'],
      
    );
  }
}
