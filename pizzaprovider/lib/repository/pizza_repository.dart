import 'package:flutter/foundation.dart';
import 'package:pizzaprovider/models/beguda_model.dart';
import 'package:pizzaprovider/models/entrants_model.dart';
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

  Future<List<Entrant>> obtenirEntrants(
      {int pageNumber = 0, int pageSize = 0}) async {
    // Obtenim el JSON amb la llista d'entrants
    List<dynamic> entrantsJSON =
        await PizzaService.obtenirEntrants(pageNumber: -1);

    // El mapem a objectes de tipus Entrant
    List<Entrant> llistaEntrants;
    llistaEntrants = entrantsJSON.map((entrantJSON) {
      return Entrant.fromJSON(entrantJSON);
    }).toList();

    // I retornem la llista
    return llistaEntrants;
  }

  Future<List<Beguda>> obtenirBegudes(
      {int pageNumber = 0, int pageSize = 0}) async {
    // Obtenim el JSON amb la llista d'entrants
    List<dynamic> begudesJSON =
        await PizzaService.obtenirBegudes(pageNumber: -1);

    // El mapem a objectes de tipus Beguda
    List<Beguda> llistaBegudes;
    llistaBegudes = begudesJSON.map((begudaJSON) {
      return Beguda.fromJSON(begudaJSON);
    }).toList();

    // I retornem la llista
    return llistaBegudes;
  }
}
