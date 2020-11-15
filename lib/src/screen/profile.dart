import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/databases/database_helper.dart';
import 'package:practica2/src/models/userDAO.dart';
import 'package:practica2/src/screen/dashboard.dart';
//import 'package:practica2/src/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

    @override
  _ProfileState createState() => _ProfileState();
}
 class _ProfileState extends State<Profile> {
  String valorGuardado;
  String hintUserName,hintName,hintLastname,hintPassword,hintnumberPhone,hintcurp;
  DataBaseHelper _database;
  TextEditingController etUsername=TextEditingController();
  TextEditingController etPassword=TextEditingController();
  TextEditingController etName=TextEditingController();
  TextEditingController etLastname=TextEditingController();
  TextEditingController etNumberPhone=TextEditingController();
  TextEditingController etCurp=TextEditingController();
  String imagePath=""; 
  
  @override
  void initState() {
    super.initState();
    _database = DataBaseHelper();
    getEmail();
  
  }

 
  
 @override
  Widget build(BuildContext context) {
    
  
  //TextEditingController etemail=new TextEditingController();
    final picker=ImagePicker();  
    
    data();

    final btnCamera=IconButton(
             icon: Icon(Icons.camera_alt),
                tooltip: 'Change avatar',
                color: Colors.cyan[600],
                iconSize: 45,
                onPressed: () async {
               final pickerFile= await picker.getImage(source: ImageSource.camera);
                imagePath=pickerFile!=null ? pickerFile.path:"";
                print(imagePath);
                setState(() { });
                
              },
            );

    final imgFinal=imagePath == ""
    ? SizedBox(height: 180,width: 180, child: CircleAvatar(backgroundImage: 
    NetworkImage('https://orientacion.universia.edu.pe/imgs2011/imagenes/1k---2020--2020_05_30_182102@2x.386.jpg')))
    : ClipOval(

       child: Container(
      child: Align(
        alignment: Alignment.topLeft,
        widthFactor: 0.75,
        heightFactor: 0.75,

      child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,    
                ),
    )));

    //final avatar= SizedBox(height: 180,width: 180, child:imgFinal);
    final nombre= TextFormField(
      controller: etName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: 'hintName',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.person,color: Colors.cyan),
          
          ),
      ),
    );
    final apellido= TextFormField(
      controller:etLastname,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: 'hintLastname',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.person,color: Colors.cyan),
          
          ),
      ),
    );
    final username= TextFormField(
      controller: etUsername,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: 'hintUserName',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.person,color: Colors.cyan),
          
          ),
      ),
    );
    final password= TextFormField(
      controller: etPassword,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: 'Password',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.keyboard,color: Colors.cyan),
          
          ),
      ),
    );
    final email= TextFormField(
      enabled: false,
      //controller:etemail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: valorGuardado,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.email,color: Colors.cyan),
          
          ),
      ),
    );
    final numberphone= TextFormField(
      controller:etNumberPhone,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(hintText: 'Number Phone',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.phone,color: Colors.cyan),
          
          ),
      ),
    );
     final curp= TextFormField(
      controller:etCurp,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: 'Curp',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.qr_code,color: Colors.cyan),
          
          ),
      ),
    );
    //Nombre completo
    //Email
    //Telefono
    final btnsave=RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text('Save',style: TextStyle(color: Colors.white),),
      color: Colors.cyan,
      onPressed: () async{

      UserDAO user=UserDAO(
        nombre: etName.text,
        apellido:etLastname.text,
        telefono:etNumberPhone.text,
        email: valorGuardado,
        curp:    etCurp.text,
        password: etPassword.text,
        username:etUsername.text,
        foto:imagePath
      );
      print(valorGuardado+"*************************");
      UserDAO _objUser= await _database.getUser(valorGuardado); 
      if(_objUser==null){
        print(_objUser);
        _database.insertar(user.toJSON(),'tbl_perfil').then((rows)=>{print('$rows')});
      
      }
      else{
          user.id=_objUser.id;
        _database.actualizar(user.toJSON(),'tbl_perfil').then((rows)=>{print('$rows')});
      }
      //Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
      context,
       MaterialPageRoute(builder: (BuildContext context)=>Dashboard()),
       ModalRoute.withName('/login'));
      }, 
    );
    return Container(
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Configuration.colorapp,
          title: Text('Profile'),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/flor.jpg'),
                   fit: BoxFit.fitWidth
                )
              ),
            ),
           Card(
             color: Colors.white70,
             margin: EdgeInsets.all(30.0),
             child: Padding(
               padding: EdgeInsets.all(5),
               child: ListView(   
                 children: <Widget> [
                    imgFinal,
                    btnCamera,
                    email,
                    SizedBox(height: 10),
                    nombre,
                     SizedBox(height: 10),
                     apellido,
                     SizedBox(height: 10),
                    username,
                    SizedBox(height: 10),
                    password,
                    SizedBox(height: 10),
                    numberphone,
                     SizedBox(height: 10),
                    curp,
                    SizedBox(height: 30),
                    btnsave,
                 ],
              ),
             ),
           ),
          /*Positioned(
           top: 170,
           left: 210,
           child: btnCamera
           ),*/
          ],
        ),
        ),
    );
  }
  Future getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      valorGuardado=preferences.get("email")?? 'email@email.com';
    });
  }

  data()async{
    print("************VALOR GUARDADO"+valorGuardado+"+*******************);");
    UserDAO _objUser= await _database.getUser(valorGuardado); 
    if(_objUser==null){
      print("Null");
      hintUserName="Username";
      hintName="Name";
      hintLastname="LastName";
      hintPassword="Password";
      hintnumberPhone="Number Phone";
      hintcurp="Curp";
    }else{
      print(_objUser.foto );
      
      imagePath=_objUser.foto;
      etUsername.text = _objUser.username;
      etName.text= _objUser.nombre;
      etLastname.text  =_objUser.apellido; 
      etPassword.text= _objUser.password;
      etNumberPhone.text = _objUser.telefono;
      etCurp.text = _objUser.curp;
      
    
    }
  }
}