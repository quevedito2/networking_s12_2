import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:networking_s12_2/Modelo/Usuario.dart';
import 'package:networking_s12_2/database/db.dart';
import 'package:networking_s12_2/vista_form.dart';

class VistaListado extends StatefulWidget {
  const VistaListado({Key? key}) : super(key: key);

  @override
  State<VistaListado> createState() => _VistaListadoState();
}

class _VistaListadoState extends State<VistaListado> {
  late Future<List<Usuario>> lista;

  @override
  void initState() {
    db().initializeDB().whenComplete(() async {
      setState(() {
        lista = db().listarUsuarios();
      });
    });
  }

  Future<void> actualizarLista() async {
    setState(() {
      lista = db().listarUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de usuarios'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VistaForm()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
