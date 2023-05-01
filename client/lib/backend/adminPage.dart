

// ignore_for_file: file_names
//import 'package:client/Models/models.dart';
import 'package:client/backend/adminHomePage.dart';
import 'package:client/backend/adminRoomPage.dart';
import 'package:client/background_IMG.dart';
import 'package:client/services/backend.dart';
//import 'package:client/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'adminBookingPage.dart';
import 'adminUserPage.dart';


class AdminPage extends StatelessWidget {
 final String sid;
 const AdminPage({super.key, required this.sid});


 @override
 Widget build(BuildContext context) {
   return Consumer<Backend>(builder: (_, backend, child) {
     return Scaffold(
         extendBodyBehindAppBar: true,
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           elevation: 1,
           centerTitle: true,
           automaticallyImplyLeading: false,
           title: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 70),
                 child: TextButton(
                     onPressed: () {
                       backend.setRoutes(0);
                       //print(backend.routes);
                     },
                     child: Text(
                       'Overview',
                       style: TextStyle(
                           color: (backend.routes == 0)
                               ? Colors.white
                               : Colors.grey),
                     )),
               ),
               TextButton(
                   onPressed: () {
                     backend.setRoutes(1);
                     //print(backend.routes);
                   },
                   child: Text('User',
                       style: TextStyle(
                           color: (backend.routes == 1)
                               ? Colors.white
                               : Colors.grey))),
               TextButton(
                   onPressed: () {
                     backend.setRoutes(2);
                     //print(backend.routes);
                   },
                   child: Text('Booking',
                       style: TextStyle(
                           color: (backend.routes == 2)
                               ? Colors.white
                               : Colors.grey))),
               TextButton(
                   onPressed: () {
                     backend.setRoutes(3);
                     //print(backend.routes);
                   },
                   child: Text('Room',
                       style: TextStyle(
                           color: (backend.routes == 3)
                               ? Colors.white
                               : Colors.grey))),
             ],
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
             child: (backend.routes == 0)
                 ? BackendHome(sid: sid)
                 : (backend.routes == 1)
                     ? const BackendUser()
                     : (backend.routes == 2)
                         ? const BackendBooking()
                         : const BackendRoom()));
   });
 }
}


