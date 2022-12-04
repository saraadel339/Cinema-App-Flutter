
import 'package:cinema/Screens/Login_screen.dart';
import 'package:cinema/Screens/MultiSelect.dart';
import 'package:cinema/Screens/Register_screen.dart';
import 'package:cinema/Screens/main_movies.dart';
import 'package:cinema/Screens/movie_screen.dart';
import 'package:cinema/providers/Tickets.dart';
import 'package:cinema/providers/movie_models.api.dart';
import 'package:cinema/providers/provider_seats.dart';
import 'package:cinema/providers/them_modal.dart';
import 'package:cinema/providers/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/booked_screen.dart';
import 'Screens/payment.dart';
import 'Screens/profile.dart';
import 'Screens/transition_screen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) =>
          MovieModelApi()
            ..getData(),),
          ChangeNotifierProvider(create: (_) => ThemeModal(),),
          ChangeNotifierProvider(create: (_) =>
          providerSeats()
            ..initializeSeats(),),
          ChangeNotifierProvider(create: (_) =>
          TicketsProvider()
            ..db
            ..getData('Janelock')),

        ],

        child: Consumer(
          builder: (context, ThemeModal themeNotifier, child) {
            return MaterialApp(

                debugShowCheckedModeBanner: false,

                theme:themeNotifier.is_Dark?MyThemes.lightTheme:MyThemes.darkTheme,



                home:
                RegisterScreen(),
                //TransitionScreen(UserName: 'Sara Adel',),
                    //MultiSelectscreen(movieName: 'inception',userName: 'Sara'),

               // MainMovies(userName: 'sara',)
               // paymentSheet(userName: 'sara',movieName: 'inception',countTickets: 3),
              //  BookedTicketsScreen(),

            // ProfileScreen(UserName: 'Sara',),
              
            );
          },
        ),
      ),
    );
  }
}
