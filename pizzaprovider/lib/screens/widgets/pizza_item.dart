import 'package:flutter/material.dart';
import 'package:pizzaprovider/models/pizza_model.dart';
import 'package:pizzaprovider/providers/pizza_provider.dart';
import 'package:provider/provider.dart';

class PizzaItem extends StatelessWidget {
  Pizza? pizza;

  PizzaItem(this.pizza, {super.key});

  @override
  Widget build(BuildContext context) {
    // Definim una referència al Provider
    var providerPizzes = Provider.of<PizzaProvider>(context);

    return Card(
      child: Row(
        children: <Widget>[
          Image.network(
            "${providerPizzes.serverPrefix}${pizza?.img ?? ''}",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox(
                  width:100, 
                  height:100,
                  child: FittedBox(child: Icon(Icons.local_pizza_outlined))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pizza?.nom! ?? "",
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                
                Text('${pizza?.desc}'),
                
              ],
            ),
          ),
          Text('${pizza?.preu}€',
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  providerPizzes.afigACistella(pizza?.id ?? "");
                },
              ),
              Text(pizza?.quantitat.toString() ?? "0"),
              IconButton(icon: const Icon(Icons.remove), onPressed: () {
                providerPizzes.suprimeixACistella(pizza?.id ?? "");
              })
            ],
          ),
        ],
      ),
    );
  }
}
