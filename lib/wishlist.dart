import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/card.dart';

final ScrollController scroll = ScrollController();
class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
    ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;
    String userId = args['userId'];
    return Scaffold(
        backgroundColor: const Color(0xFF1A2025),
        appBar: AppBar(


          leading : IconButton(
            icon: SvgPicture.asset('Icones/close.svg'),
            color: Colors.white,

            tooltip: 'Voir les favoris',
            onPressed: () {
              Navigator.pushNamed(context,'/accueil',arguments : {'userId': userId});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Voilà la liste des favoris')),
              );
            },
          ),


          title: const Text(
            textAlign: TextAlign.left,
            'Ma liste de souhaits',
            style: TextStyle(
              fontFamily: "GoogleSans-Bold",
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          shadowColor: Colors.black,
          elevation: 40,

          backgroundColor: const Color(0xFF1A2025),
          // Put an icon heart and a star in the app bar

        ),

        body: ListView(controller: scroll, children: <Widget>[
          Center(

              child : Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset('Icones/empty_whishlist.svg', width: 94, height: 94),
                        Text(
                            'Vous n’avez encore pas liké de contenu.\n'
                        'Cliquez sur l’étoile pour en rajouter.',
                          style: TextStyle(
                              color: Colors.white,

                              fontSize: 15.27,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ProximaNova-Regular'
                          ),
                        ),

                      ]
                  )
              )
          )])
    );
  }}