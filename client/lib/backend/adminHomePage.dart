// ignore_for_file: file_names
import 'package:client/services/Models/models.dart';
import 'package:client/services/backend.dart';
import 'package:client/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BackendHome extends StatefulWidget {
 final String sid;
 const BackendHome({super.key, required this.sid});


 @override
 State<BackendHome> createState() => _BackendHomeState();
}


class _BackendHomeState extends State<BackendHome> {
 late Future<List<UserInfo>?> getAllUserInfo;
 late Future<List<RoomInfo>?> getRoomInfo;
 @override
 void initState() {
   super.initState();
   getAllUserInfo = ApiService().getAllUserInfo();
   getRoomInfo = ApiService().getRoomsInfo();
 }


 @override
 void dispose() {
   super.dispose();
 }


 @override
 Widget build(BuildContext context) {
   return Center(
     child: Padding(
       padding: const EdgeInsets.all(80),
       child: Container(
         height: 600,
         width: 1100,
         color: Colors.black.withOpacity(0.5),
         child: Padding(
             padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
             child: FutureBuilder<List<UserInfo>?>(
               future: getAllUserInfo,
               builder: (context, snapshot) {
                 if (snapshot.hasData) {
                   return Row(children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                         Text('Overview',
                             style:
                                 TextStyle(color: Colors.white, fontSize: 20)),
                         SizedBox(
                           height: 20,
                         ),
                         Text(
                           'Venue Booking \nSystem',
                           style: TextStyle(color: Colors.white, fontSize: 40),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Text(
                           'manage User & Booking & Room',
                           style: TextStyle(color: Colors.grey, fontSize: 15),
                         )
                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 200),
                       child: Column(
                         children: [
                           Consumer<Backend>(builder: (_, backend, child) {
                             return Row(
                               children: [
                                 GestureDetector(
                                   onTap: () {
                                     backend.setRoutes(1);
                                   },
                                   child: Container(
                                     decoration: BoxDecoration(
                                         gradient: const LinearGradient(
                                           begin: Alignment.topRight,
                                           end: Alignment.bottomLeft,
                                           colors: [
                                             Colors.blue,
                                             Colors.red,
                                           ],
                                         ),
                                         borderRadius:
                                             BorderRadius.circular(20)),
                                     width: 150,
                                     height: 180,
                                     child: Stack(children: [
                                       Positioned(
                                         left: 20,
                                         bottom: 20,
                                         child: Column(
                                           crossAxisAlignment:
                                               CrossAxisAlignment.start,
                                           children: const [
                                             Text(
                                               'User',
                                               style: TextStyle(
                                                   fontSize: 18,
                                                   color: Color.fromARGB(
                                                       255, 187, 187, 187)),
                                             ),
                                             Text('collection',
                                                 style: TextStyle(
                                                     fontSize: 13,
                                                     color: Color.fromARGB(
                                                         255, 187, 187, 187)))
                                           ],
                                         ),
                                       )
                                     ]),
                                   ),
                                 ),
                                 const SizedBox(
                                   width: 50,
                                 ),
                                 GestureDetector(
                                   onTap: () {
                                     backend.setRoutes(2);
                                   },
                                   child: Container(
                                     width: 150,
                                     height: 180,
                                     decoration: BoxDecoration(
                                         gradient: const LinearGradient(
                                           begin: Alignment.topRight,
                                           end: Alignment.bottomLeft,
                                           colors: [
                                             Color(0xffDEB0DF),
                                             Color.fromARGB(255, 78, 48, 130),
                                           ],
                                         ),
                                         borderRadius:
                                             BorderRadius.circular(20)),
                                     child: Stack(children: [
                                       Positioned(
                                         left: 20,
                                         bottom: 20,
                                         child: Column(
                                           crossAxisAlignment:
                                               CrossAxisAlignment.start,
                                           children: const [
                                             Text(
                                               'Booking',
                                               style: TextStyle(
                                                   fontSize: 18,
                                                   color: Color.fromARGB(
                                                       255, 187, 187, 187)),
                                             ),
                                             Text('collection',
                                                 style: TextStyle(
                                                     fontSize: 13,
                                                     color: Color.fromARGB(
                                                         255, 187, 187, 187)))
                                           ],
                                         ),
                                       )
                                     ]),
                                   ),
                                 ),
                                 const SizedBox(
                                   width: 50,
                                 ),
                                 GestureDetector(
                                   onTap: () {
                                     backend.setRoutes(3);
                                   },
                                   child: Container(
                                     width: 150,
                                     height: 180,
                                     decoration: BoxDecoration(
                                         gradient: const LinearGradient(
                                           begin: Alignment.topRight,
                                           end: Alignment.bottomLeft,
                                           colors: [
                                             Color.fromARGB(
                                                 255, 217, 233, 151),
                                             Color.fromARGB(
                                                 255, 194, 149, 107),
                                             Color.fromARGB(255, 137, 106, 76),
                                             Color.fromARGB(255, 92, 71, 51),
                                           ],
                                         ),
                                         borderRadius:
                                             BorderRadius.circular(20)),
                                     child: Stack(children: [
                                       Positioned(
                                         left: 20,
                                         bottom: 20,
                                         child: Column(
                                           crossAxisAlignment:
                                               CrossAxisAlignment.start,
                                           children: const [
                                             Text(
                                               'Room',
                                               style: TextStyle(
                                                   fontSize: 18,
                                                   color: Color.fromARGB(
                                                       255, 187, 187, 187)),
                                             ),
                                             Text('collection',
                                                 style: TextStyle(
                                                     fontSize: 13,
                                                     color: Color.fromARGB(
                                                         255, 187, 187, 187)))
                                           ],
                                         ),
                                       )
                                     ]),
                                   ),
                                 ),
                               ],
                             );
                           }),
                           const SizedBox(height: 50),
                           Container(
                             decoration: BoxDecoration(
                                 //color: Colors.green,
                                 border: Border.all(color: Colors.white),
                                 borderRadius: BorderRadius.circular(20)),
                             width: 500,
                             height: 300,
                             child: Padding(
                               padding: const EdgeInsets.all(20),
                               child: Column(
                                   crossAxisAlignment:
                                       CrossAxisAlignment.start,
                                   children: [
                                     const Text('Database',
                                         style: TextStyle(
                                             fontSize: 25,
                                             color: Colors.white)),
                                     const SizedBox(
                                       height: 20,
                                     ),
                                     Container(
                                       decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius:
                                               BorderRadius.circular(5)),
                                       width: 450,
                                       height: 60,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Row(
                                           children: [
                                             const Icon(
                                               Icons.account_circle,
                                               size: 30,
                                             ),
                                             const SizedBox(
                                               width: 10,
                                             ),
                                             Text(
                                                 "Total user: ${snapshot.data?.length}",
                                                 style: const TextStyle(
                                                     fontSize: 16))
                                           ],
                                         ),
                                       ),
                                     ),
                                     const SizedBox(
                                       height: 10,
                                     ),
                                     Container(
                                       decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius:
                                               BorderRadius.circular(5)),
                                       width: 450,
                                       height: 60,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Row(
                                           children: [
                                             const Icon(
                                               Icons.check_box,
                                               size: 30,
                                             ),
                                             const SizedBox(
                                               width: 10,
                                             ),
                                             Text(
                                                 "Current Booking: ${snapshot.data?.where((user) => user.currentBooking != null).toList().length}",
                                                 style: const TextStyle(
                                                     fontSize: 16))
                                           ],
                                         ),
                                       ),
                                     ),
                                     const SizedBox(
                                       height: 10,
                                     ),
                                     Container(
                                       decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius:
                                               BorderRadius.circular(5)),
                                       width: 450,
                                       height: 60,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Row(
                                           children: [
                                             const Icon(
                                               Icons.room_preferences,
                                               size: 30,
                                             ),
                                             const SizedBox(
                                               width: 10,
                                             ),
                                             Row(
                                               children: [
                                                 const Text("Total rooms: ",
                                                     style: TextStyle(
                                                         fontSize: 16)),
                                                 FutureBuilder<
                                                         List<RoomInfo>?>(
                                                     future: getRoomInfo,
                                                     builder:
                                                         (context, snapshot) {
                                                       if (snapshot.hasData) {
                                                         return Text(
                                                             "${snapshot.data?.length}");
                                                       } else {
                                                         return const CircularProgressIndicator();
                                                       }
                                                     })
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                     )
                                   ]),
                             ),
                           )
                         ],
                       ),
                     ),
                   ]);
                 } else {
                   return const Center(
                     child: CircularProgressIndicator(
                       color: Colors.white,
                     ),
                   );
                 }
               },
             )),
       ),
     ),
   );
 }
}


