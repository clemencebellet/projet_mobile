
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import './bdd.dart';


class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key) {
  }

  @override
  _SearchState createState() => _SearchState();
}


class _SearchState extends State<Search> {
  bool isLoading = false;


//URL a UTILISER pour search : https://steamcommunity.com/actions/SearchApps/PUBG
  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
    ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;
    TextEditingController search = args['search']; //mot recuperer de la recherche
    String userId = args['userId'];

    print(search);
    return Scaffold(
      backgroundColor: const Color(0xFF1A2025),

      appBar: AppBar(


        leading : IconButton(
          icon: SvgPicture.asset('Icones/close.svg'),
          color: Colors.white,

          onPressed: () {
            Navigator.pushNamed(context,'/accueil',arguments : {'userId': userId});

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

    );
  }}

