import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Jeux{

  String? nom, publisher, userID,  prix, Urlimg,description,review;
  Timestamp? jeuTimestamp;
  Jeux({
    this.nom,
    this.publisher,
    this.prix,
    this.Urlimg,
    this.userID,
    this.description,
    this.review,
    //this.jeuTimestamp,
});


}
