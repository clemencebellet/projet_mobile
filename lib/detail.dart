import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projet_1/bdd.dart';
import 'package:projet_1/jeumodel.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Color _colorbuttonDescription = Color(0xFF1A2025);
  Color _colorbuttonAvis = Color(0xFF1A2025);
  Color colorfavorites = Colors.white;
  Color colorstar = Colors.white;
  bool isPressedDescription = false;
  bool isPressedAvis = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;

    String title = args['title'];
    String userId = args['userId'];
    String image = args['image'];
    String infos = args['infos'];
    String prix = args['prix'];
    String description = args['description'];
    String reviews = args['review'];
    double reviewsinteger = int.parse(reviews) as double;

    return Scaffold(
        backgroundColor: const Color(0xFF1A2025),
        appBar: AppBar(
          title: const Text(
            textAlign: TextAlign.left,
            'Détail du jeu ',
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
              onPressed: () {
                setState(() {
                  colorfavorites =Colors.red;
                });
                Bdd backend = Bdd();
                backend.addJeux(Jeux(
                  name: title,
                  publisher: infos,
                  prix: prix,
                  img: image,
                  userID: userId,


                ));


              },
      icon: const Icon(Icons.favorite),
      color: colorfavorites,



              ),

            IconButton(
              onPressed: () {
                setState(() {
                  colorstar = Colors.yellow;
                });

              },
              icon: const Icon(Icons.star),
              color: colorstar,



            ),
          ],
        ),
        body: ListView(controller: _scrollController, children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  const SizedBox(
                    height: 297.1,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage('assets/fondBASE.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Container(
                        height: 110,
                        width: 340,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/fonddetail.png"),
                              fit: BoxFit.cover),
                          color: Color(0xFF1A2025),
                          // sets the background color of the card's content area
                        ),
                        child: Row(
                          children: [
                            Image.network(image,
                                scale: 1.3, width: 140, height: 90),
                            const SizedBox(width: 10),
                            Column(
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
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: 200,
                                    child: Text(infos,
                                        style: const TextStyle(
                                            fontFamily: 'ProximaNova-Regular',
                                            fontSize: 15.0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ),
                                  const SizedBox(
                                    width: 200,
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                      Flexible(
                        child: Column(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _colorbuttonDescription,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _colorbuttonDescription = Color(0xFF636AF6);
                                    _colorbuttonAvis = Color(0xFF1A2025);
                                    isPressedDescription = true;
                                    isPressedAvis = false;
                                  });
                                },
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
                      SizedBox(width: 5),
                      Flexible(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _colorbuttonAvis,
                            ),
                            onPressed: () {
                              setState(() {
                                _colorbuttonAvis = Color(0xFF636AF6);
                                _colorbuttonDescription = Color(0xFF1A2025);
                                isPressedDescription = false;
                                isPressedAvis = true;
                              });
                            },
                            child: const Center(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'GoogleSans-Bold',
                                      fontSize: 12.92,
                                    ),
                                    "Avis"))),
                      )
                    ])),
              ),
              SizedBox(height: 25),

           Center(
              child: isPressedDescription
                  ? Html(data: description, style: {
                      "html": Style(
                        color: Colors.white,
                        fontFamily: 'ProximaNova-Regular',
                        fontSize: FontSize(15.265845),
                      ),
                    })
                  : Container(),
            ),
              Center(
                child: isPressedAvis
                  ? RatingBar.builder(
                      initialRating: reviewsinteger,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 10,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size:4,
                      ),
                      onRatingUpdate: (double value) {
                        print(value);
                      },
                    )
                  : Container(),
              )
            ],
          ),
        ]));
  }
}
