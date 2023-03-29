import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

///Inscription  est un stateless car on n'a pas besoin de gérer des etats internes
class Inscription extends StatelessWidget {

  const Inscription({super.key});

  @override
  Widget build(BuildContext context) {

    ///Informations nécessaires pour l'inscription
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController verifpasswordController = TextEditingController();

    return Scaffold(
      ///Définition du style des éléments de l'interface utilisateur
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          ///Stack permet de superposer les éléments
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
                  ///Page qui va scroller verticalement
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
                          ),),
                        const SizedBox(height: 10),
                        const Text(
                          textAlign: TextAlign.center,
                          'Veuillez saisir ces différentes informations, '
                              'afin que vos listes soient sauvegardées.',
                          style: TextStyle(
                            fontFamily: "ProximaNova-Regular",
                            color: Colors.white,
                            fontSize: 15.265845,
                          ),),
                        const SizedBox(height: 40),

                        // -----------------BOX POUR LE NOM -----------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E262C),
                                  borderRadius: BorderRadius.circular(3.52),),
                                height: 46.89,
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: usernameController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Nom d'utilisateur",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ProximaNova-Regular',
                                          fontSize: 15.239016,
                                        ))))],),
                        // ----------------------BOX POUR EMAIL ---------------------------------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E262C),
                                borderRadius: BorderRadius.circular(3.52),),
                              height: 46.89,
                              child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: emailController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'E-mail',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ProximaNova-Regular',
                                        fontSize: 15.239016,))),)],),
                        // -----------------------BOX POUR MDP ---------------------------------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E262C),
                                borderRadius: BorderRadius.circular(3.52),),
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
                                      ))),)],),
// -----------------------BOX POUR VERFIFICATION MDP ---------------------------------------------
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E262C),
                                  borderRadius: BorderRadius.circular(3.52),),
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
                                          fontSize: 15.239016,))),),]),
                        // -----------------------BOX POUR BOUTON INSCRIRE ---------------------------------------------
                        Column(
                          children: <Widget>[
                            const SizedBox(height: 100),
                            Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF636af6),
                                  borderRadius: BorderRadius.circular(3.52),),
                                height: 46.89,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(const Color(0xFF636af6))),
                                    onPressed: () {
                                      if (passwordController.text !=
                                          verifpasswordController.text) {
                                      ///Si les deux champs de mot de passe ne correspondent pas, on affiche une alerte
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
                                                ],);});
                                      } else {
                                        ///On crée le compte avec les informations sur Firebase
                                        FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text)
                                            .then((userCredential){
                                              String userId = userCredential.user!.uid;
                                              Navigator.pushNamed(
                                                  context, '/accueil',arguments : {'userId': userId});
                                        });}},
                                    child:  const Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ProximaNova-Regular',
                                          fontSize: 15.239016,
                                        ),
                                        "S'inscrire",),)))
                          ],),],
                    ),))],),
        ));}}