// ignore_for_file: file_names
import 'dart:convert';
import 'dart:ui';
import 'package:client/services/Models/models.dart';
import 'package:client/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class NewBooking extends StatefulWidget {
 final String username;
 final String sid;
 const NewBooking({required this.username, required this.sid, super.key});


 @override
 State<NewBooking> createState() => _NewBookingState();
}


class _NewBookingState extends State<NewBooking> {
 late TextEditingController _textEditingController;
 bool _isValidate = true;
 String? chosenRoomType = 'classroom';
 String? chosenRoom = '210';
 static DateTime? datevalue = DateTime.now();
 String startTime =
     '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}';
 String endTime =
     '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}';
 int startInt = int.parse(
     '${TimeOfDay.now().hour.toString().padLeft(2, '0')}${TimeOfDay.now().minute.toString().padLeft(2, '0')}');
 int endInt = int.parse(
     '${TimeOfDay.now().hour.toString().padLeft(2, '0')}${TimeOfDay.now().minute.toString().padLeft(2, '0')}');


 // List of items in our dropdown menu
 var roomTypeList = [
   'classroom',
   'hall',
   'music room',
   'playground',
   'IT room',
   'canteen',
 ];
 late Future<List<RoomInfo>?> roomInfo;
 @override
 void initState() {
   super.initState();
   roomInfo = ApiService().getRoomsInfo();
   _textEditingController = TextEditingController();
 }


 @override
 void dispose() {
   _textEditingController.dispose();
   super.dispose();
 }


