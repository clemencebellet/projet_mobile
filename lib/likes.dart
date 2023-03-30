import 'package:flutter/material.dart';
import './bdd.dart';

/// Likes est un Stateful Widget car des éléments du Widget peuvent changer donc nécessitent une gestion d'état.

class Likes extends StatefulWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  List gameslikes = [];

  bool isLoading=true;

  @override
  void initState() {
    super.initState();
  }

  /// Récupération des éléments de la Bdd pour les likes

  // ignore: non_constant_identifier_names
  fetchDatabase(String User) async {
    dynamic res = await Bdd().getGames(User);
    if (res == null) {
      print("Erreur dans la récupération de la bdd");
    } else {
      setState(() {
        gameslikes = res;
        isLoading=false;
      });}}

  @override
  Widget build(BuildContext context) {

    /// Récupération arguments de la navigation entre les pages
    Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String userId = args['userId'];

    /// Appel de la méthode de récuperation de likes en fonction de l'ID de l'utilisateur

    fetchDatabase(userId);

    return Scaffold(
      ///Couleur de la page
        backgroundColor: const Color(0xFF1A2025),

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/accueil',
                  arguments: {'userId': userId});
            },),

          title: const Text(
            textAlign: TextAlign.left,
            'Mes likes ',
            style: TextStyle(
              fontFamily: "GoogleSans-Bold",
              color: Colors.white,
              fontSize: 18,
            ),),
          shadowColor: Colors.black,
          elevation: 40,

          /// Couleur de l'App Bar
          backgroundColor: const Color(0xFF1A2025),
        ),

        /// SafeArea permet d'eviter les "obstables" pour les éléments "enfants", les problèmes d'affichage

        body: SafeArea(
          child: isLoading ?
              Center(child : CircularProgressIndicator())
          :Center(
              child: Container(
                  child: gameslikes.isNotEmpty
                      ? ListView.builder(
                          itemCount: gameslikes.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                                height: 130.16,
                                child: Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                  const Color(0xFF1A2025)
                                                      .withOpacity(0.8),
                                                  BlendMode.modulate),
                                              image: NetworkImage(
                                                  gameslikes[index]['Urlimg']),
                                              fit: BoxFit.cover),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                  gameslikes[index]['Urlimg'],
                                                  scale: 1.3,
                                                  width: 140,
                                                  height: 90),
                                              const SizedBox(
                                                width: 15,
                                              ),

                                              ///Expanded permet à l'élément enfant d'occuper la place disponible
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            gameslikes[index]
                                                                ['nom'],
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'ProximaNova-Regular',
                                                                fontSize: 18.0,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                          ),),
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                              gameslikes[index]
                                                                  ['publisher'],
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'ProximaNova-Regular',
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255))),),
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                              // ignore: prefer_interpolation_to_compose_strings
                                                              "Prix : " + gameslikes[index]['prix'],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      15.0,
                                                                  fontFamily:
                                                                      'ProximaNova-Regular',
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255))),
                                                        ),]),),),
                                              /// Le bouton va prendre ici 1/3 de la place contrairement a l'expanded ci dessus
                                              Flexible(
                                                flex: 1,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/detail',
                                                        arguments: {
                                                          'title':
                                                              gameslikes[index]
                                                                  ['nom'],
                                                          'image':
                                                              gameslikes[index]
                                                                  ['Urlimg'],
                                                          'infos':
                                                              gameslikes[index]
                                                                  ['publisher'],
                                                          'description':
                                                              gameslikes[index][
                                                                  'description'],
                                                          'review':
                                                              gameslikes[index]
                                                                  ['review'],
                                                          'prix':
                                                              gameslikes[index]
                                                                  ['prix'],
                                                          'userId':
                                                              gameslikes[index]
                                                                  ['UserId']
                                                        });},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        const Color(0xFF636AF6),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 45),),
                                                  child: const Text(
                                                      'En savoir plus',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily:
                                                              'ProximaNova-Regular',
                                                          color: Colors.white)),
                                                ),),]))));},)

                  /// Si la liste est vide, on affiche le emptylikes et un texte
                      : Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage('assets/emptylikes.png'),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 40),
                                Text(
                                  'Vous n’avez encore pas liké de contenu. \n '
                                  'Cliquez sur le coeur  pour en rajouter.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.27,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ProximaNova-Regular'),
                                ),])))),));}}
