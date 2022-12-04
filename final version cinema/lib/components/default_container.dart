import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultContainer ({
   IconData? iconData ,
  IconData icon=Icons.arrow_forward_ios_rounded,
  required String text
} )=>
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 350,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[900]
        ),
        child: Center(child: Row(
          children: [
            const SizedBox(width: 15,),
            Icon(iconData , size: 20 ,color: Colors.white,  ) ,
            const SizedBox(width: 15,),
            Text(text, style: const TextStyle(fontSize: 20 , color: Colors.white),),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon , color: Colors.white,size: 20,),

            ),
          ],
        ),
        ),
      ),
    );