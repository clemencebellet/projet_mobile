
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final List<dynamic> _searchResultat = [];


  bool isLoading = true;

  // ignore: non_constant_identifier_names
  Future<void> _SearchGames(String mot) async {
    String url = "https://steamcommunity.com/actions/SearchApps/$mot";

    try {
      final http.Response response = await http.get(Uri.parse(url));

      final List<dynamic> responseData = json.decode(response.body);

      final List<dynamic> gamesList = responseData;



      final List<dynamic> searchResultat = [];
      _searchResultat.clear();
      for (int i = 0; i < gamesList.length; i++) {
        final int appId = int.parse(gamesList[i]['appid']);

        final Object gameTitle = await _fetchGameTitle(appId);
        final Object gameInfos = await _fetchGameInfos(appId);
        final Object gameCover = await _fetchGameCover(appId);
        final Object gamePrice = await _fetchGamePrice(appId);
        final Object gameDescription = await _fetchGameDescription(appId);
        final Object gameReviews = await _fetchGameReviewsStar(appId);

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
        _searchResultat.clear();
        _searchResultat.addAll(searchResultat);
      });
    } finally {
      setState(() {
        isLoading = false;
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
          return gamePrice;
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
               color: Colors.white,
             ),
             color: Colors.white,
             onPressed: () {
               Navigator.pushNamed(context, '/accueil',
                   arguments: {'userId': userId});
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Voilà la liste des favoris')),
               );
             },
           ),

           title: const Text(
             textAlign: TextAlign.left,
             'Recherche',
             style: TextStyle(
               fontFamily: "GoogleSans-Bold",
               color: Colors.white,
               fontSize: 18,
             ),
           ),
           shadowColor: Colors.black,
           elevation: 40,

           backgroundColor: const Color(0xFF1A2025),
           // Put an icon heart and a star in the app bar
         ),
      body: isLoading ? const Center(child: CircularProgressIndicator())
    : Column(
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
                ),
              ),
            ),
          ),
           Text(
            textAlign: TextAlign.left,
            'Nombre de résultat : ${_searchResultat.length}',
            style: const TextStyle(
              fontFamily: "GoogleSans-Bold",
              color: Colors.white,
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),
      const SizedBox(height: 15,),
      Expanded(
      child : ListView.builder(
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
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

          ),
      )],
      ));
  }
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
