import 'package:flutter/material.dart';
import 'package:pizzaprovider/providers/pizza_provider.dart';
import 'package:pizzaprovider/screens/widgets/beguda_item.dart';
import 'package:provider/provider.dart';

class CistellaScreen extends StatelessWidget {
  const CistellaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definim la referència al Provider
    var providerPizzes = Provider.of<PizzaProvider>(context);

    // WIP: Mostra la llista d'elements de la comanda

    /*if (providerPizzes.llistaBegudes == null) {
      return const CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemCount: providerPizzes.llistaBegudes?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          if (providerPizzes.llistaBegudes == null) {
            return const LinearProgressIndicator();
          }
          return BegudaItem(providerPizzes.llistaBegudes?[index]);
        },
      );
    }*/
    return Placeholder();
  }
}
