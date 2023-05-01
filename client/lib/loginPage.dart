



// ignore_for_file: file_names
import 'dart:convert';
import 'dart:ui';
import 'package:client/backend/adminPage.dart';
import 'package:client/background_IMG.dart';
import 'package:client/main.dart';
import 'package:client/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//mport 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
 const LoginPage({super.key});


 @override
 State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
 late TextEditingController _emailController;
 late TextEditingController _passwordController;
 bool visible = false;
 bool _isValidate = true;
 late String username;
 late String sid;
 late Map<String, dynamic> currentBooking;
 late List<dynamic> record;
 //late SharedPreferences prefs;


 @override
 void initState() {
   super.initState();
   _emailController = TextEditingController();
   _passwordController = TextEditingController();
   //initSharedPref();
 }


 @override
 void dispose() {
   _emailController.dispose();
   _passwordController.dispose();
   super.dispose();
 }


 // void initSharedPref() async {
 //   prefs = await SharedPreferences.getInstance();
 // }


 void loginUser() async {
   if (_emailController.text.isNotEmpty &&
       _passwordController.text.isNotEmpty) {
     var requestBody = {
       "email": _emailController.text,
       "password": _passwordController.text
     };
     //print(requestBody);
     var header = {
       'Content-type': 'application/json',
       'Accept': 'application/json'
     };
     var response = await http.post(
         Uri.parse(ApiConstants.baseUrl +
             ApiConstants.userEndpoint +
             ApiConstants.loginEndpoint),
         headers: header,
         body: jsonEncode(requestBody));
     if (response.statusCode == 200) {
       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
       //print(jsonResponse);
       username = jsonResponse['user']['name'];
       sid = jsonResponse['user']['_id'];
       // currentBooking = (jsonResponse['user']['currentBooking'] != null) ? jsonResponse['user']['currentBooking']: {};
       // record = (jsonResponse['user']['record'] != null) ? jsonResponse['user']['record'] : [];
       //print(sid);
       // ignore: use_build_context_synchronously
       if (jsonResponse['user']['type'] == 'admin') {
         // ignore: use_build_context_synchronously
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => AdminPage(
                       sid: sid,
                     )));
       } else {
         // ignore: use_build_context_synchronously
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => HomePage(
                       username: username,
                       sid: sid,
                     )));
       }
     } else {
       setState(() {
         _isValidate = false;
       });
     }
   }
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: BackgroundImageWidget(
         child: Center(
       child: Padding(
         padding: const EdgeInsets.all(100),
         child: BackdropFilter(
           filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
           child: Container(
               decoration: BoxDecoration(
                   color: Colors.white.withOpacity(0.2),
                   borderRadius: BorderRadius.circular(10),
                   border: Border.all(
                       width: 2,
                       color: const Color.fromARGB(255, 147, 121, 77))),
               height: 500,
               width: 700,
               child: Center(
                 child: SizedBox(
                   height: 300,
                   width: 300,
                   child: Column(
                     //mainAxisAlignment: MainAxisAlignment.start,
                     //crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text(
                         'Welcome',
                         style: TextStyle(fontSize: 35),
                       ),
                       const SizedBox(
                         height: 40,
                       ),
                       TextField(
                         controller: _emailController,
                         cursorColor: Colors.white,
                         autofocus: false,
                         decoration: const InputDecoration(
                             prefixIconColor: Color.fromARGB(255, 44, 44, 44),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                   color: Color.fromARGB(255, 0, 0, 0)),
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                   color: Color.fromARGB(255, 0, 0, 0)),
                             ),
                             labelStyle: TextStyle(
                                 color: Color.fromARGB(255, 44, 44, 44)),
                             labelText: "email",
                             prefixIcon: Icon(Icons.mail)),
                       ),
                       TextField(
                         controller: _passwordController,
                         cursorColor: Colors.white,
                         decoration: InputDecoration(
                           errorText: (_isValidate)
                               ? null
                               : 'incorrect email & password',
                           suffixIconColor:
                               const Color.fromARGB(255, 44, 44, 44),
                           prefixIconColor:
                               const Color.fromARGB(255, 44, 44, 44),
                           enabledBorder: const UnderlineInputBorder(
                             borderSide: BorderSide(
                                 color: Color.fromARGB(255, 0, 0, 0)),
                           ),
                           focusedBorder: const UnderlineInputBorder(
                             borderSide: BorderSide(
                                 color: Color.fromARGB(255, 0, 0, 0)),
                           ),
                           labelStyle: const TextStyle(
                               color: Color.fromARGB(255, 44, 44, 44)),
                           labelText: "password",
                           prefixIcon: const Icon(Icons.lock),
                           suffixIcon: GestureDetector(
                               onTap: () {
                                 setState(() {
                                   visible = !visible;
                                 });
                               },
                               child: Icon((visible == true)
                                   ? Icons.visibility_off
                                   : Icons.visibility)),
                         ),
                         obscureText: visible,
                       ),
                       const SizedBox(
                         height: 30,
                       ),
                       Container(
                         height: 50,
                         width: 200,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             border: Border.all(
                                 width: 2,
                                 color:
                                     const Color.fromARGB(255, 147, 121, 77))),
                         child: TextButton(
                             onPressed: () {
                               loginUser();
                             },
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: const [
                                 Text(
                                   'Login',
                                   style: TextStyle(color: Colors.white),
                                 ),
                                 Icon(
                                   Icons.chevron_right,
                                   color: Colors.white,
                                 ),
                               ],
                             )),
                       )
                     ],
                   ),
                 ),
               )),
         ),
       ),
     )),
   );
 }
}


