


import 'package:cinema/Screens/Register_screen.dart';
import 'package:cinema/Screens/transition_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinema/components/default_textformfield.dart';
import 'Register_screen.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isEmailorPasswordWrong=false ;

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController userName = TextEditingController();

  final auth = FirebaseAuth.instance;
  final formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(

            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                'https://images.squarespace-cdn.com/content/v1/618f1949e28d5e64417a9ba1/1637461630196-CPUM9INIO8C2OE57HKWY/tyson-moultrie-BQTHOGNHo08-unsplash.jpg',
                fit: BoxFit.cover,),

            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(


                        children: [

                          const SizedBox(height: 35,),

                          defaultTextFormField(hintText: 'Email',
                              fieldonChange: (value){
                                formKey.currentState!.validate();
                              },
                              icon: Icons.email_outlined,
                              color: Colors.orangeAccent,
                              Type: TextInputType.emailAddress,
                              controller: email,
                            fieldValidator: (Email){
                              if(Email.isEmpty){
                                return 'Enter a Email';
                              }
                              else if (Email!=null&& !EmailValidator.validate(Email) ) {
                                return  'Enter a Valid Email';
                              }
                              else {
                                isEmailorPasswordWrong =false;
                                setState(() {

                                });
                                return null ;
                              }
                            }
                           ,

                          ),
                          const SizedBox(height: 35,),

                          defaultTextFormField(hintText: 'Password',
                              fieldonChange: (value){
                                formKey.currentState!.validate();
                              },
                              icon: Icons.lock,
                              color: Colors.orangeAccent,
                              obscureText: true,
                              Type: TextInputType.visiblePassword,
                              controller: password,
                          fieldValidator:  (Password){
                            if(Password.isEmpty){
                              return 'Enter a Password';
                            }
                            else if (Password!=null&&Password.length<6 ) {
                             return  'Enter a Valid Password';
                            }
                            else {
                              isEmailorPasswordWrong =false;
                              setState(() {

                              });
                              return null ;
                            }
                          },),


                          const SizedBox(height: 40,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Visibility(
                              visible: isEmailorPasswordWrong,
                                child: Text('Either Email or Password are wrong' ,style: TextStyle(color: Colors.red),),

                            ),
                          ),
                          const SizedBox(height: 30,),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),

                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  colors: <Color>[
                                    Color(0xffff5983),
                                    Colors.orangeAccent,

                                  ],

                                )

                            ),
                            child: MaterialButton(onPressed: () async {
                              try {
                                final validForm = formKey.currentState!
                                    .validate();
                                if (validForm) {
                                  final User = await auth
                                      .signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text);
                                //  print(email.text.toString());
                                  print("logged successfuly");
                                  isEmailorPasswordWrong =false;
                                  setState(() {

                                  });


                                  if (User != null) {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            TransitionScreen(
                                              UserName: userName.text,)));
                                  }
                                }
                              }
                              catch (e) {
                                print(e);
                                print("error in login");
                                isEmailorPasswordWrong=true;
                                setState(() {

                                });
                              }
                            },
                              child: const Text('Login', style: TextStyle(
                                  color: Colors.white, fontSize: 20),),),
                          ),
                          const SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an Account ? ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),),
                              TextButton(onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                              },
                                  child: const Text('Sign Up', style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orangeAccent,),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
