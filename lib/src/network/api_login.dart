import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/userDAO.dart';

class ApiLogin {

final String ENDPOINT="http://192.168.1.73:8888/singup"; 
  Client http= Client();

  Future<String> valiateUser(UserDAO objUser)async{
    final response=await http.post(
      '$ENDPOINT',
      headers: <String,String>{
        'Content-Type':'aplication/json; charset=UTF-8',
      },
      body: objUser.userToJson() 
    );
    if(response.statusCode==200)
      return response.body;
    else
      return null; 
  }

}
