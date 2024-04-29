import 'package:flutter/material.dart';
import 'package:pizzaprovider/providers/pizza_provider.dart';
import 'package:pizzaprovider/screens/main_screen.dart';
import 'package:provider/provider.dart';

// Execució de l'app gràfica de Dart
void main() => runApp(const PizzaProviderMainApp());

// Classe principal de l'aplicació
class PizzaProviderMainApp extends StatelessWidget {
  const PizzaProviderMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PizzaProvider',
      debugShowCheckedModeBanner: false,
      // Com a Home, en lloc de la pantalla principal afegim el
      // widget ChangeNotifierProvider. Això permetrà que tot el que
      // penge d'aci en l'argre, tindrà accés a aquest provider:
      home: ChangeNotifierProvider(
          create: (BuildContext context) => PizzaProvider(),
          // I enllacem amb la pantalla principal
          child: const MainScreen()),
      theme: TemaPizza.lightThemeData(context),
    );
  }
}

class TemaPizza {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.red,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: CircleBorder(),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
      ),
      appBarTheme: const AppBarTheme(
          color: Colors.red,
          shadowColor: Colors.white,
          elevation: 5,
          foregroundColor: Colors.white,
          ),
    );
  }
}
