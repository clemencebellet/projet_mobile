import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/card.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

FirebaseAuth auth = FirebaseAuth.instance;

final ScrollController scroll = ScrollController();

class _AccueilState extends State<Accueil> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;

    String userId = args['userId'];
    TextEditingController searchController = TextEditingController();
    print(args);
    return userId != null
        ? Scaffold(
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

              backgroundColor: const Color(0xFF1A2025),
              // Put an icon heart and a star in the app bar
              actions: <Widget>[
                IconButton(
                  icon:  Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
                  color: Colors.white,
                  tooltip: 'Voir les favoris',
                  onPressed: () {
                    Navigator.pushNamed(context, '/likes',
                        arguments: {'userId': userId});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Voilà la liste des favoris')),
                    );
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon:  Icon(
      Icons.star_border,
    color: Colors.white,
    ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/wishlist',
                        arguments: {'userId': userId});
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/connexion');
                  },
                ),
              ],
              leading: new Container(),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
              child:  Padding(
                  padding: EdgeInsets.all(16.0),


              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration:  InputDecoration(
                  labelText: 'Rechercher un jeu...',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color(0xFF1E262C) ,
                  suffixIcon: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.search, color: Color(0xFF636AF6), size: 30.0),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search',
                          arguments: {'userId': userId, 'search':searchController});
                    },
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color(0xFF1E262C), width: 2.0),
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
                            Navigator.pushNamed(context, '/detail', arguments: {
                              'title': 'TitanFall 2 Ultimate Edition ',
                              'image':
                                  'https://image.api.playstation.com/cdn/EP0006/CUSA04013_00/4bI5D3WvesQPmegKpGINAimOsS27D688.png',
                              'infos': 'Electronic Arts',
                              'description':
                                  'Profitez de l edition Ultime de Titanfall™ 2 pour plonger au coeur de l un des FPS les plus novateurs de 2016 ! Retrouvez tout le contenu de l édition Deluxe Digitale et obtenez le Pack de démarrage, vous offrant un accès instantané à toutes les classes de Titans et de pilotes ainsi qu à des fonds, des jetons XP double et une peinture de guerre pour la carabine R-201 afin de combattre avec style à la Frontière. L édition Ultime comprend le jeu de base Titanfall™ 2, tout le contenu de l édition Deluxe (Titans Scorch Prime et Ion Prime, peinture de guerre édition Deluxe pour les 6 Titans, camouflage édition Deluxe pour tous les Titans, pilotes et armes, personnalisations de cockpit Deluxe pour les 6 Titans, emblème édition Deluxe) et le Pack de démarrage (accès instantané à tous les Titans et à toutes les capacités tactiques de pilote, 500 jetons pour débloquer des équipements, des optimisations cosmétiques et du matériel, 10 jetons XP double et la peinture de guerre Souterrain pour la carabine R-201).',
                              'review': '9',
                              'prix': '29,99€',
                              'userId': userId,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF636AF6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 6),
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
    padding: const EdgeInsets.all(16.0),
    child: const Text(
    "Les meilleures ventes",
    style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline),
    ),

    ),
                  Flexible(
                      child: SizedBox(
                    child: CardInfos(user: userId),
                  ))
                ],
              ),
            ),
          )
        : const Scaffold(
            backgroundColor: Color(0xFF1A2025),
            body: Center(
                child: Text(
                    'Il semble que vous ayez été déconnecté \n Veuillez revenir en arrière ')));
  }
}
