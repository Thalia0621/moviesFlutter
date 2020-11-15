import 'package:flutter/material.dart';
import 'package:practica2/src/screen/dashboard.dart';
import 'package:practica2/src/screen/favoritos.dart';
import 'package:practica2/src/screen/login.dart';
import 'package:practica2/src/screen/profile.dart';
import 'package:practica2/src/screen/search.dart';
import 'package:practica2/src/screen/trending.dart';
import 'package:practica2/src/utils/shared_prefs.dart';

Future< void> main() async {
WidgetsFlutterBinding.ensureInitialized();
SharedPrefs preferences=SharedPrefs();
//Se encarga de leer los datos almanecnados, a través de la clave
String value=await preferences.getString("token");
//String u=await preferences.getString("email");
//print('(**************************'+u);
//Si el valor está presente hay una sesión iniciada, y nos enviará al Dashboard
//Si no enviará un valor null y nos enviará a uniciar sesión. 
  runApp(value!=null?SingInApp():MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({Key key}):super(key: key);

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/trending': (BuildContext context)=> Trending(),
        '/search': (BuildContext context)=> Search(),
        '/favorites': (BuildContext context)=> Favorites(),      
        '/profile': (BuildContext context)=> Profile(),
        '/login':(BuildContext context)=>Login(), 
        '/dashboard':(BuildContext context)=>Dashboard(),     
      },
      home: Login(),
    );
  }
}
  
class SingInApp extends StatelessWidget 
{
  const SingInApp({Key key}):super(key: key);

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/trending': (BuildContext context)=> Trending(),
        '/search': (BuildContext context)=> Search(),
        '/favorites': (BuildContext context)=> Favorites(),      
        '/profile': (BuildContext context)=> Profile(),
        '/login':(BuildContext context)=>Login(),      
      },
      home: Dashboard(),
    );
  }
}