
import 'package:cinema/components/default_container.dart';
import 'package:cinema/providers/them_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/registrationData.dart';
import '../providers/themes.dart';
import 'Login_screen.dart';

class ProfileScreen extends StatelessWidget {
  String UserName;
  ProfileScreen({required this.UserName});

  @override
  Widget build(BuildContext context) {
    return Consumer (



      builder: ( context, ThemeModal themeNotifier, child) {
        return  Scaffold(



          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 20,),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/456/456141.png"),
                    radius:60 ,
                  ),
                  Text('${userName.text}',style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  Text('${email.text}',style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey
                  ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.orangeAccent,
                          Colors.pinkAccent
                        ],
                      ),
                    ),
                    child: Center(child: Text("Upgrade To Pro" , style: TextStyle(color: Colors.white,fontSize: 20 ,fontWeight: FontWeight.bold),)),
                  ),
                  SizedBox(height: 15,),
                  defaultContainer(iconData: Icons.privacy_tip, text: "Privacy"),
                  SizedBox(height: 15,),
                  Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[900]
                    ),
                    child: Center(child: Row(
                      children: [
                        SizedBox(width: 15,),
                        Icon(Icons.brightness_6_outlined , size: 20 ,color: Colors.white,  ) ,
                        SizedBox(width: 15,),
                        Text('Mode' , style: TextStyle(fontSize: 20 , color: Colors.white),),

                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:  SwitcherButton(
                            value: themeNotifier.isDark?false :true,
                            onChange: (value){
                              themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;


                            },

                          ),
                        ) ,

                      ],
                    ),),
                  ),
                  SizedBox(height: 15,),



                  InkWell(
                      onTap: (){
                        FirebaseAuth.instance.signOut().then((value) {
                          print("logged out");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        });
                      },
                      child: defaultContainer(iconData: Icons.logout, text: 'LogOut')
                  ),

                ],
              ),
            ),
          ),


        );
      },
    );




  }
}