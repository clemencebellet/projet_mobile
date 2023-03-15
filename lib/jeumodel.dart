import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Jeux{

  String? nom, publisher, userID,  prix, Urlimg;
  Timestamp? jeuTimestamp;
  Jeux({
    this.nom,
    this.publisher,
    this.prix,
    this.Urlimg,
    this.userID,
    //this.jeuTimestamp,
});


}
