import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_1/inscription.dart';
import 'package:firebase_core/firebase_core.dart';

class Accueil extends StatefulWidget {
  const Accueil
      ({super.key});

  @override
  _AccueilState createState() => _AccueilState();
}



class _AccueilState extends State<Accueil> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body : CustomScrollView(
        slivers: [SliverAppBar.large(
          leading: IconButton(
        onPressed: (){},
        icon : Icon(Icons.menu),
          ),
          title: Text('Accueil'),
          actions: [IconButton(onPressed: (){},icon: Icon(Icons.more_vert))],
        )] ,
      ),


        );



  }
}

/*
Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.png"),
                fit: BoxFit.cover),
          )
 */