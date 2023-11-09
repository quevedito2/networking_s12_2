import 'package:flutter/material.dart';
import 'package:networking_s12_2/vista_form.dart';
import 'package:networking_s12_2/vista_listado.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: VistaForm(),
        ),
      ),
    );
  }
}
