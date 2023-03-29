import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:projet_1/bdd.dart';
import 'package:projet_1/jeumodel.dart';


/// Detail  est un Stateful Widget car des éléments du Widget peuvent changer donc nécessitent une gestion d'état interne.
class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  ///Couleur initiale des boutons description et avis
  Color _colorbuttonDescription = const Color(0xFF1A2025);
  Color _colorbuttonAvis = const Color(0xFF1A2025);

  ///Boolean pour les boutons likes et wishlist
  bool wishlist =false;
  bool likes = false;

///Boolean pour les boutons description et avis
  bool isPressedDescription = false;
  bool isPressedAvis = false;

  ///Scroll pour le listView
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ///Récuperation des toutes les informations d'un jeu
    Map<String, dynamic> args = ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;

    String title = args['title'];
    String userId = args['userId'];
    String image = args['image'];
    String infos = args['infos'];
    String prix = args['prix'];
    String description = args['description'];
    String reviews = args['review'];
    double reviewsinteger = double.parse(reviews);


    return Scaffold(
        backgroundColor: const Color(0xFF1A2025),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, '/accueil',
                  arguments: {'userId': userId});},),
          title: const Text(
            textAlign: TextAlign.left,
            'Détail du jeu ',
            style: TextStyle(
              fontFamily: "GoogleSans-Bold",
              color: Colors.white,
              fontSize: 18,),),
          shadowColor: Colors.black,
          elevation: 40,
          backgroundColor: const Color(0xFF1A2025),

          actions: <Widget>[
            IconButton(
              ///Si le bouton likes est pressé likes devient true et l'icône change
              onPressed: () {
                setState(() {
                  likes=!likes;
                });
                ///Instance de la bdd et on ajoute le jeu qui a été liké
                Bdd backend = Bdd();
                backend.addJeux(Jeux(
                  nom: title,
                  publisher: infos,
                  prix: prix,
                  Urlimg: image,
                  userID: userId,
                  description: description,
                  review: reviews,
                ));},
              ///Changement de l'icône si likes est true
        icon:  Icon(
      likes ? Icons.favorite : Icons.favorite_border,
      color: Colors.white,
    ),),
            IconButton(
              ///Si le bouton wishlist est pressé likes devient true et l'icône change
              onPressed: () {
                setState(() {
                  wishlist=!wishlist;
                });
                ///Instance de la bdd et on ajoute le jeu qui a été souhaité
                Bdd backend = Bdd();
                backend.addWish(Jeux(
                  nom: title,
                  publisher: infos,
                  prix: prix,
                  Urlimg: image,
                  userID: userId,
                  description: description,
                  review: reviews,
                ));
              },
              ///Changement de l'icône si wishlist est true
              icon:  Icon(
                wishlist ? Icons.star  : Icons.star_border,
                color: Colors.white,),),],),

        ///ListView permet d'avoir une liste scrollable
        body: ListView(controller: scroll, children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    height: 297.1,
                    width: double.infinity,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,),),
                  Positioned(
                    bottom: 0,
                    left: 20,
                    right: 20,
                    ///Création des Card pour chaque jeu
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,),
                      child: Container(
                        height: 110,
                        decoration:  BoxDecoration(
                          image: DecorationImage(
                              colorFilter:
                                  ///Application d'un filtre pour pas que l'image soit trop claire mais qu'elle soit +  au second plan
                              ColorFilter.mode( Color(0xFF1A2025).withOpacity(0.8),
                                  BlendMode.modulate),
                              image: NetworkImage(image),
                              fit: BoxFit.cover),),

                        child: Row(
                          children: [
                            ///L'image de la carte prend un espace disponible : 1/3
                            Expanded(
                              flex:1,
                            child: Image.network(image,
                                scale: 1.3, width: 140, height: 90),),
                            const SizedBox(width: 10),
                            ///Les infos prennent un espace disponible : 1/3
                            Expanded(
                              flex: 1,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                   SizedBox(
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                          fontFamily: 'ProximaNova-Regular',
                                          fontSize: 18.0,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),),),
                                  SizedBox(
                                    width: 200,
                                    child: Text(infos,
                                        style: const TextStyle(
                                            fontFamily: 'ProximaNova-Regular',
                                            fontSize: 15.0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),),
                                ]),),],),
                      ),),),],),
              const SizedBox(height: 30),
              Center(
                child: Container(
                    width: 400,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.52),
                        border: Border.all(
                          color: const Color(0xFF636AF6),
                        )),
                    child: Row(children: <Widget>[
                      ///Bouton Description
                      Flexible(
                        child: Column(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _colorbuttonDescription,),
                                onPressed: () {
                                  setState(() {
                                    ///Si le bouton description est pressé :
                                    ///Le bouton Description devient bleu
                                    ///Le bouton avis reste de la même couleur
                                    ///Boolean Description devient true et false pour avis

                                    _colorbuttonDescription = const Color(0xFF636AF6);
                                    _colorbuttonAvis = const Color(0xFF1A2025);
                                    isPressedDescription = true;
                                    isPressedAvis = false;});},
                                child: const Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'GoogleSans-Bold',
                                      fontSize: 12.92,
                                    ),
                                    "Description",
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _colorbuttonAvis,
                            ),
                            onPressed: () {
                              setState(() {
                                ///Si le bouton description est pressé :
                                ///Le bouton Avis devient bleu
                                ///Le bouton Description reste de la même couleur
                                ///Boolean Description devient false et true pour avis
                                _colorbuttonAvis = const Color(0xFF636AF6);
                                _colorbuttonDescription = const Color(0xFF1A2025);
                                isPressedDescription = false;
                                isPressedAvis = true;});},

                            child: const Center(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'GoogleSans-Bold',
                                      fontSize: 12.92,
                                    ), "Avis"))),)
                    ])),),
              const SizedBox(height: 25),
              Center(
                ///Si bool Description est true :
                ///On affiche les infos de l'API steam de la description
                ///On utilise HTMLWidget pour afficher le texte mais aussi les images et videos sans les balises HTML

                child: isPressedDescription
                    ? HtmlWidget(description,
                textStyle : const TextStyle(color: Colors.white,
                  fontFamily: 'ProximaNova-Regular',
                  fontSize: 14))
                ///Si pas pressé, on affiche un container vide
                    : Container(),
              ),
              Center(
                ///Si bool Avis est true :
                ///On affiche l'avis global sous forme de rating  de l'API steam
              child: isPressedAvis
                    ? Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    color: Color(0xFF1E262C),
                    child: Column(children: [
                      const Text(
                        'Avis global du jeu ',
                        style: TextStyle(
                          fontSize: 15.27,
                          fontWeight: FontWeight.bold,
                          fontFamily: "ProximaNova-Regular",
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),),
                      const SizedBox(height: 10),
                      ///Etoiles de rating sur 10
                      RatingBar.builder(
                        initialRating: reviewsinteger,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 10,
                        itemPadding:
                        const EdgeInsets.symmetric(horizontal: 5.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color(0xFFF5A623),
                          size: 1,),
                        onRatingUpdate: (double value) {
                        },)]))
                    : Container(),
              )],
          ),]));}
}