
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'jeumodel.dart';


class Bdd{
final CollectionReference _jeux = FirebaseFirestore.instance.collection('jeux');

void addJeux(Jeux jeu )
{
  _jeux.add({
    "UserId" : jeu.userID,
    "nom": jeu.nom,
    "publisher " : jeu.publisher,
    "prix" : jeu.prix,
    "Urlimg" : jeu.Urlimg,
    "jeuTimestamp" : FieldValue.serverTimestamp(),
  });
}/*
Stream<List<Jeux>> get jeux {
  Query queryJeux = _jeux.orderBy('jeuTimestamp', descending: true);
  return queryJeux.snapshots().map((snapshot){
return snapshot.docs.map((doc){
  print(doc.data());
  return Jeux(
    nom: doc.get('nom'),
    publisher: doc.get('publisher'),
    prix: doc.get('prix'),
    Urlimg: doc.get('Urlimg'),
    jeuTimestamp: doc.get('jeuTimestamp'),
  );
}).toList();
  });

}*/
Future getGames(String userId) async{
List gameslikes =[];

  try{
    await _jeux.where("UserId", isEqualTo : userId).get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
gameslikes.add(element.data());
print("Ajout ${element.data()} to games ");
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

}