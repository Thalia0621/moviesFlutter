import 'package:flutter/material.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/network/api_movies.dart';
import 'package:practica2/src/views/card_trending.dart';


class Trending extends StatefulWidget {
    const Trending({Key key}) : super(key: key);

  @override
  _TrendingState createState()=> _TrendingState();  
  }
  
  class _TrendingState extends State<Trending>{
    ApiMovies apiMovies;
  @override
  void initState(){
    super.initState();
    apiMovies=ApiMovies();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Trending Movies '),
         ),
         body: FutureBuilder(
           future: apiMovies.getTrending(),
           builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot){
             if(snapshot.hasError){
               return Center(
                 child: Text("Has error in this request :("),
              );
             }else if(snapshot.connectionState==ConnectionState.done){
               return ListView();
             }else{
               return Center(
                 child:CircularProgressIndicator(),
                 
               );
             }
           }
        ),
    );
  
  }
  Widget _listTrending(List<Result>movies){
    return ListView.builder(
      itemBuilder: (context,index){
          Result trending=movies[index];
          return CardTrending(trending: trending);
      },
      itemCount: movies.length
    );
  }
}