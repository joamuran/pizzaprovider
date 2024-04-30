
class ItemCistella {
  String nom="";
  int quantitat = 0;
  double preuTotal=0.0;

  ItemCistella({required this.nom, required this.quantitat, required this.preuTotal});
}

class CistellaPedido{
  List<ItemCistella> cistella=[];
  double preuCistella=0.0;

}
