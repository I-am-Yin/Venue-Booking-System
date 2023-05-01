// ignore_for_file: file_names
import 'package:client/services/Models/models.dart';
import 'package:client/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BackendRoom extends StatefulWidget {
 const BackendRoom({super.key});


 @override
 State<BackendRoom> createState() => _BackendRoomState();
}


class _BackendRoomState extends State<BackendRoom> {
 String? chosenRoomType = "classroom";
 var roomTypeList = [
   'classroom',
   'hall',
   'music room',
   'playground',
   'IT room',
   'canteen',
 ];


 late Future<List<RoomInfo>?> getAllRoomsInfo;
 late TextEditingController _roomIDController;


 @override
 void initState() {
   super.initState();
   getAllRoomsInfo = ApiService().getRoomsInfo();
   _roomIDController = TextEditingController();
 }


 @override
 void dispose() {
   super.dispose();
 }


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
             content: const Text('Delete Room'),
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
                     await ApiService().deleteRoomByID(sid);
                     // ignore: use_build_context_synchronously
                     Navigator.of(context).pop();
                     showSuccessDialog();
                     setState(() {
                       getAllRoomsInfo = ApiService().getRoomsInfo();
                     });
                   },
                   child: const Text('sure'))
             ],
           )));
 }


 void openCreateRoomDialog() {
   _roomIDController.text = '';
   showDialog(
       context: context,
       builder: (context) => UnconstrainedBox(
             child: SizedBox(
               height: 400,
               width: 400,
               child: StatefulBuilder(
                 builder: (context, setSState) {
                   return AlertDialog(
                     title: const Text('Create new room'),
                     content: Column(
                       children: [
                         TextField(
                           decoration: const InputDecoration(
                             hintText: 'room ID',
                           ),
                           controller: _roomIDController,
                           autofocus: false,
                         ),
                         const SizedBox(
                           height: 20,
                         ),
                         DropdownButton(
                             value: chosenRoomType,
                             items: roomTypeList.map((String roomType) {
                               return DropdownMenuItem(
                                   value: roomType, child: Text(roomType));
                             }).toList(),
                             onChanged: (chosen) {
                               setSState(
                                 () {
                                   chosenRoomType = chosen as String;
                                 },
                               );
                             })
                       ],
                     ),
                     actions: [
                       TextButton(
                           onPressed: () {
                             Navigator.of(context).pop();
                           },
                           child: const Text('cancel')),
                       TextButton(
                           onPressed: () async {
                             if (_roomIDController.text.isNotEmpty) {
                               var requestBody = {
                                 "rid": _roomIDController.text,
                                 "cat": chosenRoomType,
                                 "available": true
                               };
                               await ApiService().createNewRoom(requestBody);
                               // ignore: use_build_context_synchronously
                               Navigator.of(context).pop();
                               showSuccessDialog();
                               setState(() {
                                 getAllRoomsInfo = ApiService().getRoomsInfo();
                               });
                             } else {
                               showDialog(
                                   context: context,
                                   builder: ((context) => CupertinoAlertDialog(
                                         title: const Text(
                                           'room ID should not remain empty',
                                         ),
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
                           },
                           child: const Text('Submit')),
                     ],
                   );
                 },
               ),
             ),
           ));
 }


 @override
 Widget build(BuildContext context) {
   return DefaultTabController(
     length: 7,
     child: Scaffold(
       backgroundColor: Colors.transparent,
       appBar: const PreferredSize(
         preferredSize: Size.fromHeight(kToolbarHeight),
         child: Padding(
             padding: EdgeInsets.only(top: 60),
             child: TabBar(tabs: [
               Tab(
                 child: Text('All'),
               ),
               Tab(
                 child: Text('Classroom'),
               ),
               Tab(
                 child: Text('Hall'),
               ),
               Tab(
                 child: Text('Music Room'),
               ),
               Tab(
                 child: Text('Playground'),
               ),
               Tab(
                 child: Text('IT room'),
               ),
               Tab(
                 child: Text('canteen'),
               ),
             ])),
       ),
       body: FutureBuilder<List<RoomInfo>?>(
         future: getAllRoomsInfo,
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             List<RoomInfo>? classroomList = snapshot.data
                 ?.where((element) => element.cat == "classroom")
                 .toList();
             List<RoomInfo>? hallList = snapshot.data
                 ?.where((element) => element.cat == "hall")
                 .toList();
             List<RoomInfo>? musicRoomList = snapshot.data
                 ?.where((element) => element.cat == "music room")
                 .toList();
             List<RoomInfo>? playGroundList = snapshot.data
                 ?.where((element) => element.cat == "playground")
                 .toList();
             // ignore: non_constant_identifier_names
             List<RoomInfo>? itRoomList = snapshot.data
                 ?.where((element) => element.cat == "IT room")
                 .toList();
             List<RoomInfo>? canteenList = snapshot.data
                 ?.where((element) => element.cat == "canteen")
                 .toList();
             return Padding(
               padding: const EdgeInsets.symmetric(horizontal: 400),
               child: TabBarView(children: [
                 //all room view
                 RoomListView(snapshot.data),
                 // only show classroom
                 RoomListView(classroomList),
                 // only show hall
                 RoomListView(hallList),
                 // only show music room
                 RoomListView(musicRoomList),
                 // only show playground
                 RoomListView(playGroundList),
                 // only show IT room
                 RoomListView(itRoomList),
                 // only show canteen
                 RoomListView(canteenList)
               ]),
             );
           } else {
             return const Center(
               child: CircularProgressIndicator(color: Colors.white),
             );
           }
         },
       ),
       floatingActionButton: Padding(
         padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
         child: FloatingActionButton(
           backgroundColor: Colors.black.withOpacity(0.5),
           child: const Icon(
             Icons.add,
             color: Colors.white,
           ),
           onPressed: () {
             openCreateRoomDialog();
           },
         ),
       ),
     ),
   );
 }


 // ignore: non_constant_identifier_names
 Widget RoomListView(List<RoomInfo>? RoomList) => ListView.builder(
     itemCount: RoomList?.length,
     itemBuilder: (context, index) {
       return Column(
         children: [
           Container(
             color: Colors.white.withOpacity(0.2),
             child: ListTile(
               title:
                   Text("${RoomList?[index].cat} (${RoomList?[index].rid})"),
               trailing: Wrap(
                 spacing: 20,
                 children: [
                   Container(
                     width: 100,
                     height: 40,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(40),
                         color: (RoomList?[index].available == true)
                             ? Colors.green.withOpacity(0.5)
                             : Colors.red.withOpacity(0.5)),
                     child: Text(
                       (RoomList?[index].available == true)
                           ? "available"
                           : "unavailable",
                       style: const TextStyle(color: Colors.white),
                     ),
                   ),
                   IconButton(
                       onPressed: () async {
                         bool available = RoomList?[index].available as bool;
                         //print("${!available}");
                         var requestBody = {"available": !available};
                         await ApiService().changeRoomIsAvailable(
                             "${RoomList?[index].sId}", requestBody);
                         showSuccessDialog();
                         setState(() {
                           getAllRoomsInfo = ApiService().getRoomsInfo();
                         });
                       },
                       icon: const Icon(
                         Icons.edit,
                         color: Colors.green,
                       )),
                   IconButton(
                       onPressed: () {
                         showAlertDialog("${RoomList?[index].sId}");
                         setState(() {
                           getAllRoomsInfo = ApiService().getRoomsInfo();
                         });
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
