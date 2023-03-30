
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Search  est un Stateful Widget car des éléments du Widget peuvent changer donc nécessitent une gestion d'état interne.
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ///Liste des jeux recherchés
  final List<dynamic> _searchResultat = [];
  ///Boolean du loader vrai
  bool isLoading = true;

  ///Méthode pour la recherche en fonction du mot en argument
  // ignore: non_constant_identifier_names
  Future<void> _SearchGames(String mot) async {
    String url = "https://steamcommunity.com/actions/SearchApps/$mot";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final List<dynamic> responseData = json.decode(response.body);
      final List<dynamic> gamesList = responseData;

      ///Création d'une nouvelle liste pour ajouter les jeux
      final List<dynamic> searchResultat = [];

      ///On efface la liste avant de rajouter des nouveaux jeux
      _searchResultat.clear();

      ///On ajoute autant de jeux que l'API trouve pour le mot saisi
      for (int i = 0; i < gamesList.length; i++) {

        ///Récupération des appId des jeux trouvés en fonction du mot
        final int appId = int.parse(gamesList[i]['appid']);


        ///On appelle nos méthodes pour récupérer les infos en fonction des appId :
        ///Titre - Publisher - Image - Prix - Description - Avis
        ///
        final Object gameTitle = await _fetchGameTitle(appId);
        final Object gameInfos = await _fetchGameInfos(appId);
        final Object gameCover = await _fetchGameCover(appId);
        final Object gamePrice = await _fetchGamePrice(appId);
        final Object gameDescription = await _fetchGameDescription(appId);
        final Object gameReviews = await _fetchGameReviewsStar(appId);
        ///on ajoute à notre liste searchResultat les infos récupérés
    searchResultat.add({
          "title": gameTitle,
          "infos": gameInfos,
          "image": gameCover,
          "prix": gamePrice,
          "description": gameDescription,
          "review": gameReviews,
        });

      }

      setState(() {
        ///Notre liste rempli des infos transmet ces infos à l'autre liste
        _searchResultat.addAll(searchResultat);
      });
    } ///Une fois la récupération faite, le loader devient faux
    finally {
      setState(() {
        isLoading = false;
      });
    }
  }
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

      // ignore: unnecessary_null_comparison
      if (gameHeaderImage != null) {
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
      // ignore: unnecessary_null_comparison
      if (gameTitle != null) {
        return gameTitle;
      } else {
        return Null;
      }
    } catch (error) {
      return "";
    }
  }

  ///Méthode pour récupérer l'avis  du jeu en fonction de l'appId
  Future<Object> _fetchGameReviewsStar(int appId) async {
    final String url =
        "https://store.steampowered.com/appreviews/$appId?json=1";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameDetails = responseData['query_summary'];

      if (gameDetails.containsKey('review_score')) {
        final int gameReview = gameDetails['review_score'];
        // ignore: unnecessary_null_comparison
        if (gameReview != null) {
          return gameReview.toString();
        } else {
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
  ///Méthode pour récupérer la description du jeu en fonction de l'appId
  Future<Object> _fetchGameDescription(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gameDescription = gameDetails['detailed_description'];
      // ignore: unnecessary_null_comparison
      if (gameDescription != null) {
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
      // ignore: unnecessary_null_comparison
      if (gamePublisher != null) {
        for (int i = 0; i < gamePublisher.length;) {
          return gamePublisher[i].toString();
        }
        return gamePublisher;
      } else {
        return Null;
      }
    } catch (error) {
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
        if (gamePrice != null) {
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
 ///Utilisation de didChangeDependencies plutot que InitState :
  ///Car cette fonction va être appelée a chaque changement des dépendances du widget
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String search = args['search'];
    _SearchGames(search);
  }

  @override
  Widget build(BuildContext context) {
    ///On récupére le mot et l'id de l'utilisateur
    Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String userId = args['userId'];
    String searchmot = args['search'];

     return Scaffold(
         backgroundColor: const Color(0xFF1A2025),
         appBar: AppBar(
           leading: IconButton(
             icon: const Icon(
               Icons.close,
               color: Colors.white,),
             color: Colors.white,
             onPressed: () {
               Navigator.pushNamed(context, '/accueil',
                   arguments: {'userId': userId});},),

           title: const Text(
             textAlign: TextAlign.left,
             'Recherche',
             style: TextStyle(
               fontFamily: "GoogleSans-Bold",
               color: Colors.white,
               fontSize: 18,
             ),),
           shadowColor: Colors.black,
           elevation: 40,
           backgroundColor: const Color(0xFF1A2025),),

      body: isLoading ? const Center(child: CircularProgressIndicator())
    : Column(
        ///Affichage de la barre de recherche avec le mot saisi
        children :[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration:  InputDecoration(
                labelText: ' $searchmot ',
                labelStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1E262C) ,
                suffixIcon: const Icon(Icons.search, color: Color(0xFF636AF6), size: 30.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color(0xFF1E262C), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),),),),
           ///Nombre de résultat de jeux récupérés
           Text(
            textAlign: TextAlign.left,
            'Nombre de résultat : ${_searchResultat.length}',
            style: const TextStyle(
              fontFamily: "GoogleSans-Bold",
              color: Colors.white,
              fontSize: 18,
              decoration: TextDecoration.underline,),),

      const SizedBox(height: 15,),

      Expanded(
        ///blindage recherche
        child : _searchResultat.isEmpty ?  const Text(
          textAlign: TextAlign.center,
          'Aucun jeux ne correspond à votre recherche ',
          style: TextStyle(
            fontFamily: "GoogleSans-Bold",
            color: Colors.white,
            fontSize: 18,),)
       : ListView.builder(
          ///tri des jeux en fonction de la taille de la liste
          itemCount: _searchResultat.length,
          itemBuilder: (BuildContext context, int i) {
            final Map<Object, dynamic> game = _searchResultat[i];
              return SizedBox(
                height: 130.16,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              const Color(0xFF1A2025).withOpacity(0.8),
                              BlendMode.modulate),
                          image: NetworkImage(game["image"]),
                          fit: BoxFit.cover),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(game["image"],
                            scale: 1.3, width: 140, height: 90),
                        const SizedBox(
                          width: 15,
                        ),
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
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(game['infos'],
                                        style: const TextStyle(
                                            fontFamily: 'ProximaNova-Regular',
                                            fontSize: 15.0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text("Prix : " + game['prix'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            fontFamily: 'ProximaNova-Regular',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ),
                                ]),
                          ),
                        ),
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
                                    'userId': userId
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF636AF6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 45),
                            ),
                            child: const Text('En savoir \n    plus',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'ProximaNova-Regular',
                                    color: Colors.white)),),
                        ),],),),
                ),);}),
      )],));}
}
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
