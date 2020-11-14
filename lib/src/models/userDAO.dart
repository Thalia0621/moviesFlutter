import 'dart:convert';

class UserDAO {
  int id;
  String username;
  String password;
  String nombre;
  String apellido;
  String telefono;
  String foto;
  String email;
  String curp;

  

  UserDAO({this.id,this.username,this.password,this.nombre,this.apellido,this.foto,this.telefono,this.email,this.curp});
  factory UserDAO.fromJSON(Map<String,dynamic> map){
    return UserDAO(
      id:      map['id'],
      nombre:  map['nombre'],
      apellido:map['apellido'],
      telefono:map['telefono'],
      email:   map['email'],
      curp:    map['curp'],
      password:map['password'],
      username:map['username'],
      foto: map['foto']
    );
  }

  Map<String,dynamic>toJSON(){
    return {
      "id"      : id,
      "nombre"  : nombre,
      "apellido": apellido,
      "telefono": telefono,
      "email"   : email,
      "curp"    : curp,
      "password": password,
      "username": username,
      "foto"    : foto

    };
  }

  String userToJson(){
    final mapUser=this.toJSON();
    return json.encode(mapUser);
  }


}