import 'package:cloud_firestore/cloud_firestore.dart';

class Jeux{

  String? name, publisher, userID,  prix, img;

  Jeux({
    this.name,
    this.publisher,
    this.prix,
    this.img,
    this.userID,
});
}