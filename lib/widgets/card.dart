import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// CardInfos  est un Stateful Widget car des éléments du Widget peuvent changer donc nécessitent une gestion d'état interne.
class CardInfos extends StatefulWidget {
  final String user;

  const CardInfos({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CardInfosState createState() => _CardInfosState();
}

class _CardInfosState extends State<CardInfos> {
  ///Liste des 10 meilleurs jeux
  List<dynamic> _topGames = [];
  ///Boolean pour l'affichage du loader
  bool isLoading = true;

  ///Methode pour récupérer les meilleurs jeux depuis API STEAM
  Future<void> _fetchTopGames() async {
    const String url = "https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      ///On fetch les data en fonction du ranks
      final List<dynamic> gamesList = responseData['response']['ranks'];
 ///On initialise une autre liste
      final List<dynamic> topGames = [];

      ///Récupération que des 10 meilleurs jeux
      for (int i = 0; i < 10; i++) {

        ///Récupération des appId des meilleurs jeux
        final int appId = gamesList[i]['appid'];

///On appelle nos méthodes pour récupérer les infos en fonction des appId :
        ///Titre - Publisher - Image - Prix - Description - Avis

        final Object gameTitle = await _fetchGameTitle(appId);
        final Object gameInfos = await _fetchGameInfos(appId);
        final Object gameCover = await _fetchGameCover(appId);
        final Object gamePrice = await _fetchGamePrice(appId);
        final Object gameDescription = await _fetchGameDescription(appId);
        final Object gameReviews = await _fetchGameReviewsStar(appId);

///Si aucune des données renvoyées est nulle on ajoute à notre liste topgames les infos récupérés
        if (gameInfos != Null &&
            gameCover != Null &&
            gamePrice != Null &&
            gameDescription != Null &&
            gameTitle != Null &&
            gameReviews != Null) {
          topGames.add({
            "title": gameTitle,
            "infos": gameInfos,
            "image": gameCover,
            "prix": gamePrice,
            "description": gameDescription,
            "review": gameReviews,
          });
        } else {
          // ignore: unnecessary_null_comparison
          _topGames == null;
        }}

      ///Notre liste rempli des infos transmet ces infos à l'autre liste
      setState(() {
        _topGames = topGames;
      });
    } finally {
      ///Une fois, la récupération faite le loader devient faux
      setState(() {
        isLoading = false;
      });}}

  ///Méthode pour récupérer l'image du jeu en fonction de l'appId
  Future<Object> _fetchGameCover(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameHeaderImage = gameDetails['header_image'];

      if (gameHeaderImage != Null) {
        return gameHeaderImage;
      } else {
        return Null;
      }
    } catch (error) {
      return "";
    }
  }
  ///Méthode pour récupérer le titre du jeu en fonction de l'appId
  Future<Object> _fetchGameTitle(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameTitle = gameDetails['name'];
      if (gameTitle != Null) {
        return gameTitle;
      } else {
        return Null;
      }
    } catch (error) {
      return "";
    }
  }

  ///Méthode pour récupérer l'avis global du jeu en fonction de l'appId
  Future<Object> _fetchGameReviewsStar(int appId) async {
    final String url =
        "https://store.steampowered.com/appreviews/$appId?json=1";
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameDetails = responseData['query_summary'];

      if (gameDetails.containsKey('review_score')) {
        final int gameReview = gameDetails['review_score'];
        if (gameReview != Null) {

          return gameReview.toString();
        } else {
          return Null;
        }
      } else {
        return "";
      }
    } catch (error) {
      return 0;
    }
  }

  ///Méthode pour récupérer la description  du jeu en fonction de l'appId
  Future<Object> _fetchGameDescription(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameDescription = gameDetails['detailed_description'];
      if (gameDescription != Null) {
        return gameDescription;
      } else {
        return Null;
      }
    } catch (error) {
      print(error);
      return "";
    }
  }

  ///Méthode pour récupérer le publisher du jeu en fonction de l'appId
  Future<Object> _fetchGameInfos(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";
    final List<dynamic> fin = [];

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final List<dynamic> gameInfos = gameDetails['publishers'];

      final List<dynamic> gamePublisher =
          gameInfos.map((e) => e.toString()).toList();
      if (gamePublisher != Null) {
        for (int i = 0; i < gamePublisher.length; ) {
          return gamePublisher[i].toString();
        }
        return gamePublisher;
      } else {
        return Null;
      }
    } catch (error) {
      print(error);
      return fin.toString();
    }
  }

  ///Méthode pour récupérer le prix du jeu en fonction de l'appId
  Future<Object> _fetchGamePrice(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails1 = gameData['data'];
      final Map<String, dynamic>? gameDetails = gameDetails1['price_overview'];

      if (gameDetails != null && gameDetails.containsKey('final_formatted')) {
        final String gamePrice = gameDetails['final_formatted'];
        if (gamePrice != Null) {
          return "$gamePrice";
        } else {
          return Null;
        }
      } else {
        return "0";
      }
    } catch (error) {
      return "";
    }
  }

