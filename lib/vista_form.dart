import 'package:flutter/material.dart';
import 'package:networking_s12_2/Modelo/Usuario.dart';
import 'package:networking_s12_2/database/db.dart';

class VistaForm extends StatefulWidget {
  const VistaForm({Key? key});

  @override
  State<VistaForm> createState() => _VistaFormState();
}

class _VistaFormState extends State<VistaForm> {
  int codigo = 0;
  String nombre = "";
  String correo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevos usuarios'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Código',
            ),
            onChanged: (value) {
              setState(() {
                codigo = int.parse(value);
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Nombre',
            ),
            onChanged: (value) {
              setState(() {
                nombre = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Correo',
            ),
            onChanged: (value) {
              setState(() {
                correo = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
            onPressed: () async {
              await db()
                  .insertarUsuario(Usuario(
                    id: codigo,
                    nombre: nombre,
                    correo: correo,
                  ))
                  .whenComplete(() => Navigator.pop(context));
            },
            child: Text('Guardar usuario'),
          ),
        ),
      ]),
    );
  }
}
