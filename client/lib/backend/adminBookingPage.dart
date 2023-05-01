// ignore_for_file: file_names
import 'package:client/services/Models/models.dart';
import 'package:client/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BackendBooking extends StatefulWidget {
 const BackendBooking({super.key});


 @override
 State<BackendBooking> createState() => _BackendBookingState();
}


class _BackendBookingState extends State<BackendBooking> {
 late Future<List<UserInfo>?> getAllUserInfo;


 void showSuccessDialog() async {
   return showDialog(
       context: context,
       builder: ((context) => CupertinoAlertDialog(
             title: Center(
                 child: Container(
               decoration: BoxDecoration(
                   color: Colors.greenAccent,
                   borderRadius: BorderRadius.circular(40)),
               height: 50,
               width: 50,
               child: const Icon(
                 Icons.done,
                 color: Colors.white,
               ),
             )),
             //content: ,
             actions: <Widget>[
               CupertinoDialogAction(
                 isDefaultAction: true,
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
                 child: const Text('confirm!'),
               )
             ],
           )));
 }


 void showAlertDialog(String sid) async {
   return showDialog(
       context: context,
       builder: ((context) => CupertinoAlertDialog(
             title: const Text("Sure?"),
             content: const Text("Delete Booking"),
             actions: <Widget>[
               CupertinoDialogAction(
                 isDefaultAction: true,
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
                 child: const Text('cancel'),
               ),
               CupertinoDialogAction(
                   isDefaultAction: true,
                   onPressed: () async {
                     var responseBody = {"currentBooking": {}};
                     await ApiService().updateUserInfo(sid, responseBody);
                     // ignore: use_build_context_synchronously
                     Navigator.of(context).pop();
                     showSuccessDialog();
                     setState(() {
                       getAllUserInfo = ApiService().getAllUserInfo();
                     });
                   },
                   child: const Text('sure'))
             ],
           )));
 }


 @override
 void initState() {
   super.initState();
   getAllUserInfo = ApiService().getAllUserInfo();
 }


 @override
 void dispose() {
   super.dispose();
 }


 @override
 Widget build(BuildContext context) {
   return DefaultTabController(
       length: 3,
       child: Scaffold(
         backgroundColor: Colors.transparent,
         appBar: const PreferredSize(
           preferredSize: Size.fromHeight(kToolbarHeight),
           child: Padding(
             padding: EdgeInsets.only(top: 60),
             child: TabBar(tabs: [
               Tab(child: Text("All")),
               Tab(child: Text("waiting")),
               Tab(child: Text("accepted")),
             ]),
           ),
         ),
         body: FutureBuilder<List<UserInfo>?>(
           future: getAllUserInfo,
           builder: (context, snapshot) {
             if (snapshot.hasData) {
               List<UserInfo>? allList = snapshot.data
                   ?.where((element) => element.currentBooking != null)
                   .toList();
               List<UserInfo>? waitingList = snapshot.data
                   ?.where((element) =>
                       element.currentBooking != null &&
                       element.currentBooking?.available == false)
                   .toList();
               List<UserInfo>? acceptedList = snapshot.data
                   ?.where((element) =>
                       element.currentBooking != null &&
                       element.currentBooking?.available == true)
                   .toList();
               return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 400),
                 child: TabBarView(children: [
                   BookingListView(allList),
                   // only show waiting
                   (waitingList?.length != null)
                       ? BookingListView(waitingList)
                       : const Center(
                           child: Text("no booking is waiting for permission"),
                         ),
                   // only show accepted
                   (acceptedList!.isNotEmpty)
                       ? BookingListView(acceptedList)
                       : const Center(
                           child: Text("no booking is accepted"),
                         )
                 ]),
               );
             } else {
               return const Center(
                 child: CircularProgressIndicator(
                   color: Colors.white,
                 ),
               );
             }
           },
         ),
       ));
 }


 // ignore: non_constant_identifier_names
 Widget BookingListView(List<UserInfo>? BookingList) => ListView.builder(
     itemCount: BookingList?.length,
     itemBuilder: (context, index) {
       return Column(
         children: [
           Container(
             color: Colors.white.withOpacity(0.2),
             child: ListTile(
               title: Text(
                   "${BookingList?[index].name}: ${BookingList?[index].currentBooking?.cat} (${BookingList?[index].currentBooking?.rid})"),
               subtitle: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                         "${BookingList?[index].currentBooking?.dates}  ${BookingList?[index].currentBooking?.startTime} > ${BookingList?[index].currentBooking?.endTime}"),
                     Text(
                         "reason: ${BookingList?[index].currentBooking?.reason}")
                   ]),
               trailing: Wrap(
                 spacing: 20,
                 children: [
                   Container(
                     width: 100,
                     height: 40,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(40),
                         color:
                             (BookingList?[index].currentBooking?.available ==
                                     true)
                                 ? Colors.green.withOpacity(0.5)
                                 : Colors.yellow.withOpacity(0.5)),
                     child: Text(
                         (BookingList?[index].currentBooking?.available ==
                                 true)
                             ? "accepted"
                             : "waiting"),
                   ),
                   IconButton(
                       onPressed: () async {
                         bool available = BookingList?[index]
                             .currentBooking
                             ?.available as bool;
                         //print("${!available}");
                         var requestBody = {
                           "currentBooking": {
                             "rid":
                                 "${BookingList?[index].currentBooking?.rid}",
                             "cat":
                                 "${BookingList?[index].currentBooking?.cat}",
                             "reason":
                                 "${BookingList?[index].currentBooking?.reason}",
                             "dates":
                                 "${BookingList?[index].currentBooking?.dates}",
                             "startTime":
                                 "${BookingList?[index].currentBooking?.startTime}",
                             "endTime":
                                 "${BookingList?[index].currentBooking?.endTime}",
                             "available": !available
                           }
                         };
                         await ApiService().changeBookingIsAvailable(
                             "${BookingList?[index].sId}", requestBody);
                         showSuccessDialog();
                         setState(() {
                           getAllUserInfo = ApiService().getAllUserInfo();
                         });
                       },
                       icon: const Icon(
                         Icons.edit,
                         color: Colors.green,
                       )),
                   IconButton(
                       onPressed: () async {
                         showAlertDialog("${BookingList?[index].sId}");
                       },
                       icon: const Icon(
                         Icons.delete,
                         color: Colors.red,
                       )),
                 ],
               ),
             ),
           ),
           const Divider(
             color: Colors.white,
           )
         ],
       );
     });
}


