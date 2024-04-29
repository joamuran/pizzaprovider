import 'package:flutter/material.dart';
import 'package:pizzaprovider/screens/pizzes_screen.dart';
import 'package:pizzaprovider/screens/widgets/cart_icon.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: CartIcon()
        ),
        appBar: AppBar(
          title: const Text('PizzaProvider'),
          /*
          El component bottom de l'AppBar conté el 
          TabBar, que defineix les diferents pestanyes.
          Els tabs poden contindre un text i una icona, 
          però al menys una de les dos coses.

          */
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Pizzes",
                icon: Icon(Icons.local_pizza_outlined),
              ),
              Tab(
                text: "Acompanyament",
                icon: Icon(Icons.cookie_outlined),
              ),
              Tab(
                text: "Beguda",
                icon: Icon(Icons.local_drink_outlined),
              ),
            ],
          ),
        ),
        // El giny TabBarWidget defineix els diferents
        // contenidors per al contingut de cada pestanya
        // Aquesta llista de ginys, poden ser tant ginys predefinits
        // com ginys personalitzats amb tot el congingut que volguem.
        body: const TabBarView(
          children: <Widget>[
            // Contingut de la primera pestanya
            Center(
              child: PizzesScreen(),
            ),
            Center(
              // Contingut de la segona pestanya
              child: Text("acompanyamenta"),
            ),
            Center(
              // Contingut de la tercara pestanya
              child: Text("Beguda"),
            ),
          ],
        ),
      ),
    );
  }
}
