import 'package:cloud_firestore/cloud_firestore.dart';

///Classe Jeux permettant de remplir notre bdd dans Firestore
class Jeux{
  // ignore: non_constant_identifier_names
  String? nom, publisher, userID,  prix, Urlimg,description,review;
  Timestamp? jeuTimestamp;
  Jeux({
    this.nom,
    this.publisher,
    this.prix,
    // ignore: non_constant_identifier_names
    this.Urlimg,
    this.userID,
    this.description,
    this.review,
    this.jeuTimestamp,
});}