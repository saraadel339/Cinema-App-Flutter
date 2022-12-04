import 'package:cinema/Screens/profile.dart';
import 'package:cinema/providers/Tickets.dart';
import 'package:cinema/providers/movie_models.api.dart';
import 'package:cinema/providers/them_modal.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booked_screen.dart';
import 'main_movies.dart';

class TransitionScreen extends StatefulWidget {
  final String UserName;

  TransitionScreen({Key? key,required String this.UserName}) : super(key: key);

  @override
  _TransitionScreenState createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  int selectedIndex=1;
  late List screens;
  final items =<Widget>[
    Icon(Icons.person,size: 30,color: Colors.orangeAccent,),
    Icon(Icons.movie,size: 30,color: Colors.orangeAccent),
    Icon(Icons.bookmark,size: 30,color: Colors.orangeAccent),


  ];
  @override
  void initState() {
    screens=[ProfileScreen(UserName: widget.UserName.toString()), MainMovies(userName: widget.UserName.toString()),BookedTicketsScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>TicketsProvider()..getData("Janelock"),
      child: Consumer<ThemeModal>(
        builder:(context,ThemeModal ThemeNotifier,_) {

          return Scaffold(
          body: Provider.of<MovieModelApi>(context).loading==true? screens[selectedIndex]:Center(child: CircularProgressIndicator()),
          bottomNavigationBar:CurvedNavigationBar(

          items: items,
          index: selectedIndex,
          onTap: (index)=>setState(() {
          selectedIndex=index;
          }) ,
          color: ThemeNotifier.is_Dark?Colors.white:Colors.black,
          backgroundColor: ThemeNotifier.is_Dark?Colors.white10:Colors.black12,

          buttonBackgroundColor: ThemeNotifier.is_Dark?Color(0xFFF5F5F5):Color(0xff212121),
          height: 55,

          ),
          );

        },
      ),
    );
  }
}
/*const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Booked Tickets',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.orangeAccent,
          onTap: (index)=>setState(() {
            selectedIndex=index;
          }),*/