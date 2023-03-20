import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController verifpasswordController = TextEditingController();

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
                          'Inscription',
                          style: TextStyle(
                            fontFamily: "GoogleSans-Bold",
                            color: Colors.white,
                            fontSize: 30.53169,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          textAlign: TextAlign.center,
                          'Veuillez saisir ces différentes informations, '
                              'afin que vos listes soient sauvegardées.',
                          style: TextStyle(
                            fontFamily: "ProximaNova-Regular",
                            color: Colors.white,
                            fontSize: 15.265845,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // -----------------BOX POUR LE NOM -----------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E262C),
                                  borderRadius: BorderRadius.circular(3.52),
                                ),
                                height: 46.89,
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: usernameController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        //contentPadding: EdgeInsets.only(top:10),

                                        hintText: "Nom d'utilisateur",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ProximaNova-Regular',
                                          fontSize: 15.239016,
                                        ))))
                          ],
                        ),

// -----------------------BOX POUR EMAIL ---------------------------------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Color(0xFF1E262C),
                                borderRadius: BorderRadius.circular(3.52),
                              ),
                              height: 46.89,
                              child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: emailController,
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

                        // -----------------------BOX POUR MDP ---------------------------------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Color(0xFF1E262C),
                                borderRadius: BorderRadius.circular(3.52),
                              ),
                              height: 46.89,
                              child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: passwordController,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
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
// -----------------------BOX POUR VERFI MDP ---------------------------------------------
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E262C),
                                  borderRadius: BorderRadius.circular(3.52),
                                ),
                                height: 46.89,
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    controller: verifpasswordController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Vérification du mot de passe',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ProximaNova-Regular',
                                          fontSize: 15.239016,
                                        ))),
                              ),
                            ]),

                        // -----------------------BOX POUR BOUTON INSCRIRE ---------------------------------------------

                        Column(
                          children: <Widget>[
                            const SizedBox(height: 100),
                            Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Color(0xFF636af6),
                                  borderRadius: BorderRadius.circular(3.52),
                                ),
                                height: 46.89,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(const Color(0xFF636af6))),
                                    onPressed: () {
                                      if (passwordController.text !=
                                          verifpasswordController.text) {
                                        print(passwordController);
                                        print(verifpasswordController);
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Erreur'),
                                                content: const Text(
                                                    "Les mots de passe ne correspondent pas "),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Fermer'))
                                                ],
                                              );
                                            });
                                      } else {

                                        FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text)
                                            .then((userCredential){
                                              String userId = userCredential.user!.uid;
                                          print("Nouveau Compte crée ");
                                              Navigator.pushNamed(
                                                  context, '/accueil',arguments : {'userId': userId});

                                        });

                                      }
                                    },
                                    child:  Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ProximaNova-Regular',
                                          fontSize: 15.239016,
                                        ),
                                        "S'inscrire",
                                      ),
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
