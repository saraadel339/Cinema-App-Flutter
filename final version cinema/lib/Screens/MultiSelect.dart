import 'package:cinema/Screens/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../components/gradient_button.dart';
import '../providers/provider_seats.dart';

class MultiSelectscreen extends StatefulWidget{
  String userName;
  String movieName;

  MultiSelectscreen({ required this.userName,required this.movieName});

  @override
  State<MultiSelectscreen> createState() => _MultiSelectscreenState();
}

class _MultiSelectscreenState extends State<MultiSelectscreen> {
  bool noSeats=false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Consumer(
        builder: (context, providerSeats provider_seats, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Text(
                "Seats", style: TextStyle(color: Colors.white),),),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    Positioned(
                      top: 48,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 40,
                            width: size.width * 0.65,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white, Colors.transparent
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0, 1],
                                )
                            ),
                          ),
                          Container(
                            height: 40,
                            width: size.width * 0.55,
                            decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      width: 6,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 42,
                            width: 41,
                            decoration: const BoxDecoration(

                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)
                                ),
                                color: Colors.pinkAccent
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 42,
                            width: 41,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)
                                ),
                                color: Colors.pinkAccent
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 42,
                            width: 41,
                            decoration: const BoxDecoration(

                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)
                                ),
                                color: Colors.orangeAccent
                            ),
                          ),


                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 42,
                            width: 41,
                            decoration: const BoxDecoration(

                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)
                                ),
                                color: Colors.orangeAccent
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5,),
                    Container(
                      color: Colors.transparent,
                      child: GridView.builder(
                        primary: true,

                        addAutomaticKeepAlives: true,
                        shrinkWrap: true,

                        itemBuilder: (ctx, index) {
                          return prepareList(index, context);
                        },

                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
                          (crossAxisCount: 8,
                          crossAxisSpacing: 2,

                        ),

                        itemCount: Provider
                            .of<providerSeats>(context, listen: false)
                            .mp[widget.movieName]!.length,

                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Divider(endIndent: 30,
                        indent: 30,
                        color: Colors.white,
                        thickness: 3),
                    Padding(padding: const EdgeInsets.fromLTRB(30, 10, 8, 0),
                        child: Row(
                          children: const [
                            Icon(Icons.circle, color: Colors.white, size: 10,),
                            Text(" Free", style: TextStyle(
                              color: Colors.white, fontSize: 25,),),
                            SizedBox(width: 40,),
                            Icon(Icons.circle, color: Colors.orangeAccent,
                              size: 10,),
                            Text(" Selected", style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 25,),),
                            SizedBox(width: 40,),
                            Icon(Icons.circle, color: Colors.pink, size: 10,),
                            Text(" Taken", style: TextStyle(
                              color: Colors.pink, fontSize: 25,),),
                          ],
                        )),
                    const SizedBox(height: 40,),
                    gradientButton(width: 300,
                        fontWeight: FontWeight.bold,
                        radius: 5,
                        textColor: Colors.white,
                        first: const Color(0xffff5983),
                        second: Colors.orangeAccent,
                        text: "Confirm Tickets",
                        function: () {
                          if (provider_seats.reserved.isEmpty) {
                            noSeats=true;
                            setState(() {
                            });
                          }
                          else {
                            setState(() {
                              noSeats=false;
                            });
                            showModalBottomSheet(isScrollControlled: true,
                                context: context,
                                builder: (context) =>
                                    paymentSheet(
                                        movieName: widget.movieName,
                                        userName: widget.userName,
                                        countTickets: provider_seats.reserved.length));}}),
                    const SizedBox(height: 10,),
                    noSeats==true? const Text("No Seats were selected",style: TextStyle(color: Colors.redAccent,fontSize: 20),):const SizedBox(),

                  ],
                ),

              ),
            ),
          );
        });
  }

  //Color color=Colors.white;
  Widget prepareList(int index ,context)
  { //Color color=Colors.black ;

    return Card(
      child: Container(
        color: Colors.transparent
        ,
        child: InkWell(

          onTap: (){
            Provider.of<providerSeats>(context, listen: false).changeColour(widget.movieName,index);
          },

          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
              color:  Provider.of<providerSeats>(context, listen: false).mp[widget.movieName]![index].color,
            ),

            child:Center(child: Text( Provider.of<providerSeats>(context, listen: false).mp[widget.movieName]![index].name,style: const TextStyle(fontSize: 30),)) ,

          ),
        ),
      ),
    );
  }
}

