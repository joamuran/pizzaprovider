import 'package:flutter/material.dart';
import 'package:pizzaprovider/models/pizza_model.dart';
import 'package:pizzaprovider/providers/pizza_provider.dart';
import 'package:pizzaprovider/screens/widgets/pizza_item.dart';
import 'package:provider/provider.dart';

class PizzesScreen extends StatelessWidget {
  const PizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definim la referència al Provider
    var providerPizzes = Provider.of<PizzaProvider>(context);

    if (providerPizzes.llistaPizzes == null) {
      return const CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemCount: providerPizzes.llistaPizzes?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          if (providerPizzes.llistaPizzes == null) {
            return const LinearProgressIndicator();
          }
          return PizzaItem(providerPizzes.llistaPizzes?[index]);
        },
      );
    }
  }
}
