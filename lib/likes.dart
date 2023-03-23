import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './bdd.dart';

class Likes extends StatefulWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LikesState createState() => _LikesState();
}

final ScrollController scroll = ScrollController();

class _LikesState extends State<Likes> {
  List gameslikes = [];

  @override
  void initState() {
    super.initState();
  }

  fetchDatabase(String User) async {
    dynamic res = await Bdd().getGames(User);
    if (res == null) {
      print("error");
    } else {
      setState(() {
        gameslikes = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String userId = args['userId'];
    fetchDatabase(userId);
    return Scaffold(
        backgroundColor: const Color(0xFF1A2025),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/accueil',
                  arguments: {'userId': userId});
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
          child: Center(
              child: Container(
                  child: gameslikes.isNotEmpty
                      ? ListView.builder(
                          itemCount: gameslikes.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: 130.16,
                                child: Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                  Color(0xFF1A2025)
                                                      .withOpacity(0.8),
                                                  BlendMode.modulate),
                                              image: NetworkImage(
                                                  gameslikes[index]['Urlimg']),
                                              fit: BoxFit.cover),

                                          // sets the background color of the card's content area
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
                                              SizedBox(
                                                width: 15,
                                              ),
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
                                                          ),
                                                        ),
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
                                                                          255))),
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                              "Prix : " +
                                                                  gameslikes[
                                                                          index]
                                                                      ['prix'],
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
                                                        ),
                                                      ]),
                                                ),
                                              ),
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
                                                        });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        const Color(0xFF636AF6),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 45),
                                                  ),
                                                  child: const Text(
                                                      'En savoir plus',
                                                      style: const TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily:
                                                              'ProximaNova-Regular',
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ]))));
                          },
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 150),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage('assets/emptylikes.png'),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                const Text(
                                  'Vous n’avez encore pas liké de contenu. \n '
                                  'Cliquez sur le coeur  pour en rajouter.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.27,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ProximaNova-Regular'),
                                ),
                              ])))),
        ));
  }
}
