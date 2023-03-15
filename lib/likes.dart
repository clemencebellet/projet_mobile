import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:projet_1/jeumodel.dart';
import 'package:provider/provider.dart';
import './bdd.dart';


class Likes extends StatefulWidget {
  Likes({Key? key}) : super(key: key) {
  }

  @override
  _LikesState createState() => _LikesState();
}



final ScrollController scroll = ScrollController();

class _LikesState extends State<Likes> {

List gameslikes =[];
  @override
  void initState() {
    super.initState();

  }

  fetchDatabase(String User) async
  {


dynamic res = await Bdd().getGames(User);
if(res ==null)
  {
    print("error");
  }
else {
  setState(() {
    gameslikes=res;
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

          child: gameslikes.length != 0 ? ListView.builder(
  itemCount: gameslikes.length,
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
    Image.network(gameslikes[index]['Urlimg'], scale: 1.3, width: 140,height:90),
             Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  gameslikes[index]['nom'],
                  style: const TextStyle(

                      fontFamily: 'ProximaNova-Regular',
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                    gameslikes[index]['publisher '],
                    style: const TextStyle(
                        fontFamily: 'ProximaNova-Regular',
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 255, 255, 255))
                ),
              ),
              SizedBox(
                width: 200,

                child: Text(

                    gameslikes[index]['prix'],
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
          Navigator.pushNamed(context,'/detail', arguments: { 'title':  gameslikes[index]['nom'], 'image':gameslikes[index]['Urlimg'],'infos':gameslikes[index]['publisher '],'description':gameslikes[index]['description'] ,'review':gameslikes[index]['review'], 'prix':gameslikes[index]['prix'], 'userId': gameslikes[index]['UserId']});

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
        SvgPicture.asset('Icones/empty_likes.svg', width: 94, height: 94),
        Text(
          'Vous n’avez encore pas liké de contenu. \n '
              'Cliquez sur le coeur pour en rajouter.',
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

