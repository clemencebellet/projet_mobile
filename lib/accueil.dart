import 'package:flutter/material.dart';
import '../widgets/card_list.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        // Put an icon heart and a star in the app bar
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Voir les favoris',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Voilà la liste des favoris')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.star),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Voilà les favoris')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
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
            Stack(
              children: [
                const SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/Titan.png'),
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
                  top: 140,
                  left: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('En savoir plus...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 5),
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
                      image: AssetImage('assets/Jacket.png'),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
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
            const Expanded(
              child: SizedBox(
                child: CardList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
