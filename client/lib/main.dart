import 'package:client/background_IMG.dart';
import 'package:client/frontend/homeWidget/newBooking.dart';
import 'package:client/frontend/homeWidget/reviewbooking.dart';
import 'package:client/loginPage.dart';
import 'package:client/services/backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
 // WidgetsFlutterBinding.ensureInitialized();
 // SharedPreferences prefs = await SharedPreferences.getInstance();
 runApp(MultiProvider(
   providers: [
     ChangeNotifierProvider<Backend>(create: (context) => Backend())
   ],
   child: const MaterialApp(
       debugShowCheckedModeBanner: false, home: LoginPage()),
 ));
}


class HomePage extends StatefulWidget {
 final String username;
 final String sid;
 //final token;
 const HomePage(
     {required this.username,
     required this.sid,
     super.key}); //required this.token
 @override
 State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
 bool newBookingPage = true;
 //late String email;
 @override
 void initState() {
   super.initState();
   // Map<String, dynamic> jwtDecoderdToken = JwtDecoder.decode(widget.token);
   // email = jwtDecoderdToken['email'];
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
       extendBodyBehindAppBar: true,
       backgroundColor: Colors.transparent,
       appBar: AppBar(
         automaticallyImplyLeading: false,
         elevation: 1,
         backgroundColor: Colors.transparent,
         title: Padding(
           padding: const EdgeInsets.only(left: 120.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               TextButton(
                 onPressed: () {
                   // state management
                   setState(() {
                     // print(newBooking);
                     newBookingPage = true;
                   });
                 },
                 child: Text(
                   "New Booking",
                   style: TextStyle(
                       color: (newBookingPage == true)
                           ? Colors.white
                           : Colors.grey),
                 ),
               ),
               TextButton(
                 onPressed: () {
                   setState(() {
                     // print(newBooking);
                     newBookingPage = false;
                   });
                 },
                 child: Text(
                   "Review Booking",
                   style: TextStyle(
                       color: (newBookingPage == false)
                           ? Colors.white
                           : Colors.grey),
                 ),
               ),
             ],
           ),
         ),
         actions: [
           Padding(
             padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
             child: Container(
               width: 100,
               height: 40,
               decoration: BoxDecoration(
                   border: Border.all(color: Colors.white),
                   borderRadius: BorderRadius.circular(40)),
               child: TextButton(
                   onPressed: () {
                     Navigator.pop(context);
                   },
                   child: const Text(
                     'Logout',
                     style: TextStyle(color: Colors.white),
                   )),
             ),
           )
         ],
       ),
       body: BackgroundImageWidget(
           child: (newBookingPage == true)
               ? NewBooking(
                   username: widget.username,
                   sid: widget.sid,
                 )
               : ReviewBooking(
                   sid: widget.sid,
                   username: widget.username,
                 )));
 }
}
