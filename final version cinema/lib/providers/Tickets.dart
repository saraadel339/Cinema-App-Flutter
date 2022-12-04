import 'dart:convert';
import 'package:cinema/db/booked_tickets_db.dart';
import 'package:cinema/models/booked_ticket_model.dart';
import 'package:cinema/models/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TicketsProvider with ChangeNotifier{
  List<BookedTicket> Tickets=[];
  final db=LocalDatabase();

  Future<void> getData(String userName)async{
    db.getDataFromDatabase(userName);

    notifyListeners();

  }

}