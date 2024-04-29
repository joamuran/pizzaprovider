import 'package:pizzaprovider/models/pizza_model.dart';
import 'package:pizzaprovider/services/pizza_service.dart';

class PizzaRepository {
  Future<List<Pizza>> obtenirPizzes(
      {int pageNumber = 0, int pageSize = 0}) async {
    // Obtenim el JSON amb la llista de pizzes
    List<dynamic> pizzesJSON = await PizzaService.obtenirPizzes(pageNumber: -1);

    // El mapem a objectes de tipus Pizza
    List<Pizza> llistaPizzes;
    llistaPizzes = pizzesJSON.map((pizzaJSON) {
      return Pizza.fromJSON(pizzaJSON);
    }).toList();

    // I retornem la llista
    return llistaPizzes;
  }
}
