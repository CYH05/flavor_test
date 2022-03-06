import 'package:flutter/material.dart';

enum Flavor {
  DEV,
  PROD,
}

class FlavorValues {
  final String dataBaseName;
  FlavorValues({required this.dataBaseName});
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      Color color = Colors.blue,
      required FlavorValues values}) {
    _instance ??=
        FlavorConfig._internal(flavor, flavor.toString(), color, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);
  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance!.flavor == Flavor.PROD;
  static bool isDevelopment() => _instance!.flavor == Flavor.DEV;
}
