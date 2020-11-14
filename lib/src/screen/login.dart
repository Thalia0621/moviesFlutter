import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/models/userDAO.dart';
import 'package:practica2/src/network/api_login.dart';
import 'package:practica2/src/screen/dashboard.dart';
import 'package:practica2/src/utils/shared_prefs.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  ApiLogin httpLogin=ApiLogin();
  SharedPrefs sharedPrefs = SharedPrefs();
  bool isValidating=false; //Variable para controlar la visualización del indicador de progreso
  @override
  Widget build(BuildContext context) {
    TextEditingController txtUser=TextEditingController();
    TextEditingController txtPass=TextEditingController();
 final checked=CheckboxListTile(
      title: Text('Stay signed in?'),
      secondary: Icon(Icons.account_box), activeColor: Configuration.colorapp,
       value: timeDilation != 1.0,
      onChanged: (bool value) {
        setState(() {
          timeDilation = value ? 2.0 : 1.0;
        });
       
      },
      );

    final txtEmail=TextFormField(
      controller:  txtUser,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: 'E-mail',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
      ),
    );
    final txtPwd=TextFormField(
      controller: txtPass,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(hintText: 'Password',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
      ),
    );
    final btnLogin=RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text('Sing In',style: TextStyle(color: Colors.white),),
      color: Colors.cyan,
      onPressed: ()async{
        setState(() {
          isValidating=true;
        });
        
       UserDAO objUser=UserDAO(username: txtUser.text, password:txtUser.text );
       httpLogin.valiateUser(objUser).then((token){
       print('TOKEN:' + token);
        if(token!=null)
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
        else{
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text('Error Sng In'),
                content: Text('The credentials are incorrect'),
                actions:<Widget> [
                  FlatButton(
                   child:Text('Close'),
                   onPressed: ()=>Navigator.of(context).pop(),
                   )
                ],
              );
            }
          );
        }   
        });
        if(checked.value)
        await sharedPrefs.setString("token", "user"); //Guarda la clave y su valor
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard())); 
      }//Async
                     
    );
    final logo= Image.network('http://itcelaya.edu.mx/admision/img/itcelaya2.png',height: 200,width: 150,);

   
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget> [
        //Widget para cargar una imagen de fondo
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images.jpeg'),
              fit: BoxFit.fitHeight
            )
          ),
        ),
        Card(
          color:Colors.white70,
          margin:  EdgeInsets.all(30.0),
          elevation: 8.0,
          child:Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              txtEmail,
              SizedBox(height: 10),
              txtPwd,
              SizedBox(height: 10),
              checked,
              SizedBox(height: 10),
              btnLogin,
              SizedBox(height: 30),
            ],
          ),
          ),
        ),
         Positioned(
           child: logo,
           top: 90,),
        Positioned(
          top: 280,
          child: isValidating?CircularProgressIndicator():Container()
          ),
      ],
    );
  
  }
}