import 'package:flutter/material.dart';
import 'package:pizzaprovider/models/pizza_model.dart';
import 'package:pizzaprovider/providers/pizza_provider.dart';
import 'package:pizzaprovider/screens/widgets/entrant_item.dart';
import 'package:pizzaprovider/screens/widgets/pizza_item.dart';
import 'package:provider/provider.dart';

class EntrantsScreen extends StatelessWidget {
  const EntrantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definim la referència al Provider
    var providerPizzes = Provider.of<PizzaProvider>(context);

    if (providerPizzes.llistaEntrants == null) {
      return const CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemCount: providerPizzes.llistaEntrants?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          if (providerPizzes.llistaEntrants == null) {
            return const LinearProgressIndicator();
          }
          return EntrantItem(providerPizzes.llistaEntrants?[index]);
        },
      );
    }
  }
}
