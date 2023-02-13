import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_1/inscription.dart';
import 'package:projet_1/mdpoublie.dart';
import 'package:projet_1/accueil.dart';
import 'connexion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
      },

      initialRoute: '/',
      title: 'Projet',
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            body :  FutureBuilder(
                future : _initializeFirebase(),
                builder : (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done)
                  {
                    return Accueil();
                  }
                  return const Center(child : CircularProgressIndicator(),
                  );
                }
            )
        )

    );

  }
}