import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/databases/database_helper.dart';
import 'package:practica2/src/models/userDAO.dart';
import 'package:practica2/src/screen/dashboard.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

    @override
  _ProfileState createState() => _ProfileState();
}
 class _ProfileState extends State<Profile> {
   DataBaseHelper _database;
  Widget build(BuildContext context) {
    TextEditingController etUsername = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();
   TextEditingController etName = new TextEditingController();
    TextEditingController etLastname = new TextEditingController();
     TextEditingController etemail = new TextEditingController();
      TextEditingController etNumberPhone = new TextEditingController();
     TextEditingController etCurp = new TextEditingController();


    String imagePath="";
    final picker=ImagePicker();

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
    ? SizedBox(height: 180,width: 180, child: CircleAvatar(backgroundImage: NetworkImage('https://orientacion.universia.edu.pe/imgs2011/imagenes/1k---2020--2020_05_30_182102@2x.386.jpg')))
    : ClipOval(
      child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,    
                ),
    );

    //final avatar= SizedBox(height: 180,width: 180, child:imgFinal);
    final nombre= TextFormField(
      controller: etName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: 'Name',
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
      decoration: InputDecoration(hintText: 'Last Name',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.person,color: Colors.cyan),
          
          ),
      ),
    );
    final email= TextFormField(
      controller: etemail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: 'E-mail',
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
      decoration: InputDecoration(hintText: 'CURP',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      prefixIcon:  Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.email,color: Colors.cyan),
          
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
      onPressed: (){

      UserDAO user=UserDAO(
        nombre: etName.text,
        apellido:etLastname.text,
        telefono:etNumberPhone.text,
        email: etemail.text,
        curp:    etCurp.text,
        password: etPassword.text,
        username:etUsername.text,
        foto:imagePath
      );
      _database.insertar(user.toJSON(),'tbl_user').then((rows)=>{print('$rows')});
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
          title: Text('Thalia Salinas'),
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
                    SizedBox(height: 20),
                    nombre,
                    SizedBox(height: 10),
                    apellido,
                     SizedBox(height: 10),
                    email,
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
          Positioned(
           top: 170,
           left: 210,
           child: btnCamera
           ),
          ],
        ),
        ),
    );
  }
}