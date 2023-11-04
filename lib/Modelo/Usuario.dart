class Usuario {
  int id;
  String nombre;
  String correo;

  Usuario({required this.id, required this.nombre, required this.correo});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': nombre, 'correo': correo};
  }

  Usuario.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nombre = map['nombre'],
        correo = map['correo'];
}
