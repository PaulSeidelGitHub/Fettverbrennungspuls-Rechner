import 'package:Fettverbrennungspuls/views/calculator_view.dart';
import 'package:Fettverbrennungspuls/views/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RunApp());
}

class RunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First flutter project',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainView(),
	  routes: {
        '/first': (context) => MainView(),
        '/second': (context) => CalculatorView(),
      },
    );
  }
}
