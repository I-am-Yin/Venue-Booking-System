import 'package:client/services/Models/models.dart';
import 'package:client/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ReviewBooking extends StatefulWidget {
 final String sid;
 final String username;
 const ReviewBooking({required this.username, required this.sid, super.key});


 @override
 State<ReviewBooking> createState() => _ReviewBookingState();
}


class _ReviewBookingState extends State<ReviewBooking> {
 late Future<UserInfo?> userInfo;
 @override
 void initState() {
   super.initState();
   userInfo = ApiService().getUserInfo(widget.sid);
 }


 @override
 Widget build(BuildContext context) {
   //print(currentBooking);
   //print(record);
   return Scaffold(
       backgroundColor: Colors.transparent,
       body: FutureBuilder<UserInfo?>(
           future: userInfo,
           builder: (context, snapshot) {
             if (snapshot.hasData) {
               return Padding(
                 padding: const EdgeInsets.fromLTRB(200, 100, 200, 0),
                 child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       const Padding(
                         padding: EdgeInsets.fromLTRB(15, 10, 0, 20),
                         child: Text(
                           'Current',
                           style: TextStyle(fontSize: 30, color: Colors.white),
                         ),
                       ),
                       (snapshot.data?.currentBooking != null)
                           ? Container(
                               height: 100,
                               decoration: BoxDecoration(
                                   color: Colors.white.withOpacity(0.2),
                                   border: Border.all(
                                       width: 3,
                                       color: const Color.fromARGB(
                                           255, 147, 121, 77))),
                               child: Padding(
                                   padding: const EdgeInsets.only(top: 10),
                                   child: ListTile(
                                     title: Text(
                                         '${snapshot.data?.currentBooking?.cat} (${snapshot.data?.currentBooking?.rid})'),
                                     subtitle: Column(
                                       crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                             'start time: ${snapshot.data?.currentBooking?.startTime} | end time: ${snapshot.data?.currentBooking?.endTime}'),
                                         Text(
                                             'reasons: ${snapshot.data?.currentBooking?.reason}'),
                                         Row(
                                           children: [
                                             const Text('status: '),
                                             Text(
                                               (snapshot.data?.currentBooking
                                                           ?.available ==
                                                       true)
                                                   ? 'accepted'
                                                   : 'waiting...',
                                               style: TextStyle(
                                                 color: (snapshot
                                                             .data
                                                             ?.currentBooking
                                                             ?.available ==
                                                         true)
                                                     ? Colors.green
                                                     : Colors.yellow,
                                               ),
                                             )
                                           ],
                                         )
                                       ],
                                     ),
                                     trailing: Padding(
                                       padding:
                                           const EdgeInsets.only(right: 20),
                                       child: Column(children: [
                                         Text(
                                           '${snapshot.data?.currentBooking?.dates}',
                                         ),
                                         TextButton(
                                             onPressed: () async {
                                               await ApiService()
                                                   .updateUserInfo(
                                                       widget.sid,{"currentBooking": {}});
                                               userInfo = ApiService()
                                                   .getUserInfo(widget.sid);
                                               // ignore: use_build_context_synchronously
                                               showDialog(
                                                   context: context,
                                                   builder: ((context) =>
                                                       CupertinoAlertDialog(
                                                         title: Center(
                                                             child: Container(
                                                           decoration: BoxDecoration(
                                                               color: Colors
                                                                   .greenAccent,
                                                               borderRadius:
                                                                   BorderRadius
                                                                       .circular(
                                                                           40)),
                                                           height: 50,
                                                           width: 50,
                                                           child: const Icon(
                                                             Icons.done,
                                                             color:
                                                                 Colors.white,
                                                           ),
                                                         )),
                                                         //content: ,
                                                         actions: <Widget>[
                                                           CupertinoDialogAction(
                                                             isDefaultAction:
                                                                 true,
                                                             onPressed: () {
                                                               Navigator.of(
                                                                       context)
                                                                   .pop();
                                                             },
                                                             child: const Text(
                                                                 'confirm!'),
                                                           )
                                                         ],
                                                       )));
                                               setState(() {});
                                             },
                                             child: const Text(
                                               'cancel',
                                               style: TextStyle(
                                                   color: Color.fromARGB(
                                                       255, 219, 100, 91)),
                                             ))
                                       ]),
                                     ),
                                   )),
                             )
                           : const Center(child: Text('no current booking')),
                       const SizedBox(
                         height: 30,
                       ),
                       const Padding(
                         padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                         child: Text('History',
                             style:
                                 TextStyle(fontSize: 30, color: Colors.white)),
                       ),
                       Container(
                           alignment: Alignment.topCenter,
                           width: 500,
                           height: 400,
                           child: (snapshot.data?.record != null)
                               ? SingleChildScrollView(
                                   scrollDirection: Axis.vertical,
                                   child: ListView.builder(
                                       shrinkWrap: true,
                                       itemCount:
                                           snapshot.data?.record?.length,
                                       itemBuilder: (context, index) {
                                         return Padding(
                                             padding:
                                                 const EdgeInsets.all(10.0),
                                             child: Column(
                                               children: [
                                                 Container(
                                                   decoration: BoxDecoration(
                                                       color: Colors.white
                                                           .withOpacity(0.2),
                                                       border: Border.all(
                                                           width: 2,
                                                           color: const Color
                                                                   .fromARGB(
                                                               255,
                                                               147,
                                                               121,
                                                               77))),
                                                   child: ListTile(
                                                     trailing: Text(
                                                         '${snapshot.data?.record?[index].dates}'),
                                                     title: Text(
                                                         '${snapshot.data?.record?[index].cat}(${snapshot.data?.record?[index].rid})'),
                                                     subtitle: Column(
                                                       crossAxisAlignment:
                                                           CrossAxisAlignment
                                                               .start,
                                                       children: [
                                                         Text(
                                                             'start time: ${snapshot.data?.record?[index].startTime} | end time: ${snapshot.data?.record?[index].endTime}'),
                                                         Text(
                                                             'reasons: ${snapshot.data?.record?[index].reason}'),
                                                       ],
                                                     ),
                                                   ),
                                                 ),
                                                 const Divider(
                                                   color: Colors.white,
                                                 )
                                               ],
                                             ));
                                       }),
                                 )
                               : null)
                     ]),
               );
             } else {
               return const Center(child: CircularProgressIndicator(color: Colors.white,),);
             }
           }));
 }
}
