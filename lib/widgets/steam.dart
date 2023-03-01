import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SteamApiExample extends StatefulWidget {
  const SteamApiExample({super.key});

  @override
  _SteamApiExampleState createState() => _SteamApiExampleState();
}

class _SteamApiExampleState extends State<SteamApiExample> {
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

        topGames.add({
          "description": gameDescription,
        });
      }

      setState(() {
        _topGames = topGames;
        print(_topGames);
      });
    } catch (error) {
      print(error);
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

  @override
  void initState() {
    super.initState();
    _fetchTopGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top 10 Steam Games"),
      ),
      body: ListView.builder(
        itemCount: _topGames.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> game = _topGames[index];
          print(game);

          return ListTile(
            title: const Text("hello"),
            subtitle: Text(game['description']),
          );
        },
      ),
    );
  }
}
