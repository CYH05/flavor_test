import 'package:flavor_test/flavor/flavor_config.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.PROD,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(dataBaseName: 'autonomous-chef-prod'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ready to Go',
      home: HomePage(),
    );
  }
}
