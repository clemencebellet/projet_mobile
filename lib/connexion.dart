

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_1/inscription.dart';
import 'package:firebase_core/firebase_core.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  _ConnexionState createState() => _ConnexionState();
}




Widget MdpOublie(BuildContext context) {
  return Column(
    children: <Widget>[
      const SizedBox(height: 100),
      Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(),
          child: TextButton(
              style: TextButton.styleFrom(),
              onPressed: () {
                Navigator.pushNamed(context, '/mdpoublie');
              },
              child: const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFafb8bb),
                    decoration: TextDecoration.underline,
                    fontFamily: 'ProximaNova-Regular',
                    fontSize: 15.239016,
                  ),
                  "Mot de passe oublié",
                ),
              )))
    ],
  );
}


Widget NvCompte(BuildContext context) {
  return Column(
    children: <Widget>[
      const SizedBox(height: 10),
      Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.52),
              border: Border.all(
                color: const Color(0xFF636af6),
              )),
          height: 46.89,
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inscription');
              },
              child: const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ProximaNova-Regular',
                    fontSize: 15.239016,
                  ),
                  "Créer un nouveau compte",
                ),
              )))
    ],
  );
}

class _ConnexionState extends State<Connexion> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      String userId = user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {

        print("No User found for that email");

      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: <Widget>[
          Container(

              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 92.73),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      textAlign: TextAlign.center,
                      'Bienvenue',
                      style: TextStyle(
                        fontFamily: "GoogleSans-Bold",
                        color: Colors.white,
                        fontSize: 30.53169,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      textAlign: TextAlign.center,
                      'Veuillez vous connecter ou créer un nouveau compte pour utiliser l’application.',
                      style: TextStyle(
                        fontFamily: "ProximaNova-Regular",
                        color: Colors.white,
                        fontSize: 15.265845,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --------------------------------------BOX POUR LE MAIL-------------------------------

         Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFF1E262C),
              borderRadius: BorderRadius.circular(3.52),
            ),
            height: 46.89,
            child:  TextField(
                controller: emailController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    //contentPadding: EdgeInsets.only(top:10),

                    hintText: 'E-mail',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ProximaNova-Regular',
                      fontSize: 15.239016,
                    ))),
          )
        ],

         ),
                    // --------------------------------------BOX POUR LE MDP -------------------------------

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E262C),
                          borderRadius: BorderRadius.circular(3.52),
                        ),
                        height: 46.89,
                        child:  TextField(
                            controller: passwordController,
                            textAlign: TextAlign.center,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const  InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Mot de passe',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ProximaNova-Regular',
                                  fontSize: 15.239016,
                                ))),
                      )
                    ],
                  ),

                    // --------------------------------------BOX POUR LA CONNEXION -------------------------------
                  Column(
              children: <Widget>[
              const SizedBox(height: 100),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFF636af6),
              borderRadius: BorderRadius.circular(3.52),
            ),
            height: 46.89,
            child: TextButton(

                onPressed: () async {

User? user = await loginUsingEmailPassword(email: emailController.text, password: passwordController.text, context: context);
//print(user?.uid);

  print(user!.uid);
  String userId = user!.uid;
  // ignore: use_build_context_synchronously
  Navigator.pushNamed(context,'/accueil', arguments : {'userId': userId});

                },
                child: const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ProximaNova-Regular',
                      fontSize: 15.239016,
                    ),
                    "Se connecter",
                  ),
                )))
        ],
      ),
                    NvCompte(context),
                    MdpOublie(context),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
