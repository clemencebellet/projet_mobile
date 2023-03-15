import 'dart:collection';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

import 'dart:typed_data';

import 'package:projet_1/detail.dart';

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


    final String gameTitle = await _fetchGameTitle(appId);
        final Object gameInfos = await _fetchGameInfos(appId);
        final String gameCover = await _fetchGameCover(appId);
        final String gamePrice = await _fetchGamePrice(appId);
        final String gameDescription = await _fetchGameDescription(appId);
        final Object gameReviews = await _fetchGameReviewsStar(appId);

        topGames.add({
          "title": gameTitle,
          "infos": gameInfos,
          "image": gameCover,
          "prix" : gamePrice,
          "description" : gameDescription,
          "review" : gameReviews,


        });
      }

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





  Future<String> _fetchGameCover(int appId) async {


    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";


    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameHeaderImage = gameDetails['header_image'];


      return gameHeaderImage;
    } catch (error) {
      print(error);
      return "";
    }
  }

  Future<String> _fetchGameTitle(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameTitle = gameDetails['name'];
      return gameTitle;
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

        print(gameReview);
        return gameReview.toString();
      } else {
        print('Aucune note trouvée pour l\'application $appId.');
        return "";
      }


    } catch (error) {
      print(error);
      return 0;
    }
  }

  Future<String> _fetchGameDescription(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameDescription = gameDetails['detailed_description'];

      return gameDescription;
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

      for(int i=0; i < gamePublisher.length; i++){
        return gamePublisher[i].toString(); }
      return gamePublisher;
    } catch (error) {
      print(error);
      return fin;
    }
  }

  Future<String> _fetchGamePrice(int appId) async {
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

        return "Prix :$gamePrice";
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
      return Center(
          child: CircularProgressIndicator()
      );
    }
    else  {
    return Scaffold(

      body: ListView.builder(

        itemCount: _topGames.length,
        itemBuilder: (BuildContext context, int i) {

            final LinkedHashMap<Object, dynamic> game = _topGames[i];
            if (_topGames.length != 0) {
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/fondcard.png"),
                        fit: BoxFit.cover),

                    color: Color(0xFF1A2025),
                    // sets the background color of the card's content area
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
                'Problème au niveau de la liste de jeu de API STEAM',
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
