// Llibreria de classes bàsiques de Flutter
import 'package:flutter/foundation.dart';
import 'package:pizzaprovider/database/entities/cistella.dart';
import 'package:pizzaprovider/models/pizza_model.dart';
import 'package:pizzaprovider/repository/cistella_repository.dart';
import 'package:pizzaprovider/repository/pizza_repository.dart';

// PizzaProvider és un mixin (subclasse) ChangeNotifier
// Amb això hereta el mètode NotifyListeners

class PizzaProvider with ChangeNotifier {
  // definisc el prefix del servidor, per a les imatges
  String serverPrefix = "https://pizza-rest-server-production.up.railway.app";

  // Estructures de dades per definir l'estat

  List<Pizza>? llistaPizzes; // Llistat de Pizzes

  //List<Cistella>? cistella = []; // Cistella de la compra
  late Stream<List<Cistella>> cistella; // Cistella de la compra

  /* Referències i instanciació dels repositoris */

  // Repositori per obtenir les pizzes de l'API
  final PizzaRepository pizzaRepo = PizzaRepository();

  // Repositori per obtenir la cistella de la compra
  final CistellaRepository _cistellaRepo = CistellaRepository();

  PizzaProvider() {
    // Cridem a una funció d'inicialització
    init();

    // Nota: No cridem directament els mètodes des d'aci,
    //       perquè necessitem que s'executen de forma asíncona,
    //       i dins el constructor no podem fer-ho.
  }

  Future<void> init() async {
    // Carreguem la llista de pizzes
    await _carregaPizzes();
    // Obtenim també la informació del carret de la compra, si existeix
    await _carregaCistella();
    notifyListeners();
  }

  Future<void> _carregaPizzes() async {
    // Obtenim les pizzes de del mètode corresponent del repositori
    llistaPizzes = await pizzaRepo.obtenirPizzes();

    // No fem aci un NotifyListeners, sinò que ens esperem a que
    // es tinga també carregada la cistella.
  }

  Future<void> _carregaCistella() async {
    // Esperem a tindre una connexió llesta a la BD
    await _cistellaRepo.connectaDB();

    // Obtenim el primer element de l'Stream que obtenim amb un findall
    //cistella = await _cistellaRepo.findAll().first;
    cistella =_cistellaRepo.findAll();

    var cistellaActual=await cistella.first;

    // Recorrem la llista de pizzes i inicialitzem si hi ha alguna a la BD
    if (llistaPizzes != null) {
      for (Pizza pizza in llistaPizzes!) {
        // Busquem el producte (pizza) en la llista
        debugPrint("${cistellaActual.length}");
        //var prod = cistella?.firstWhere((producte) => producte.id == pizza.id);

        var quantitat = () {
          for (var i = 0; i < (cistellaActual.length); i++) {
            if (cistellaActual[i].id == pizza.id) {
              return cistellaActual[i].quantitat;
            }
          }
          return 0;
        }();
        if ((quantitat) > 0) pizza.quantitat = (quantitat);
      }
    }

    notifyListeners();
  }

  Future<void> afigACistella(String id) async {
    // Busquem la pizza en la llista de pizzes
    var pizza = llistaPizzes?.firstWhere((pizza) => pizza.id == id);

    // Incrementem la quantitat
    pizza?.quantitat++;

    // I l'afegim a la cistella

    if (pizza != null) {
      if (pizza.quantitat == 1) {
        // Si és la primera pizza que s'afig, s'insereix a la cistella
        await _cistellaRepo
            .insertFilaProducte(Cistella(id: pizza.id, quantitat: 1));
      } else {
        await _cistellaRepo.updateFilaProducte(
            Cistella(id: pizza.id, quantitat: pizza.quantitat));
      }
    }

    notifyListeners();
  }

  Future<void> suprimeixACistella(String id) async {
    // Busquem la pizza en la llista de pizzes
    var pizza = llistaPizzes?.firstWhere((pizza) => pizza.id == id);

    // Comprovem que hi ha més d'un
    if (( pizza?.quantitat??0 )<=0) return;

    // Si hi ha més d'un, decrementem la quantitat
    pizza?.quantitat--;

    // I mirem si cal eliminar-lo de la cistella (si s'ha quedat a 0) o modificar-lo
    if (pizza != null) {
      if (pizza.quantitat == 0) {
        // Si s'ha quedat a zero, l'eliminem
        await _cistellaRepo
            .deleteFilaProducte(Cistella(id: pizza.id, quantitat: 1));
      } else {
        // I si no, l'actualitzem
        await _cistellaRepo.updateFilaProducte(
            Cistella(id: pizza.id, quantitat: pizza.quantitat));
      }
    }

    notifyListeners();
  }


  Future<int> get totalArticles async {

    // Getter que retorna el nombre total d'articles
    int total = 0;

    // Agafem el primer element de l'Stream
    // Com que és un Future, fem l'await per esperr a la llista
    var cistellaActual=await cistella.first;
  
    for (var item in cistellaActual) {
      total += item.quantitat;
    }
    debugPrint("***---$total");
    return total;
  }
}
