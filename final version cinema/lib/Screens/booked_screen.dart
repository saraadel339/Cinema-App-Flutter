
import 'package:cinema/db/booked_tickets_db.dart';
import 'package:cinema/providers/Tickets.dart';
import 'package:cinema/providers/them_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/booked_ticket_model.dart';

class BookedTicketsScreen extends StatefulWidget {
  @override
  State<BookedTicketsScreen> createState() => _BookedTicketsScreenState();
}

class _BookedTicketsScreenState extends State<BookedTicketsScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketsProvider>(
        builder: (context, provider, _) {
          return Consumer<ThemeModal>(
            builder: (context ,ThemeModal ThemeNotifier ,_){
              return  Scaffold(

                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => TicketBuilder(),
                          separatorBuilder: (BuildContext context,
                              int index) => const Divider(),
                          itemCount: 3)
                    ],
                  ),
                ),
              ) ;
            },
          );
        }
    );
  }

  Widget TicketBuilder() =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xffff5983),
              child: Container(

                decoration: BoxDecoration(
                  shape: BoxShape.circle,


                ),
                child: CircleAvatar(

                  radius: 45,
                  backgroundImage: NetworkImage(
                      'https://movieposters2.com/images/782572-b.jpg'),

                ),
              ),
            ),
            SizedBox(width: 25,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Titanic',
                  style: TextStyle(color: Colors.white, fontSize: 30),),
                SizedBox(height: 15,),
                Text('\$100',
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 25),),


              ],
            ),
          ],
        ),
      );
}