
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:projet_1/likes.dart';
import '../jeumodel.dart';


class LikesCard extends StatelessWidget {
  final Jeux? jeu;
  final String? UserId;
   LikesCard({this.jeu, this.UserId});
  @override
  Widget build(BuildContext context) {
    //print(jeu?.nom);
    return Container(

      //decoration: BoxDecoration(
        //image : DecorationImage(
          //image : NetworkImage(jeu!.img!),

          //print(jeu!.img!),
        //)
      );

  }


}