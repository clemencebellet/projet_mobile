import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:projet_1/jeumodel.dart';
import 'package:provider/provider.dart';
import './bdd.dart';


class Wishlist extends StatefulWidget {
  Wishlist({Key? key}) : super(key: key) {
  }

  @override
  _WishlistState createState() => _WishlistState();
}



final ScrollController scroll = ScrollController();

class _WishlistState extends State<Wishlist> {

  List gameswish =[];
  @override
  void initState() {
    super.initState();

  }

  fetchDatabase(String User) async
  {


    dynamic res = await Bdd().getWish(User);
    if(res ==null)
    {
      print("error");
    }
    else {
      setState(() {
        gameswish=res;
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
    ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;
    String userId = args['userId'];
    fetchDatabase(userId);
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
            'Mes likes ',
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

        body: SafeArea(

          child : Center(

              child: Container(
                  child: gameswish.length != 0 ? ListView.builder(
                    itemCount: gameswish.length,
                    itemBuilder: (context,index)
                    {
                      return Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/fondcard.png"),
                                    fit: BoxFit.cover),

                                color: Color(0xFF1A2025),
                                // sets the background color of the card's content area
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(gameswish[index]['Urlimg'], scale: 1.3, width: 140,height:90),
                                    Column(

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

                                                gameswish[index]['prix'],
                                                style: const TextStyle(

                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    fontFamily: 'ProximaNova-Regular',

                                                    color: Color.fromARGB(255, 255, 255, 255))
                                            ),
                                          ),



                                        ]),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context,'/detail', arguments: { 'title':  gameswish[index]['nom'], 'image':gameswish[index]['Urlimg'],'infos':gameswish[index]['publisher'],'description':gameswish[index]['description'] ,'review':gameswish[index]['review'], 'prix':gameswish[index]['prix'], 'userId': gameswish[index]['UserId']});

                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor : const Color(0xFF636AF6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 90),
                                      ),
                                      child: const Text(
                                        'En savoir plus',
                                      ),
                                    ),
                                  ]
                              )
                          )
                      );
                    },
                  ): Container(
                      margin: EdgeInsets.only(top: 150),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset('Icones/empty_wishlist.svg', width: 94, height: 94),
                            Text(
                              'Vous n’avez encore pas liké de contenu. \n '
                                  'Cliquez sur l’étoile pour en rajouter.',
                              style: TextStyle(
                                  color: Colors.white,

                                  fontSize: 15.27,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ProximaNova-Regular'
                              ),
                            ),

                          ])
                  ))
          ),

        ));
  }}