///Récupération données dès la création du widget
  @override
  void initState() {
    super.initState();
    _fetchTopGames();
  }

  @override
  Widget build(BuildContext context) {
    ///Si isLoading est true, on affiche le loader
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        ///ListView permet d'avoir une liste scrollable, ici en fonction de la taille de _topgames
        body: ListView.builder(
            itemCount: _topGames.length,
            itemBuilder: (BuildContext context, int i) {
              final Map<Object, dynamic> game = _topGames[i]; // A voir si je remets pas linkedhash
              // ignore: unnecessary_null_comparison
              if (_topGames != null) {
                return SizedBox(
                  height: 130.16,
                  ///Création des Card pour chaque jeu
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          ///Application d'un filtre pour pas que l'image soit trop claire mais qu'elle soit +  au second plan
                            colorFilter: ColorFilter.mode(
                                const Color(0xFF1A2025).withOpacity(0.8),
                                BlendMode.modulate),
                            image: NetworkImage(game["image"]),
                            fit: BoxFit.cover),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(game["image"],
                              scale: 1.3, width: 140, height: 90),
                          const SizedBox(
                            width: 15,),
                          ///Les infos du jeu prennent un espace disponible flex : 2
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        game['title'],
                                        style: const TextStyle(
                                            fontFamily: 'ProximaNova-Regular',
                                            fontSize: 16.0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),),),
                                    SizedBox(
                                      width: 200,
                                      child: Text(game['infos'],
                                          style: const TextStyle(
                                              fontFamily: 'ProximaNova-Regular',
                                              fontSize: 15.0,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255))),),
                                    SizedBox(
                                      width: 200,
                                      child: Text("Prix : " + game['prix'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              fontFamily: 'ProximaNova-Regular',
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255))),
                                    ),]),),),
                          ///Le bouton  prend un espace disponible flex : 1
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/detail',
                                    arguments: {
                                      'title': game['title'],
                                      'image': game["image"],
                                      'infos': game['infos'],
                                      'description': game['description'],
                                      'review': game['review'],
                                      'prix': game['prix'],
                                      'userId': widget.user
                                    });},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF636AF6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 45),),
                              child: const Text('En savoir \n    plus',
                                  style:  TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'ProximaNova-Regular',
                                      color: Colors.white)),
                            ),),
                        ],),),),
                );
              } else {
                const Text(
                  'Problème au niveau de la liste de jeu de API STEAM, veuillez recharger la page',
                );
              }
              return null;}),
      );}}}


class CardData {
  final String title;
  final String prix;
  final String infos;
  final String image;
  final String description;
  final String review;

  CardData(
      {required this.title,
      required this.infos,
      required this.image,
      required this.prix,
      required this.description,
      required this.review});

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
