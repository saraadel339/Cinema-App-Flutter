import 'package:cinema/components/default_border.dart';
import 'package:cinema/models/cast_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:cinema/components/gradient_button.dart';
import 'package:cinema/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:profanity_filter/profanity_filter.dart';

import 'MultiSelect.dart';

class MovieScreen extends StatefulWidget {
  final String title;
  final Image? image;
  final num? rating;
  final String? genre;
  final String? description;
  final String userName;

  const MovieScreen({Key? key,required this.title,this.image,this.rating,this.genre,this.description,required this.userName}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final revKey=GlobalKey<FormFieldState>();
  final controller = TextEditingController();
  final filter = ProfanityFilter();

  final Uri url=Uri.parse("https://www.youtube.com/watch?v=JfVOs4VSpmA");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title.toString(), style: const TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: widget.image,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.image!.image,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  //image: widget.image,
                )
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black45,
                  Colors.black54,
                  Colors.black,
                  Colors.black,
                ],
              ),
            ),
          ),
          SafeArea(
            child: ScrollWrapper(
              scrollOffsetUntilVisible:20,
              scrollOffsetUntilHide:10,
              promptAnimationType: PromptAnimation.scale,
              promptAlignment: Alignment.topCenter,
              builder:(context, properties) => ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 20.0),
                    child: Container(
                      child: widget.image,
                         decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            40.0)),

                      ),
                      height: 300,
                      width: 250,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star, size: 20, color: Colors.orangeAccent,),
                      Text(widget.rating.toString() + " | ",
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 20),),
                      const Icon(Icons.timer, size: 20, color: Colors.white60,),
                      const Text("148""Minutes | ", style: TextStyle(
                          color: Colors.white60, fontSize: 20)),
                      const Icon(Icons.movie, size: 20, color: Colors.white60,),
                       Text(widget.genre.toString(), style: const TextStyle(
                          color: Colors.white60, fontSize: 20)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gradientButton(
                        function:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiSelectscreen(userName: widget.userName,movieName: widget.title,)));
                        },
                          first: const Color(0xffff5983),
                          second: Colors.orangeAccent,
                          text: "Book Ticket",
                          textColor: Colors.white,

                      fontSize: 15),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                          onPressed: () {
                            _launchUrl(url);
                          },
                          child: Row(
                            children: const[
                              Icon(Icons.play_arrow_rounded,
                                color: Colors.black,),
                              Text("Watch trailer", style: TextStyle(
                                  color: Colors.black54),),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: const Size(130, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Padding(
                    padding:  EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child:  Text("Synopsis", style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(38, 20, 38, 20),
                    child: ReadMoreText(
                      widget.description.toString(),
                      style: const TextStyle(
                          fontSize: 20, color: Colors.white),
                      colorClickableText: Colors.orangeAccent,
                      trimLines: 4,
                      trimMode: TrimMode.Line,
                      trimExpandedText: ' Less',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 0, 20),
                    child: Text("Cast & Crew", style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),),
                  ),

                  /*Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: SizedBox(
                      height: 200,
                      child: ListView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        children: [
                          cast(
                              address: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBKRizGW6Md-BUD5MchQ_UWgYZVKwNQxoPzQte9r0fwSQzBV6h",
                              name: "Tom Holland"),
                          cast(
                              address: "https://m.media-amazon.com/images/M/MV5BMjE2MjI2OTk1OV5BMl5BanBnXkFtZTgwNTY1NzM4MDI@._V1_.jpg",
                              name: "Andrew Garfield"),
                          cast(
                              address: "https://upload.wikimedia.org/wikipedia/commons/c/c2/Tobey_Maguire_2014.jpg",
                              name: "Toby Maguire"),
                          cast(
                              address: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBKRizGW6Md-BUD5MchQ_UWgYZVKwNQxoPzQte9r0fwSQzBV6h",
                              name: "Tom Holland"),
                        ],
                      ),
                    ),
                  ),*/

                  StreamBuilder<List<MovieCastModel>>(
                    stream: readCast(widget.title.toString()+"Cast"),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Padding(
                            padding:  EdgeInsets.fromLTRB(30,0,0,10),
                            child: Text("Something went wrong"),
                          );
                        }
                        else if (snapshot.hasData) {
                          final castMembers = snapshot.data!;
                          return Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: SizedBox(
                              height: 200,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children:
                                castMembers.map(buildActor).toList(),
                              ),
                            ),
                          );
                        }
                        else {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: Colors.orangeAccent),);
                        }
                      }),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 0, 20),
                    child: Text("Reviews", style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),),
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 30.0),
                    child: TextFormField(
                        key:revKey,
                        validator: (value){
                          if(value!.trim().isEmpty){
                            return "Can't post an empty review";
                          }
                          if(filter.hasProfanity(value)){
                            return "Profanity detected, cannot submit review.";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        controller: controller,
                        decoration: InputDecoration(
                          focusedErrorBorder: defaultBorder(c:Colors.red) ,
                          errorBorder: defaultBorder(),
                          focusedBorder: defaultBorder(),
                          enabledBorder: defaultBorder(),
                          disabledBorder: defaultBorder(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 0, 5, 0),
                            child: InkWell(
                              onTap: () {
                                final isValidRev=revKey.currentState!.validate();
                                if(isValidRev){
                                String name = widget.userName;
                                String comment = controller.text;

                                createReview(name: name, comment: comment,title: widget.title.toString());
                                controller.clear();
                                }
                              },
                              child: Container(

                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                      topRight: Radius.circular(30),),
                                    color: Colors.white),
                                child: const Center(
                                  child: Icon(
                                    Icons.double_arrow,
                                    color: Colors.orangeAccent,),


                                ),
                              ),
                            ),
                          ),
                          hintText: "  Write a Review...",
                          hintStyle: const TextStyle(color: Colors.grey),

                        )
                    ),
                  ),
                  StreamBuilder<List<Review>>(
                    stream: readReviews(widget.title.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }
                      else if (snapshot.hasData) {
                        final reviews = snapshot.data!;
                        return Column(
                          children:
                          reviews.map(buildReview).toList(),
                        );
                      }
                      else {
                        return const Text("No Reviews",style: TextStyle(color: Colors.white),);
                      }
                    },
                  ),


                ],

              ),
            ),
          ),

        ],
      ),
    );
  }
}


