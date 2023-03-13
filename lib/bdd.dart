
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'jeumodel.dart';


class Bdd{
CollectionReference _jeux = FirebaseFirestore.instance.collection('jeux');
FirebaseStorage _storage = FirebaseStorage.instance;



void addJeux(Jeux jeu )
{
  _jeux.add({
    "UserId" : jeu.userID,
    "nom":jeu.name,
    "publisher " : jeu.publisher,
    "prix" : jeu.prix,
    "Urlimg" : jeu.img,
  });
}
}