import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  List<dynamic> _topGames = [];

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

        final String gameDescription = await _fetchGameDescription(appId);
        final String gameTitle = await _fetchGameTitle(appId);
        final String gamePublisher = await _fetchGamePublisher(appId);
        final String gameCover = await _fetchGameCover(appId);
        final String gamePrice = await _fetchGamePrice(appId);

        topGames.add({
          "title": gameTitle,
          //"publisher": gamePublisher,
          //"description": gameDescription,
          "prix": gamePrice,
          //"image": "assets/Jacket.png",
          "cover": gameCover,
        });
      }

      setState(() {
        _topGames = topGames;
      });
    } catch (error) {
      print(error);
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

  Future<String> _fetchGamePublisher(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails = gameData['data'];
      final String gamePublisher = gameDetails['developers'];

      print(gamePublisher);

      return gamePublisher;
    } catch (error) {
      print(error);
      return "";
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
      final String gameDescription = gameDetails['short_description'];

      return gameDescription;
    } catch (error) {
      print(error);
      return "";
    }
  }

  Future<String> _fetchGamePrice(int appId) async {
    final String url =
        "https://store.steampowered.com/api/appdetails?appids=$appId";
final Future<Null> essai;
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> gameData = responseData["$appId"];
      final Map<String, dynamic> gameDetails1 = gameData['data'];
      final Map<String, dynamic> gameDetails = gameDetails1['price_overview'];

      if(gameDetails != null && gameDetails.containsKey('final_formatted')) {
        final String gamePrice = gameDetails['final_formatted'];
        print(gamePrice);
        return gamePrice;
      } else {
        print("0");
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
    return Scaffold(
      body: ListView.builder(
        itemCount: _topGames.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> game = _topGames[index];
          return Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    12.0), // sets the rounded corners of the card's content area
                color: const Color.fromARGB(30, 38, 44, 100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                        0.8), // sets the color of the card's shadow
                    spreadRadius: 5, // sets how far the shadow spreads
                  ),
                ], // sets the background color of the card's content area
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(game["image"], scale: 1.3),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            game['title'],
                            style: const TextStyle(
                                fontFamily: 'ProximaNova-Regular',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),


                        SizedBox(
                          width: 200,
                          child: Text(
                            game['price'],
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ]),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('En savoir plus')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 70),
                    ),
                    child: const Text(
                      'En savoir plus',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardData {
  final String title;
  final String description;
  final String image;

  CardData(
      {required this.title, required this.description, required this.image});

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
