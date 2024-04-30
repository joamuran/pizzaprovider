import 'package:flutter/material.dart';
import 'package:pizzaprovider/models/entrants_model.dart';
import 'package:pizzaprovider/providers/pizza_provider.dart';
import 'package:provider/provider.dart';

class EntrantItem extends StatelessWidget {
  Entrant? entrant;

  EntrantItem(this.entrant, {super.key});

  @override
  Widget build(BuildContext context) {
    // Definim una referència al Provider
    var providerPizzes = Provider.of<PizzaProvider>(context);

    return Card(
      child: Row(
        children: <Widget>[
          Image.network(
            "${providerPizzes.serverPrefix}${entrant?.img ?? ''}",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox(
                  width:100, 
                  height:100,
                  child: FittedBox(child: Icon(Icons.cookie_outlined))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entrant?.nom! ?? "",
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                
                
              ],
            ),
          ),
          Text('${entrant?.preu}€',
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  providerPizzes.afigEntrantACistella(entrant?.id ?? "");
                },
              ),
              Text(entrant?.quantitat.toString() ?? "0"),
              IconButton(icon: const Icon(Icons.remove), onPressed: () {
                providerPizzes.suprimeixEntrantACistella(entrant?.id ?? "");
              })
            ],
          ),
        ],
      ),
    );
  }
}