 void submitBooking() async {
   if (_textEditingController.text.isNotEmpty && !(startInt >= endInt)) {
     var requestBody = {
       "currentBooking": {
         "rid": "$chosenRoom",
         "cat": "$chosenRoomType",
         "reason": _textEditingController.text,
         "dates": DateFormat('yyyy-MM-dd').format(datevalue as DateTime),
         "startTime": startTime,
         "endTime": endTime,
         "available": false
       }
     };
     //print(requestBody);
     var header = {
       'Content-type': 'application/json',
       'Accept': 'application/json'
     };
     var response = await http.patch(
         Uri.parse(
             "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/${widget.sid}"),
         headers: header,
         body: jsonEncode(requestBody));
     if (response.statusCode == 200) {
       // ignore: use_build_context_synchronously
       showDialog(
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
       setState(() {
         // initialize all the input value
         _textEditingController.text = '';
         _isValidate = true;
         chosenRoomType = 'classroom';
         chosenRoom = '210';
         datevalue = DateTime.now();
         startTime =
             '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}';
         endTime =
             '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}';
         startInt = int.parse(
             '${TimeOfDay.now().hour.toString().padLeft(2, '0')}${TimeOfDay.now().minute.toString().padLeft(2, '0')}');
         endInt = int.parse(
             '${TimeOfDay.now().hour.toString().padLeft(2, '0')}${TimeOfDay.now().minute.toString().padLeft(2, '0')}');
       });
     }
   } else {
     setState(() {
       _isValidate = false;
     });
   }
 }


 @override
 Widget build(BuildContext context) {
   return Center(
       child: Padding(
     padding: const EdgeInsets.all(100),
     child: Container(
       alignment: Alignment.center,
       child: ClipRRect(
         borderRadius: BorderRadius.circular(10),
         child: BackdropFilter(
           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
           child: Container(
               decoration: BoxDecoration(
                   color: Colors.white.withOpacity(0.2),
                   borderRadius: BorderRadius.circular(10),
                   border: Border.all(
                       width: 2,
                       color: const Color.fromARGB(255, 147, 121, 77))),
               height: 600,
               width: 700,
               child: Padding(
                   padding: const EdgeInsets.all(30),
                   child: FutureBuilder<List<RoomInfo>?>(
                       future: roomInfo,
                       builder: (context, snapshot) {
                         if (snapshot.hasData) {
                           // print(chosenRoomType);
                           // print(snapshot.data!
                           //     .where(
                           //         (element) => element.cat == chosenRoomType)
                           //     .map((e) => e.rid));
                           return Stack(
                             children: [
                               Column(
                                   crossAxisAlignment:
                                       CrossAxisAlignment.start,
                                   children: [
                                     Row(
                                       children: [
                                         const Text(
                                           'Venues: ',
                                           style: TextStyle(fontSize: 17),
                                         ),
                                         DropdownButton(
                                             iconDisabledColor: Colors.white54,
                                             iconEnabledColor: Colors.white54,
                                             value: chosenRoomType,
                                             items: roomTypeList
                                                 .map((String items) {
                                               return DropdownMenuItem(
                                                 value: items,
                                                 child: Text(items),
                                               );
                                             }).toList(),
                                             onChanged: (choose) {
                                               setState(() {
                                                 chosenRoomType =
                                                     choose as String;
                                                 chosenRoom = snapshot.data!
                                                     .where((element) =>
                                                         element.cat ==
                                                         chosenRoomType)
                                                     .toList()
                                                     .first
                                                     .rid
                                                     .toString();
                                               });
                                             }),
                                         DropdownButton(
                                             iconDisabledColor: Colors.white54,
                                             iconEnabledColor: Colors.white54,
                                             value: chosenRoom,
                                             items: snapshot.data!
                                                 .where((element) =>
                                                     element.cat ==
                                                     chosenRoomType)
                                                 .map((room) {
                                               return DropdownMenuItem(
                                                 value: ('${room.rid}'),
                                                 child: Text("${room.rid}"),
                                               );
                                             }).toList(),
                                             onChanged: (choose) {
                                               setState(() {
                                                 chosenRoom = choose;
                                               });
                                             }),
                                       ],
                                     ),
                                     const SizedBox(
                                       height: 20,
                                     ),
                                     Row(
                                       children: [
                                         Text(
                                             'Dates: ${DateFormat('yyyy-MM-dd').format(datevalue as DateTime)}'),
                                         const SizedBox(
                                           width: 10,
                                         ),
                                         GestureDetector(
                                             onTap: () async {
                                               datevalue =
                                                   await showDatePicker(
                                                       context: context,
                                                       initialDate: datevalue
                                                           as DateTime,
                                                       firstDate:
                                                           DateTime(2020, 01),
                                                       lastDate:
                                                           DateTime(2100, 12));
                                               if (datevalue != null) {
                                                 setState(() {});
                                               } else {
                                                 datevalue = DateTime.now();
                                               }
                                             },
                                             child: const Icon(
                                               Icons.calendar_month,
                                               color: Colors.white,
                                             )),
                                         const SizedBox(
                                           width: 30,
                                         ),
                                         Text('Start Time: $startTime'),
                                         const SizedBox(
                                           width: 10,
                                         ),
                                         GestureDetector(
                                             onTap: () async {
                                               final timeOfDay =
                                                   await showTimePicker(
                                                       context: context,
                                                       initialTime:
                                                           TimeOfDay.now());
                                               if (timeOfDay != null) {
                                                 setState(() {
                                                   if (timeOfDay.minute < 10) {
                                                     startTime =
                                                         '${timeOfDay.hour}:0${timeOfDay.minute}';
                                                     startInt = int.parse(
                                                         '${timeOfDay.hour}0${timeOfDay.minute}');
                                                   } else {
                                                     startTime =
                                                         '${timeOfDay.hour}:${timeOfDay.minute}';
                                                     startInt = int.parse(
                                                         '${timeOfDay.hour}0${timeOfDay.minute}');
                                                   }
                                                 });
                                               }
                                             },
                                             child: const Icon(
                                               Icons.schedule,
                                               color: Colors.white,
                                             )),
                                         const SizedBox(
                                           width: 30,
                                         ),
                                         Text('End Time: $endTime'),
                                         const SizedBox(
                                           width: 10,
                                         ),
                                         GestureDetector(
                                             onTap: () async {
                                               final timeOfDay =
                                                   await showTimePicker(
                                                       context: context,
                                                       initialTime:
                                                           TimeOfDay.now());
                                               if (timeOfDay != null) {
                                                 setState(() {
                                                   if (timeOfDay.minute < 10) {
                                                     endTime =
                                                         '${timeOfDay.hour}:0${timeOfDay.minute}';
                                                     endInt = int.parse(
                                                         '${timeOfDay.hour}:${timeOfDay.minute}');
                                                   } else {
                                                     endTime =
                                                         '${timeOfDay.hour}:${timeOfDay.minute}';
                                                     endInt = int.parse(
                                                         '${timeOfDay.hour}0${timeOfDay.minute}');
                                                   }
                                                 });
                                               }
                                             },
                                             child: const Icon(
                                               Icons.schedule,
                                               color: Colors.white,
                                             )),
                                       ],
                                     ),
                                     const SizedBox(
                                       height: 20,
                                     ),
                                     TextField(
                                       controller: _textEditingController,
                                       cursorColor: Colors.white,
                                       decoration: InputDecoration(
                                           errorText: (_isValidate)
                                               ? null
                                               : 'cannot remain empty && start time must be before end time',
                                           enabledBorder:
                                               const UnderlineInputBorder(
                                             borderSide: BorderSide(
                                                 color: Color.fromARGB(
                                                     255, 0, 0, 0)),
                                           ),
                                           focusedBorder:
                                               const UnderlineInputBorder(
                                             borderSide: BorderSide(
                                                 color: Color.fromARGB(
                                                     255, 0, 0, 0)),
                                           ),
                                           labelStyle: const TextStyle(
                                               color: Color.fromARGB(
                                                   255, 44, 44, 44)),
                                           hintText: '',
                                           labelText: 'reasons for booking: '),
                                     ),
                                   ]),
                               Positioned(
                                   bottom: 30,
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(
                                         horizontal: 250),
                                     child: GestureDetector(
                                       onTap: () {
                                         submitBooking();
                                       },
                                       child: Container(
                                         alignment: Alignment.center,
                                         decoration: BoxDecoration(
                                             borderRadius:
                                                 BorderRadius.circular(40),
                                             border: Border.all(
                                                 color: const Color.fromARGB(
                                                     255, 147, 121, 77),
                                                 width: 2)),
                                         width: 150,
                                         height: 50,
                                         child: const Text(
                                           'submit',
                                           style:
                                               TextStyle(color: Colors.white),
                                         ),
                                       ),
                                     ),
                                   ))
                             ],
                           );
                         } else {
                           return const Center(
                             child: SizedBox(
                               height: 80,
                               width: 80,
                               child: CircularProgressIndicator(
                                 color: Colors.white,
                               ),
                             ),
                           );
                         }
                       }))),
         ),
       ),
     ),
   ));
 }
}



