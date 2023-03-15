import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/card.dart';

final ScrollController scroll = ScrollController();
class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
    ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;

    String userId = args['userId'];
    print(args);
    return Scaffold(


      backgroundColor: const Color(0xFF1A2025),
      appBar: AppBar(

        title: const Text(
          textAlign: TextAlign.left,
          'Accueil',

          style: TextStyle(

            fontFamily: "GoogleSans-Bold",
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        shadowColor: Colors.black,
        elevation: 40,

          backgroundColor : const Color(0xFF1A2025),
          // Put an icon heart and a star in the app bar
          actions: <Widget>[

            IconButton(

              icon: SvgPicture.asset('Icones/like.svg'),
              color: Colors.white,

              tooltip: 'Voir les favoris',
              onPressed: () {
                Navigator.pushNamed(context,'/likes', arguments : {'userId': userId});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Voilà la liste des favoris')),
                );
              },
            ),
            IconButton(
              color: Colors.white,
              icon: SvgPicture.asset('Icones/whishlist.svg'),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.pushNamed(context,'/wishlist', arguments : {'userId': userId});
              },
            ),
          ],
          leading: new Container(),
        ),

      body: SafeArea(

          child : Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            Container(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  labelText: 'Rechercher un jeu...',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color.fromARGB(30, 38, 44, 100),
                  suffixIcon:
                      Icon(Icons.search, color: Colors.deepPurple, size: 30.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.deepPurple, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                ),
              ),
            ),
      ),
            Stack(

              children: [

                const SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/fondarriere.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  top: 40,
                  left: 20,
                  child: Text(
                    'Titanfall 2',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Positioned(
                  top: 70,
                  left: 20,
                  child: Text(
                    'Ultimate Edition',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Positioned(
                  top: 100,
                  left: 20,
                  child: Text(
                    'Lorem ipsum dolor sit amet\nconsectetur adipisicing  elit.',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  left: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print(userId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('En savoir plus...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor : const Color(0xFF636AF6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical:   6),
                    ),
                    child: const Text(
                      'En savoir plus',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  right: 10,
                  child: SizedBox(
                    height: 150,
                    width: 100,
                    child: Image(
                      image: AssetImage('assets/jeudvd.png'),
                    ),
                  ),
                ),
              ],
            ),
             Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Les meilleures ventes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
             Expanded(
              child: SizedBox(
                child: CardInfos(user: userId),
              )
            )
          ],
        ),
      ),
        );
  }
}
