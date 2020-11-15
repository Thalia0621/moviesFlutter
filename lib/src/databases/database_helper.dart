import 'dart:io';

import 'package:practica2/src/models/userDAO.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path_provider_linux/path_provider_linux.dart';
//import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
//import 'package:path_provider_linux/path_provider_linux.dart';

class DataBaseHelper {
  static final _nombreBD="PATM2020";
  static final _versionBD=1;

  static Database _database;//_ indica que es un atributo privado
  Future<Database> get database async{
    if(_database!=null) return _database;
    _database =await _initDatabase();
    return _database;
  }
  
  _initDatabase() async {
    Directory  carpeta=await getApplicationDocumentsDirectory();
    String rutaDB=join(carpeta.path,_nombreBD);
    return await openDatabase(
      rutaDB,
      version: _versionBD,
      onCreate: _crearTablas
    );
  }
    //Conexion a la BD y le version
  _crearTablas(Database db, int version)async{
    await db.execute("CREATE TABLE tbl_perfil(id INTEGER PRIMARY KEY,nombre varchar(25),apellido varchar(25),telefono varchar(10),email varchar(30),curp varchar(18),username varchar(30),password varchar(30),foto varchar(200))");
    //await db.execute("create....");  
  }

  Future<int> insertar(Map<String, dynamic> row, String tabla)async{
    var dbClient= await database;
    return await dbClient.insert(tabla, row);
  }
  Future<int> actualizar(Map<String,dynamic> row,String tabla) async
  {
    var dbClient=await database;
    return await dbClient.update(tabla,row,where:'id=?',whereArgs:[row['id']]);
  }

  Future<int> eliminar(int id,String tabla) async{
    var dbClient= await database;
    return await dbClient.delete(tabla,where:'id=?', whereArgs: [id]);
  }

  Future<UserDAO> getUser(String mailUser)async{
    var dbClient=await database;
    var result= await dbClient.query('tbl_perfil',where: 'email=?', whereArgs: [mailUser]);
    //MAPEO
    var lista=(result).map((item) => UserDAO.fromJSON(item)).toList();
     return lista.length>0?lista[0]:null;
  }
 
}