
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  /*Metodo Guarda un valor string y asociado con la clave.*/

   Future < bool > setString(String indice, String value) async { 
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.setString(indice, value);
    }

//Método que lee la información de la sesión si no está creada regresa null
    Future < String > getString(String indice) async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      //Si el valor no está presente en el almacenamiento, podríamos obtener un valor nulo.
      String value = preferences.getString(indice) ?? null; 
      return value;
    }

//Método que borra las preferencias guardadas
    Future < bool > removePref() async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.clear();
    }
}