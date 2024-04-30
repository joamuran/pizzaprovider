import 'package:flutter/material.dart';
import 'package:pizzaprovider/models/beguda_model.dart';
import 'package:pizzaprovider/providers/pizza_provider.dart';
import 'package:provider/provider.dart';

class BegudaItem extends StatelessWidget {
  Beguda? beguda;

  BegudaItem(this.beguda, {super.key});

  @override
  Widget build(BuildContext context) {
    // Definim una referència al Provider
    var providerPizzes = Provider.of<PizzaProvider>(context);

    return Card(
      child: Row(
        children: <Widget>[
          Image.network(
            "${providerPizzes.serverPrefix}${beguda?.img ?? ''}",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox(
                  width:100, 
                  height:100,
                  child: FittedBox(child: Icon(Icons.local_drink_outlined))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  beguda?.nom! ?? "",
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                
                
              ],
            ),
          ),
          Text('${beguda?.preu}€',
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  providerPizzes.afigBegudaACistella(beguda?.id ?? "");
                },
              ),
              Text(beguda?.quantitat.toString() ?? "0"),
              IconButton(icon: const Icon(Icons.remove), onPressed: () {
                providerPizzes.suprimeixBegudaACistella(beguda?.id ?? "");
              })
            ],
          ),
        ],
      ),
    );
  }
}
