import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/trending.dart';
class ApiMovies {
 
 final String URL_TRENDING="https://api.themoviedb.org/3/movie/popular?api_key=deefa70ddf1b399469f323e9af93e957&language=es-MX&page=1";
 Client http=Client();
 Future<List<Result>> getTrending() async{
   final response =await http.get(URL_TRENDING);

   if(response.statusCode==200){
     var movies= jsonDecode(response.body)['results'] as List;
     List<Result> listMovies=movies.map((movie) => Result.fromJSON(movie));
    print (movies);
    return listMovies;
   }
   else return null;

 }
}