Widget buildReview(Review review) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(36,0,36,20),
    child: Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                child: const Icon(Icons.person, color: Colors.white,),
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color(0xffff5983),
                    Colors.deepOrangeAccent,
                    Colors.orangeAccent
                  ]),

                  //Colors.pinkAccent
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.name,style: const TextStyle(color: Colors.white,fontSize: 20)),
                    ReadMoreText(
                      review.comment,
                      style: const TextStyle(color: Colors.white70,fontSize: 19,),
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'More',
                      trimExpandedText: 'Show less',
                      colorClickableText: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),

        const SizedBox(height: 20,),
        const Divider(color: Colors.white,thickness: 1,indent: 10,endIndent: 10,)
      ],
    ),
  );
}

Stream<List<Review>>readReviews(String title){
  return FirebaseFirestore.instance.collection(title).snapshots().map((snapshot) => snapshot.docs.map((doc)=>Review.fromJason(doc.data())).toList());
}

Future createReview({required String name,required String comment,required String title}) async{
  final docRev=FirebaseFirestore.instance.collection(title).doc();
  final rev=Review(name, comment);
  final jason=rev.toJason();
  docRev.set(jason);
}

Stream<List<MovieCastModel>>readCast(String title){
  return FirebaseFirestore.instance.collection(title).snapshots().map((snapshot) => snapshot.docs.map((doc)=>MovieCastModel.fromJason(doc.data())).toList());
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

Widget buildActor(MovieCastModel cast) {
  return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: 150,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 130,
                width: 130,
                decoration:  const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Color(0xffff5983),Colors.deepOrangeAccent,Colors.orangeAccent]),
                  //Colors.pinkAccent
                ),
              ),
              top: 0,
              left: 0,
            ),


            Positioned(
              left: 5,
              top: 5,
              child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(cast.image),
                      minRadius: 60,
                    ),

                    const SizedBox(height: 10,),
                    SizedBox(width:100,child: Text(cast.name,maxLines: 2 ,textAlign: TextAlign.center, style: const TextStyle(color: Colors.white),))
                  ]
              ),
            ),

          ],
        ),
      )
  );
}