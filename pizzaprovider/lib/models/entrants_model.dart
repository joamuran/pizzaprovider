/* Model per a les pizzes */

class Pizza {
  String id = "";
  String? nom;
  String? desc;
  bool? vegetariana;
  List<String>? alergens;
  String? img;
  double? preu;
  int quantitat=0; // Indica la quantitat de pizzes a la cistella

  Pizza({
    required this.id,
    this.nom,
    this.desc,
    this.vegetariana,
    this.alergens,
    this.img,
    this.preu,
    
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
      preu: json['preu'],
    );
  }
}
