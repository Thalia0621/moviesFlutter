
import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/databases/database_helper.dart';
import 'package:practica2/src/models/userDAO.dart';
import 'package:practica2/src/network/api_movies.dart';
import 'package:practica2/src/screen/profile.dart';
import 'package:practica2/src/utils/shared_prefs.dart';
import 'dart:io';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}): super (key:key);

 
@override
Widget build(BuildContext context) {
   DataBaseHelper _dataBase= DataBaseHelper();
   Future<UserDAO> _objUser= _dataBase.getUser('thaly.0621.tz@gmail.com');
  ApiMovies apiMovies=ApiMovies();
  apiMovies.getTrending();
  
  return Container(
    child:Scaffold(
      appBar: AppBar(
        backgroundColor: Configuration.colorapp,
        title:Text('Movies')
        ),
        drawer: Drawer(
          child: FutureBuilder(
                      future: _objUser,
                      builder:(BuildContext context, AsyncSnapshot<UserDAO> snapshot){
                        
                        return  ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                  color: Configuration.colorapp
                  ),
                  currentAccountPicture: snapshot.data==null
                    ? CircleAvatar(backgroundImage:NetworkImage(snapshot.data.foto),)
                    : ClipOval(child: Image.file(File(snapshot.data.foto),fit:BoxFit.cover,)),
                  
                   accountName: Text('Thalia Salinas'),
                   accountEmail: Text('16030620@itcelaya.edu.mx'),
                   onDetailsPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                   },
                ),
                ListTile(
                  leading: Icon(Icons.trending_up,color: Configuration.coloritems),
                  title: Text('Trending'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/trending');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.search,color: Configuration.coloritems),
                  title: Text('Search'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/search');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite,color: Configuration.coloritems),
                  title: Text('Favorites'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/favorites');
                  },
                ),
              
                ListTile(
                  leading: Icon(Icons.exit_to_app,color: Configuration.coloritems),
                  title: Text('Sing out'),
                  onTap: (){
                    SharedPrefs objPreferences= SharedPrefs();
                    objPreferences.removePref();//Borrar las preferencias
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/login');

                  },
                ),
                

            ],
            );
                      },
                     
          ),
        ) ,
      ),
    );
  
}
  
}

