import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CardInfos extends StatefulWidget {
    final String user ;
  const  CardInfos({Key? key, required  this.user}) : super(key:key);

  @override
  _CardInfosState createState() => _CardInfosState();
}

class _CardInfosState extends State<CardInfos> {
  List<dynamic> _topGames = [];
   List<dynamic> jeux =[];
  bool isLoading = true;




  Future<void> _fetchTopGames() async {

    const String url =
        "https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);

    final List<dynamic> gamesList = responseData['response']['ranks'];

      final List<dynamic> topGames = [];


      for (int i = 0; i < 10; i++) {
        final int appId = gamesList[i]['appid'];


    final Object gameTitle = await _fetchGameTitle(appId);
        final Object gameInfos = await _fetchGameInfos(appId);
        final Object gameCover = await _fetchGameCover(appId);
        final Object gamePrice = await _fetchGamePrice(appId);
        final Object gameDescription = await _fetchGameDescription(appId);
        final Object gameReviews = await _fetchGameReviewsStar(appId);

if(gameInfos!=Null && gameCover!=Null && gamePrice!=Null && gameDescription !=Null && gameTitle != Null && gameReviews != Null)
  {
        topGames.add({
          "title": gameTitle,
          "infos": gameInfos,
          "image": gameCover,
          "prix" : gamePrice,
          "description" : gameDescription,
          "review" : gameReviews,


        });
      }
else {
  _topGames == null;
}}

      setState(() {
        _topGames = topGames;

      });
    } catch (error) {
      print(error);
    }finally {
      setState(() {
        isLoading = false;
        print('loading passe en faux');
      });
    }
  }





  Future<Object> _fetchGameCover(int appId) async {


    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";


    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameHeaderImage = gameDetails['header_image'];

if(gameHeaderImage!=Null)
  {
    return gameHeaderImage;
  }
else{
  return Null;
}

    } catch (error) {
      print(error);
      return "";
    }
  }

  Future<Object> _fetchGameTitle(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameTitle = gameDetails['name'];
      if(gameTitle!=Null)
        {
          return gameTitle;
        }
      else{
        return Null;
      }

    } catch (error) {
      print(error);
      return "";
    }
  }

  Future<Object> _fetchGameReviewsStar(int appId) async {

    final String url =
        "https://store.steampowered.com/appreviews/$appId?json=1";
    final int e ;
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameDetails = responseData['query_summary'];

      if (gameDetails != null && gameDetails.containsKey('review_score') ) {
        final int gameReview = gameDetails['review_score'];
if(gameReview!=Null)
  {
    print(gameReview);
    return gameReview.toString();
  }
else{
  return Null;
}

      } else {
        print('Aucune note trouvée pour l\'application $appId.');
        return "";
      }


    } catch (error) {
      print(error);
      return 0;
    }
  }

  Future<Object> _fetchGameDescription(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameDescription = gameDetails['detailed_description'];
if(gameDescription!=Null)
  {
    return gameDescription;
  }
else{
  return Null;
}

    } catch (error) {
      print(error);
      return "";
    }
  }

  Future<Object> _fetchGameInfos(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";
    final List<dynamic> fin=[];



    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final List<dynamic> gameInfos = gameDetails['publishers'];


      final List<String> gamePublisher = gameInfos.map((e) => e.toString()).toList();
if(gamePublisher!=Null)
  {
    for(int i=0; i < gamePublisher.length; i++){
      return gamePublisher[i].toString(); }
    return gamePublisher;
  }
else{
  return Null;
}

    } catch (error) {
      print(error);
      return fin;
    }
  }

  Future<Object> _fetchGamePrice(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails1 = gameData['data'];
      final Map<String, dynamic>? gameDetails = gameDetails1['price_overview'];

      if(gameDetails != null && gameDetails.containsKey('final_formatted')) {
        final String gamePrice = gameDetails['final_formatted'];
if(gamePrice!=Null)
  {
    return "Prix :$gamePrice";
  }
else{
  return Null;
}

      } else {

        return "0";
      }
    } catch (error) {
      print(error);
      return "";
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchTopGames();

  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator()
      );
    }
    else  {
    return Scaffold(

      body: ListView.builder(

        itemCount: _topGames.length,
        itemBuilder: (BuildContext context, int i) {


            final LinkedHashMap<Object, dynamic> game = _topGames[i];
            if (_topGames!=null) {
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: Container(
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                        colorFilter:
                        ColorFilter.mode( Color(0xFF1A2025).withOpacity(0.5),
                            BlendMode.modulate),

                        image: NetworkImage(game["image"]),
                        fit: BoxFit.cover),

                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                          game["image"], scale: 1.3, width: 140, height: 90),
                      Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                game['title'],
                                style: const TextStyle(

                                    fontFamily: 'ProximaNova-Regular',
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                  game['infos'],
                                  style: const TextStyle(

                                      fontFamily: 'ProximaNova-Regular',
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 255, 255, 255))
                              ),
                            ),
                            SizedBox(
                              width: 200,

                              child: Text(

                                  game['prix'],
                                  style: const TextStyle(

                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      fontFamily: 'ProximaNova-Regular',

                                      color: Color.fromARGB(255, 255, 255, 255))
                              ),
                            ),


                          ]),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/detail', arguments: {
                            'title': game['title'],
                            'image': game["image"],
                            'infos': game['infos'],
                            'description': game['description'],
                            'review': game['review'],
                            'prix': game['prix'],
                            'userId': widget.user
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF636AF6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 90),
                        ),
                        child: const Text(
                          'En savoir plus',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            else {
              child:
              const Text(
                'Problème au niveau de la liste de jeu de API STEAM, veuillez recharger la page',
              );
            }
}
      ),

    );
  }
}
}

class CardData {
  final String title;
  final String prix;
  final List<dynamic> infos;
  final String image;
  final String description;
  final String review;

  CardData(
      {required this.title,required this.infos,required this.image,required this.prix,required this.description,required this.review});

  factory CardData.fromJson(Map<List<dynamic>, dynamic> json) {
    return CardData(
      title: json['title'],
      infos: json['infos'],
      image: json['image'],
      prix: json['prix'],
      description: json['description'],
      review: json['review'],

    );
  }
}
