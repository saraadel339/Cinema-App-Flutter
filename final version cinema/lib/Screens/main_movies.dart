import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/Screens/movie_screen.dart';
import 'package:cinema/components/Bubble.dart';
import 'package:cinema/components/gradient_button.dart';
import 'package:cinema/components/star_rating.dart';
import 'package:cinema/providers/them_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_models.api.dart';

class MainMovies extends StatefulWidget {
  String userName;
  MainMovies({Key? key,required this.userName}) : super(key: key);

  @override
  _MainMoviesState createState() => _MainMoviesState();
}

class _MainMoviesState extends State<MainMovies> {

  final urlImages = [
    Image.network(
        "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_FMjpg_UX1000_.jpg"),
    Image.network("https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_FMjpg_UX1000_.jpg"),
    Image.network('https://m.media-amazon.com/images/M/MV5BMDU2ZWJlMjktMTRhMy00ZTA5LWEzNDgtYmNmZTEwZTViZWJkXkEyXkFqcGdeQXVyNDQ2OTk4MzI@._V1_.jpg'),
    Image.network("https://m.media-amazon.com/images/M/MV5BYWNhNzcxNGEtZmYwOS00NmRiLTgwMjktMjVjZTk4MDYxMGUwXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_FMjpg_UX1000_.jpg")
    ,Image.network("https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg")
  ];
  
  @override
  Widget build(BuildContext context) {

    return Consumer2<MovieModelApi,ThemeModal >(
      builder: (context,provider,ThemeNotifier,_){
      return Scaffold(
          body: Container(
            decoration:  BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end:Alignment.bottomCenter,colors: [ ThemeNotifier.is_Dark?Colors.white:Colors.black,ThemeNotifier.is_Dark?Colors.white:Colors.black26,ThemeNotifier.is_Dark?Colors.white:Colors.black]),),
            child:
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // const SizedBox(height: 140,),
                CarouselSlider.builder(
                  itemCount: provider.MovieData.length,
                  options: CarouselOptions(height: MediaQuery.of(context).size.height),
                  itemBuilder: (context, index, realIndex) =>
                      Container(
                        width: 300,
                        decoration: const BoxDecoration(color: Colors.black87,borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),)),

                        child: movieCard(urlImages[index],provider.MovieData[index].name,
                            provider.MovieData[index].genre,provider.MovieData[index].rating,
                            provider.MovieData[index].runtime,provider.MovieData[index].storyLine),
                      )
                  ,
                ),
              ],
            ),
          ),
    );}
    );
  }
Widget movieCard(Image image,String title,String genre,num rating,String runtime,String description){
  return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          ClipRRect( borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
            child: image),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,10),
            child: SizedBox(width: 300,child: Text(title,textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Bubble(genre,85),
              const SizedBox(width: 5,),
             Bubble("IMDB "+rating.toString(),85),
             const SizedBox(width: 5),
              Bubble(runtime,85),]
          ),
          const SizedBox(height: 10,),
          StarRating(rating.toDouble()),
          const SizedBox(height: 10,),
          gradientButton(
              text: "Details",
              first: const Color(0xffff5983),
              second: Colors.orangeAccent,
              radius: 5,width: 270,height: 40,
              fontSize: 20,
              fontWeight: FontWeight.bold,textColor: Colors.white,
            function: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MovieScreen(title: title,image: image,genre: genre,rating: rating,description:description,userName: widget.userName,)),);
            }
          ),
        ]
    );
   }
}
