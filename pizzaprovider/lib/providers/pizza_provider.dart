// Llibreria de classes bàsiques de Flutter
import 'package:flutter/foundation.dart';
import 'package:pizzaprovider/database/entities/cistella.dart';
import 'package:pizzaprovider/models/beguda_model.dart';
import 'package:pizzaprovider/models/entrants_model.dart';
import 'package:pizzaprovider/models/itemCistella.dart';
import 'package:pizzaprovider/models/pizza_model.dart';
import 'package:pizzaprovider/models/producte_model.dart';
import 'package:pizzaprovider/repository/cistella_repository.dart';
import 'package:pizzaprovider/repository/pizza_repository.dart';

// PizzaProvider és un mixin (subclasse) ChangeNotifier
// Amb això hereta el mètode NotifyListeners

class PizzaProvider with ChangeNotifier {
  // definisc el prefix del servidor, per a les imatges
  String serverPrefix = "https://pizza-rest-server-production.up.railway.app";

  // Estructures de dades per definir l'estat

  List<Pizza>? llistaPizzes; // Llistat de Pizzes
  List<Entrant>? llistaEntrants; // Llistat de Pizzes
  List<Beguda>? llistaBegudes; // Llistat de Pizzes

  // Cistella de la compra
  // És un Stream per estar pendent en tot moment dels canvis
  // en la base de dades.
  late Stream<List<Cistella>> cistella;

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

    // Carreguem la llista d'entrants
    await _carregaEntrants();

    // Carreguem la llista de begudes
     await _carregaBegudes();

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

  Future<void> _carregaEntrants() async {
    // Obtenim els entrant del repositori
    llistaEntrants = await pizzaRepo.obtenirEntrants();
  }

  Future<void> _carregaBegudes() async {
    // Obtenim les begudes del repositori
    llistaBegudes = await pizzaRepo.obtenirBegudes();
  }

  Future<void> _carregaCistella() async {
    // Esperem a tindre una connexió llesta a la BD
    await _cistellaRepo.connectaDB();

    // Obtenim el primer element de l'Stream que obtenim amb un findall
    //cistella = await _cistellaRepo.findAll().first;
    cistella = _cistellaRepo.findAll();

    // Agafem el primer element de l'Stream de la cistella
    var cistellaActual = await cistella.first;

    _afigItemCistellaALlista(cistellaActual, llistaPizzes);

    notifyListeners();
  }

  void _afigItemCistellaALlista(var cistellaActual, var llistaProductes) {
    // Afig els elements de la cistella actual a la llista d'elements (pizzes, entrants o begudes)

    // Recorrem la llista de pizzes i inicialitzem si hi ha alguna a la BD
    if (llistaProductes != null) {
      for (Producte producte in llistaProductes!) {
        // Busquem el producte (pizza) en la llista
        debugPrint("${cistellaActual.length}");
        
        var quantitat = () {
          for (var i = 0; i < (cistellaActual.length); i++) {
            if (cistellaActual[i].id == producte.id) {
              return cistellaActual[i].quantitat;
            }
          }
          return 0;
        }();
        if ((quantitat) > 0) producte.quantitat = (quantitat);
      }
    }
  }

  Future<void> afigPizzaACistella(String id) async {
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

  Future<void> suprimeixPizzaACistella(String id) async {
    // Busquem la pizza en la llista de pizzes
    var pizza = llistaPizzes?.firstWhere((pizza) => pizza.id == id);

    // Comprovem que hi ha més d'un
    if ((pizza?.quantitat ?? 0) <= 0) return;

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


  Future<void> afigEntrantACistella(String id) async {
    // Busquem la pizza en la llista de pizzes
    var entrant = llistaEntrants?.firstWhere((entrant) => entrant.id == id);

    // Incrementem la quantitat
    entrant?.quantitat++;

    // I l'afegim a la cistella

    if (entrant != null) {
      if (entrant.quantitat == 1) {
        // Si és la primera pizza que s'afig, s'insereix a la cistella
        await _cistellaRepo
            .insertFilaProducte(Cistella(id: entrant.id, quantitat: 1));
      } else {
        await _cistellaRepo.updateFilaProducte(
            Cistella(id: entrant.id, quantitat: entrant.quantitat));
      }
    }

    notifyListeners();
  }

  Future<void> suprimeixEntrantACistella(String id) async {
    // Busquem la pizza en la llista de pizzes
    var entrant = llistaEntrants?.firstWhere((entrant) => entrant.id == id);

    // Comprovem que hi ha més d'un
    if ((entrant?.quantitat ?? 0) <= 0) return;

    // Si hi ha més d'un, decrementem la quantitat
    entrant?.quantitat--;

    // I mirem si cal eliminar-lo de la cistella (si s'ha quedat a 0) o modificar-lo
    if (entrant != null) {
      if (entrant.quantitat == 0) {
        // Si s'ha quedat a zero, l'eliminem
        await _cistellaRepo
            .deleteFilaProducte(Cistella(id: entrant.id, quantitat: 1));
      } else {
        // I si no, l'actualitzem
        await _cistellaRepo.updateFilaProducte(
            Cistella(id: entrant.id, quantitat: entrant.quantitat));
      }
    }

    notifyListeners();
  }


  Future<void> afigBegudaACistella(String id) async {
    // Busquem la pizza en la llista de pizzes
    var beguda = llistaBegudes?.firstWhere((beguda) => beguda.id == id);

    // Incrementem la quantitat
    beguda?.quantitat++;

    // I l'afegim a la cistella

    if (beguda != null) {
      if (beguda.quantitat == 1) {
        // Si és la primera beguda que s'afig, s'insereix a la cistella
        await _cistellaRepo
            .insertFilaProducte(Cistella(id: beguda.id, quantitat: 1));
      } else {
        await _cistellaRepo.updateFilaProducte(
            Cistella(id: beguda.id, quantitat: beguda.quantitat));
      }
    }

    notifyListeners();
  }

  Future<void> suprimeixBegudaACistella(String id) async {
    // Busquem la beguda en la llista de begudes
    var beguda = llistaBegudes?.firstWhere((beguda) => beguda.id == id);

    // Comprovem que hi ha més d'un
    if ((beguda?.quantitat ?? 0) <= 0) return;

    // Si hi ha més d'un, decrementem la quantitat
    beguda?.quantitat--;

    // I mirem si cal eliminar-lo de la cistella (si s'ha quedat a 0) o modificar-lo
    if (beguda != null) {
      if (beguda.quantitat == 0) {
        // Si s'ha quedat a zero, l'eliminem
        await _cistellaRepo
            .deleteFilaProducte(Cistella(id: beguda.id, quantitat: 1));
      } else {
        // I si no, l'actualitzem
        await _cistellaRepo.updateFilaProducte(
            Cistella(id: beguda.id, quantitat: beguda.quantitat));
      }
    }

    notifyListeners();
  }

  Future<int> get totalArticles async {
    // Getter que retorna el nombre total d'articles
    int total = 0;

    // Agafem el primer element de l'Stream
    // Com que és un Future, fem l'await per esperr a la llista
    var cistellaActual = await cistella.first;

    for (var item in cistellaActual) {
      total += item.quantitat;
    }
    debugPrint("***---$total");
    return total;
  }

/*

  WIP: Retorna el pedido per mostrar, calculant preus parcials i totals

  Future<CistellaPedido> get obtenirCistella async {
    
    CistellaPedido cistellaPedido;
    List<ItemCistella> items=[];
    
    // Agafem el primer element de l'Stream
    // Com que és un Future, fem l'await per esperr a la llista
    var cistellaActual = await cistella.first;
      
    }

  }
*/

}
