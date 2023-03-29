import 'package:flutter/material.dart';
import 'package:projet_1/detail.dart';
import 'package:projet_1/likes.dart';
import 'package:projet_1/inscription.dart';
import 'package:projet_1/mdpoublie.dart';
import 'package:projet_1/accueil.dart';
import 'package:projet_1/widgets/search.dart';
import 'package:projet_1/wishlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connexion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


/// Initialise Firebase avec l'application (authentification)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());

}
/// Utilisation de BloC
abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}

class InitialCounterEvent extends CounterEvent {}

class CounterState {
  final int counter;

  CounterState(this.counter);
}

///Gestion d'état avec la bibliotèque BloC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {

    on<IncrementCounterEvent>(_onIncrement);
    on<DecrementCounterEvent>(_onDecrement);
  }

  Future<void> _onIncrement(event, emit) async {
    emit(CounterState(state.counter + 1));
  }

  Future<void> _onDecrement(event, emit) async {
    emit(CounterState(state.counter - 1));
  }
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  ///Initialise Firebase
  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context ){
    return MultiBlocProvider(
      providers: [
    BlocProvider<CounterBloc>(
    create: (_) => CounterBloc(),
    )
      ],
        child: MaterialApp(

          ///Liste des routes de l'application pour naviguer entre les pages

      routes: {
        '/connexion': (context) => Connexion() ,
        '/inscription': (context) => Inscription(),
        '/mdpoublie': (context) => Mdpoublie(),
        '/accueil': (context) => const Accueil(),
        '/detail': (context) => const Detail(),
       '/likes': (context) => const Likes(),
        '/wishlist': (context) => const Wishlist(),
        '/search': (context) => const Search(),
      },
      initialRoute: '/',
      title: 'Projet',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: const Color.fromARGB(30, 38, 44, 100),
        ),
      debugShowCheckedModeBanner: false,

            /// Si la connexion a Firebase est faire => Connexion sinon on affiche un loader.

        home: Scaffold(
    body : BlocBuilder<CounterBloc, CounterState>(builder: (BuildContext context, CounterState state) {
    return FutureBuilder(
    future : _initializeFirebase(),
    builder : (context, snapshot){
    if(snapshot.connectionState == ConnectionState.done)
    {
    return  Connexion();
    }
    return const Center(child : CircularProgressIndicator(),
    );
    }
    );
    })
        )
    ));
  }
}
