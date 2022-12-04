import 'dart:math';
import 'package:cinema/Screens/transition_screen.dart';
import 'package:cinema/components/default_button.dart';
import 'package:cinema/providers/them_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/provider_seats.dart';

int _value=1;
int points=0;
late int price;
late int initialPrice;
int initialPoints=points;
bool check=false;

final cardNumKey = GlobalKey<FormFieldState>();
final cvvKey = GlobalKey<FormFieldState>();
final edKey = GlobalKey<FormFieldState>();
final chnKey = GlobalKey<FormFieldState>();

Widget paymentSheet({required String movieName,required String userName,required int countTickets}) {

  price=100*countTickets;
  initialPrice=100*countTickets;

  return Consumer(
    builder: (context,ThemeModal ThemeNotifier,_){
      
      return Scaffold(

        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: StatefulBuilder(builder: (context, setState) =>
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    20, 10, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment
                        .start,
                    children: [
                      const SizedBox(height: 80,),
                       Text(
                        "Payment", style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color:ThemeNotifier.is_Dark?Colors.black:Colors.white,),),
                      const SizedBox(height: 30,),
                      const Text(
                          "Select a payment method",
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight
                                  .w400,
                              color: Colors.white70)),
                      const SizedBox(height: 20,),
                      Row(children: [
                        Radio<int>(
                            fillColor: MaterialStateColor.resolveWith((states) =>
                            Colors.indigo),
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            }
                        ),
                        SizedBox(
                            height: 30, width: 90,
                            child: Image.asset(
                                'assets/image/Visa.png')
                        ),
                        const SizedBox(width: 20,),
                        Radio<int>(
                            fillColor: MaterialStateColor
                                .resolveWith((states) =>
                            Colors.indigo),
                            value: 2,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            }),
                        SizedBox(
                            height: 45, width: 100,
                            child: Image.asset(
                                'assets/image/MC.png')),

                      ],),
                      const SizedBox(height: 20,),
                      const Text("Card Number",
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight
                                  .w400,
                              color: Colors.white70)),
                      const SizedBox(height: 10,),
                      TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CardNumberFormatter(),
                            LengthLimitingTextInputFormatter(19),
                          ],
                          key: cardNumKey,
                          validator: (value) {
                            if (value!.length != 19) {
                              return "16 digits must be inserted";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.white),
                          decoration: const InputDecoration(
                            fillColor: Color(
                                0xff302d2d),
                            filled: true,
                            prefixIcon: Icon(
                              Icons
                                  .credit_card_outlined,
                              color: Colors
                                  .orangeAccent,
                            ),
                          )
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: const [
                          Text("Valid Until",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight
                                      .w400,
                                  color: Colors
                                      .white70)),
                          SizedBox(width: 120,),
                          Text("CVV", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight
                                  .w400,
                              color: Colors.white70)),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                validator: (value) {
                                  if (value!.length != 5) {
                                    return "Invalid input.";
                                  }
                                  String month = value[0] + value[1];

                                  if (int.parse(month) < 1 || int.parse(month) > 12 ||
                                      value[2] != '/') {
                                    return "Invalid Input.";
                                  }
                                  return null;
                                },
                                key: edKey,
                                style: const TextStyle(
                                    color: Colors
                                        .white),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors
                                          .white70),
                                  hintText: "MM/YY",
                                  fillColor: Color(
                                      0xff302d2d),
                                  filled: true,)),
                          ),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 160,
                            child: TextFormField(
                                key: cvvKey,
                                validator: (value) {
                                  if (value!.length != 3) {
                                    return "3 digits must be inserted";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    color: Colors
                                        .white),
                                decoration: const InputDecoration(
                                  fillColor: Color(
                                      0xff302d2d),
                                  filled: true,)),
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Text("Card Holder Name",
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight
                                  .w400,
                              color: Colors.white70)),
                      const SizedBox(height: 10,),
                      TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              "Field Cannot Be Empty";
                            }
                            for (int i = 0; i < value.length; i++) {
                              if (value[i] != ' ' &&
                                  !RegExp(r'^[a-zA-z]').hasMatch(value)) {
                                return "Invalid input";
                              }
                            }
                            return null;
                          },
                          key: chnKey,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            fillColor: Color(0xff302d2d), filled: true,)
                      ),
                      const SizedBox(height: 30,),
                      points > 0 ?
                      CheckboxListTile(
                          side: const BorderSide(color: Colors.white),
                          value: check,
                          title: Text("Apply a discount of " +
                              (min(initialPoints, initialPrice)).toString() +
                              " using points.",
                            style: const TextStyle(color: Colors.white),),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.indigo,
                          //checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                price = (100 * countTickets)-min(points, price);
                              }
                              else {
                                price = 100 * countTickets;
                                points = initialPoints;
                              }
                              check = value!;
                            });
                          }) : const SizedBox(),
                      const SizedBox(height: 30,),
                      Center(
                          child: defaultButton(
                              text: "\$" + price.toString(),
                              textColor: Colors.white,
                              background: Colors.orangeAccent,
                              radius: 30,
                              width: 200,
                              function: () {
                                final isValidCardNum = cardNumKey.currentState!
                                    .validate();
                                final isValidCvv = cvvKey.currentState!.validate();
                                final isValidEd = edKey.currentState!.validate();
                                final isValidChn = chnKey.currentState!.validate();
                                if (isValidCardNum && isValidCvv && isValidEd &&
                                    isValidChn) {
                                  Provider.of<providerSeats>(context, listen: false)
                                      .reservation(movieName);
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (
                                      context) =>
                                      TransitionScreen(UserName: userName,)));
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Row(
                                      children: const [
                                        Icon(Icons.check, color: Colors.white),
                                        Text('   Payment was successful',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),),
                                      ],
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  points -= min(points, initialPrice);
                                }
                              })
                      ),
                      //const SizedBox(height: 60,),

                    ],

                  ),
                ),
              ),
          ),
        ),
      );
    },
  );
}


class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue previousValue,
      TextEditingValue nextValue,
      ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}