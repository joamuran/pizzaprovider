import 'package:flutter/material.dart';
import 'package:pizzaprovider/providers/pizza_provider.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // Definim una referència al Provider
    var providerPizzes = Provider.of<PizzaProvider>(context, listen: true);

    return Stack(
      children: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
          ),
          onPressed: () {},
        ),
        //if (providerPizzes.cistella?.isNotEmpty ?? false)
        FutureBuilder(
          future: providerPizzes.totalArticles,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Positioned(
                right: 5.0,
                bottom: 5.0,
                child: Text(snapshot.data.toString()),
              );
            } else {return Text("");}
          },
        ),
      ],
    );
  }
}


/*

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const IconButton(
          icon: Icon(
            Icons.shopping_cart,
          ),
          onPressed: null,
        ),
        list.isEmpty
            ? Container()
            : Positioned(
                child: Stack(
                children: <Widget>[
                  /*Icon(Icons.brightness_1,
                      size: 20.0, color: Colors.green[800]),*/
                  Positioned(
                      top: 3.0,
                      left: 6.0,
                      child: Center(
                        child: Text(
                          list.length.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ],
              )),
      ],
    );
  }
   */