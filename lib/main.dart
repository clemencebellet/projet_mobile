import 'package:flutter/material.dart';
import 'package:projet_1/detail.dart';
import 'package:projet_1/likes.dart';
import 'package:projet_1/inscription.dart';
import 'package:projet_1/mdpoublie.dart';
import 'package:projet_1/accueil.dart';
import 'package:projet_1/search.dart';
import 'package:projet_1/wishlist.dart';



import 'connexion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());

}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }


  Widget build(BuildContext context ){
    return  MaterialApp(

      routes: {
        '/connexion': (context) => Connexion(),
        '/inscription': (context) => Inscription(),
        '/mdpoublie': (context) => Mdpoublie(),
        '/accueil': (context) => Accueil(),
        '/detail': (context) => Detail(),
       '/likes': (context) => Likes(),
        '/wishlist': (context) => Wishlist(),
        '/search': (context) => Search(),



      },

      initialRoute: '/',
      title: 'Projet',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: const Color.fromARGB(30, 38, 44, 100),
        ),
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            body :  FutureBuilder(
                future : _initializeFirebase(),
                builder : (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done)
                  {
                      return Connexion();
                  }
                  return const Center(child : CircularProgressIndicator(),
                  );
                }
            )
        )

    );

  }
}
