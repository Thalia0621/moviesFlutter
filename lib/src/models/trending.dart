// Generated by https://quicktype.io

class Trending {
  int page;
  int totalResults;
  int totalPages;
  List<Result> results;

  Trending({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });
}

class Result {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  String backdropPath;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  factory Result.fromJSON(Map<String,dynamic> map){
    return Result(
      popularity  : map['popularity'],
      voteCount   : map['vote_count'],
      video       : map['video'],
      posterPath  : map['poster_path'],
      id          : map['id'],
      backdropPath: map['backdrop_path'],
      title       : map['title'],
      voteAverage : map['vote_average'] is int?(map['vote_average']as int ).toDouble :  map['vote_average']  ,
      overview    : map['overview'],
      releaseDate : map['release_date']     
    );
  }

  Result({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.backdropPath,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  
}

enum OriginalLanguage { EN, JA, FR, KO }
