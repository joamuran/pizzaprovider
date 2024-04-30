// Classe abstracta per modelar tots els productes
abstract class Producte {
  String id = "";
  String nom="";
  int quantitat = 0; // Indica la quantitat de pizzes a la cistella

  Producte({required this.id, required this.nom});
}
