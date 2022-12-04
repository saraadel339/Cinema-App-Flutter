import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class providerSeats extends ChangeNotifier{

  Map<String,List<Seat>>mp={"Inception":[],"Toy Story":[],"Avengers: Endgame":[], "The Dark Knight":[],"Meet the Robinsons":[]};

  List<Seat> seats= List.empty(growable: true);

  List <int> reserved= List.empty(growable: true);

 static providerSeats get (context)=> Provider.of<providerSeats>(context,listen: false);

  void initializeSeats (){
    for(int i=0;i<48;i++){
      mp["Inception"]!.add(Seat("",0));
      mp["Toy Story"]!.add(Seat("",0));
      mp["Avengers: Endgame"]!.add(Seat("",0));
      mp["The Dark Knight"]!.add(Seat("",0));
      mp["Meet the Robinsons"]!.add(Seat("",0));

    }
  }

  void changeColour (String movieName,int index){

    if (mp[movieName]![index].selected==0) {
      mp[movieName]![index].color = Colors.orangeAccent;
      mp[movieName]![index].selected = 1;
      notifyListeners();
    }
    else if (mp[movieName]![index].selected==1){
      mp[movieName]![index].color=Colors.white;
      mp[movieName]![index].selected=0;
      notifyListeners();
    }
    else {
      mp[movieName]![index].color = Colors.pinkAccent;
    }

    if(mp[movieName]![index].selected==1){
      reserved.add(index);
      notifyListeners();
    }
    else if(mp[movieName]![index].selected==0){
      reserved.remove(index);
      notifyListeners();
    }
  }
  void reservation (String movieName) {
    for (int i = 0; i < reserved.length; i++) {
      mp[movieName]![reserved[i]].selected = 2;
      mp[movieName]![reserved[i]].color = Colors.pinkAccent;
    }

    reserved.clear();
    notifyListeners();
  }

}
class Seat{
  String name;
  int selected;
  Color color;
  Seat(this.name,this.selected , {this.color=Colors.white});
}