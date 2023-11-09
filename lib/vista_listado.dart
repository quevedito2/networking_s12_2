import 'package:flutter/material.dart';
import 'package:networking_s12_2/Modelo/Usuario.dart';
import 'package:networking_s12_2/database/db.dart';
import 'package:networking_s12_2/vista_form.dart';

class VistaListado extends StatefulWidget {
  const VistaListado({Key? key});

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
      body: FutureBuilder<List<Usuario>>(
        future: lista,
        builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
          if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          } else {
            final items = snapshot.data ?? <Usuario>[];
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(Icons.delete, color: Colors.white)),
                    key: ValueKey<int>(items[index].id),
                    onDismissed: (DismissDirection direction) async {
                      await db().eliminarUsuario(items[index].id);
                      setState(() {
                        items.remove(items[index]);
                      });
                    },
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 100,
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Código: ${items[index].id}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                //Text('ID: ' + items[index].id.toString()),
                                Text(
                                  'Nombre: ${items[index].nombre}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                //Text('Nombre: ' + items[index].nombre),
                                Text(
                                  'Correo: ${items[index].correo}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                //Text('Correo: ' + items[index].correo),
                              ],
                            )),
                      ),
                    ),
                    //actualizarLista();
                  );
                });
          }
        },
      ),
    );
  }
}
