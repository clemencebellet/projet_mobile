import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

///MdpOublie est un stateless car on n'a pas besoin de gérer des etats internes

class Mdpoublie extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  Mdpoublie({super.key});

  @override
  Widget build(BuildContext context) {
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
                      'Mot de passe oublié',
                      style: TextStyle(
                        fontFamily: "GoogleSans-Bold",
                        color: Colors.white,
                        fontSize: 30.53169,
                      ),),
                    const SizedBox(height: 10),
                    const Text(
                      textAlign: TextAlign.center,
                      'Veuillez saisir votre email afin de réinitialiser votre mot de passe',
                      style: TextStyle(
                        fontFamily: "ProximaNova-Regular",
                        color: Colors.white,
                        fontSize: 15.265845,
                      ),),
                    const SizedBox(height: 40),
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
                                    fontSize: 15.239016,
                                  ))),)],),
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 100),
                        Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: const Color(0xFF636af6),
                              borderRadius: BorderRadius.circular(3.52),),
                            height: 46.89,
                            child: TextButton(
                                onPressed: () {
                                  ///On envoie à l'adresse renseigné un mail pour rénitialiser
                                  FirebaseAuth.instance.sendPasswordResetEmail(
                                      email: emailController.text);
                                  Navigator.pushNamed(context, '/connexion');
                                },
                                child: const Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'ProximaNova-Regular',
                                      fontSize: 15.239016,
                                    ),
                                    "Renvoyer mon mot de passe",),
                                )))],),],),))],
      ),));}}