import 'package:flutter/material.dart';
import './bdd.dart';

/// Wishlist est un Stateful Widget car des éléments du Widget peuvent changer donc nécessitent une gestion d'état.
class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List gameswish =[];

  bool isLoading=true;

  @override
  void initState() {
    super.initState();
  }



   // ignore: non_constant_identifier_names
  fetchDatabase(String User) async
  /// Récupération des éléments de la Bdd pour les souhaits de jeux
  {
    dynamic res = await Bdd().getWish(User);
    if(res ==null)
    {
      print("Erreur dans la récupération de la bdd");
    }
    else {
      setState(() {
        gameswish=res;
        isLoading=false;
      });}}

  @override
  Widget build(BuildContext context) {
    /// Récupération arguments de la navigation entre les pages
    Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String userId = args['userId'];

    /// Appel de la méthode de récuperation des souhaits en fonction de l'ID de l'utilisateur
    ///
    fetchDatabase(userId);
    return Scaffold(
        backgroundColor: const Color(0xFF1A2025),
        appBar: AppBar(
          leading : IconButton(
        icon:  const Icon(
        Icons.close,
        color: Colors.white,
        ),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context,'/accueil',arguments : {'userId': userId});
            },
          ),

          title: const Text(
            textAlign: TextAlign.left,
            'Ma Wishlist ',
            style: TextStyle(
              fontFamily: "GoogleSans-Bold",
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          shadowColor: Colors.black,
          elevation: 40,
          backgroundColor: const Color(0xFF1A2025),),
        /// SafeArea permet d'eviter les "obstables" pour les éléments "enfants", les problèmes d'affichage
        body: SafeArea(
          child: isLoading ?
          Center(child : CircularProgressIndicator())
              :Center(
              child: Container(
                  child: gameswish.isNotEmpty ? ListView.builder(
                    itemCount: gameswish.length,
                    itemBuilder: (context,index)
                    {
                      return Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          child: Container(
                              decoration:  BoxDecoration(
                                image: DecorationImage(
                                    colorFilter:
                                    ColorFilter.mode(const Color(0xFF1A2025).withOpacity(0.8),
                                        BlendMode.modulate),

                                    image: NetworkImage(gameswish[index]['Urlimg']),
                                    fit: BoxFit.cover),
                                // sets the background color of the card's content area
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(gameswish[index]['Urlimg'], scale: 1.3, width: 140,height:90),
                               const SizedBox(
                              width: 15,),
                                    ///Expanded permet à l'élément enfant d'occuper la place disponible
                              Expanded(
                              flex : 2 ,
                               child: Container(
                              padding: const EdgeInsets.symmetric(vertical : 20),
                               child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              gameswish[index]['nom'],
                                              style: const TextStyle(

                                                  fontFamily: 'ProximaNova-Regular',
                                                  fontSize: 18.0,
                                                  color: Color.fromARGB(255, 255, 255, 255)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                gameswish[index]['publisher'],
                                                style: const TextStyle(
                                                    fontFamily: 'ProximaNova-Regular',
                                                    fontSize: 15.0,
                                                    color: Color.fromARGB(255, 255, 255, 255))
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "Prix : " + gameswish[index]['prix'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    fontFamily: 'ProximaNova-Regular',
                                                    color: Color.fromARGB(255, 255, 255, 255))),),
                                        ]),),),

                                    /// Le bouton va prendre ici 1/3 de la place contrairement a l'expanded ci dessus
                              Flexible(
                                  flex:1,
                                    child : ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context,'/detail', arguments: { 'title':  gameswish[index]['nom'], 'image':gameswish[index]['Urlimg'],'infos':gameswish[index]['publisher'],'description':gameswish[index]['description'] ,'review':gameswish[index]['review'], 'prix':gameswish[index]['prix'], 'userId': gameswish[index]['UserId']});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor : const Color(0xFF636AF6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10,vertical : 45),
                                      ),
                                      child: const Text(
                                        'En savoir plus',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: 'ProximaNova-Regular',
                                              color: Colors.white)
                                      ),
                                    ),),])));},

                    /// Si la liste est vide, on affiche le emptywish et un texte
                  ): Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/emptylist.png'),
                              height: 92,
                              width: 102,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 40),
                            Text(
                              'Vous n’avez encore pas liké de contenu. \n '
                                  'Cliquez sur l’étoile pour en rajouter.',
                              style: TextStyle(
                                  color: Colors.white,

                                  fontSize: 15.27,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ProximaNova-Regular'
                              ),
                            ),])))),));}}

