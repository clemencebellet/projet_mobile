import 'package:cloud_firestore/cloud_firestore.dart';
import 'jeumodel.dart';

/// Classe faisant la liaison avec Firestore
class Bdd{
  ///Collection pour regrouper les jeux likés qui s'appelera jeux sur Firestore
  final CollectionReference _jeux = FirebaseFirestore.instance.collection('jeux');

  ///Collection pour regrouper les jeux de souhaits  qui s'appelera wishlist sur Firestore
  final CollectionReference _wish = FirebaseFirestore.instance.collection('wishlist');

  ///Ajout des jeux à la collection des likes
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
    });}

  ///Ajout des jeux à la collection des souhaits
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
    });}

  ///Méthode pour récupérer les éléments de la collection 'jeux' à partir d'un UserId
  Future getGames(String userId) async{
    List gameslikes =[];

    try{
      await _jeux.where("UserId", isEqualTo : userId).get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          gameslikes.add(element.data());});});
      return gameslikes;
    }catch(e)
    {
      return null;
    }}

  ///Méthode pour récupérer les éléments de la collection 'wishlist' à partir d'un UserId
  Future getWish(String userId) async{
    List gameswish =[];

    try{
      await _wish.where("UserId", isEqualTo : userId).get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          gameswish.add(element.data());

        });}
      );
      return gameswish;
    }catch(e)
    {
      return null;
    }}}