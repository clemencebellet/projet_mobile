
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'jeumodel.dart';


class Bdd{
  final CollectionReference _jeux = FirebaseFirestore.instance.collection('jeux');
  final CollectionReference _wish = FirebaseFirestore.instance.collection('wishlist');

  void addJeux(Jeux jeu )
  {
    _jeux.add({
      "UserId" : jeu.userID,
      "nom": jeu.nom,
      "publisher" : jeu.publisher,
      "prix" : jeu.prix,
      "Urlimg" : jeu.Urlimg,
      "description" : jeu.description,
      "review" : jeu.review,
      "jeuTimestamp" : FieldValue.serverTimestamp(),
    });
  }

  void addWish(Jeux jeu )
  {
    _wish.add({
      "UserId" : jeu.userID,
      "nom": jeu.nom,
      "publisher" : jeu.publisher,
      "prix" : jeu.prix,
      "Urlimg" : jeu.Urlimg,
      "description" : jeu.description,
      "review" : jeu.review,
      "jeuTimestamp" : FieldValue.serverTimestamp(),
    });
  }

  Future getGames(String userId) async{
    List gameslikes =[];

    try{
      await _jeux.where("UserId", isEqualTo : userId).get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          gameslikes.add(element.data());

        });
      }
      );
      return gameslikes;
    }catch(e)
    {
      print(e.toString());
      return null;

    }

  }


  Future getWish(String userId) async{
    List gameswish =[];

    try{
      await _wish.where("UserId", isEqualTo : userId).get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          gameswish.add(element.data());
          print("Ajout ${element.data()} to games ");
        });
      }
      );
      return gameswish;
    }catch(e)
    {
      print(e.toString());
      return null;

    }

  }




}