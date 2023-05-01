// ignore_for_file: file_names
//import 'dart:convert';
import 'package:client/services/Models/models.dart';
import 'package:client/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';


class BackendUser extends StatefulWidget {
 const BackendUser({super.key});


 @override
 State<BackendUser> createState() => _BackendUserState();
}


class _BackendUserState extends State<BackendUser> {
 var userTypeList = [
   'student',
   'teacher',
   'admin',
 ];
 String? chosenUserType = 'student';
 late Future<List<UserInfo>?> getAllUserInfo;
 late TextEditingController _nameController;
 late TextEditingController _emailController;
 late TextEditingController _passwordController;
 late TextEditingController _ueserIDController;


 @override
 void initState() {
   super.initState();
   getAllUserInfo = ApiService().getAllUserInfo();
   _ueserIDController = TextEditingController();
   _nameController = TextEditingController();
   _emailController = TextEditingController();
   _passwordController = TextEditingController();
 }


 @override
 void dispose() {
   super.dispose();
 }


 void showSuccessDialog() async {
   return await showDialog(
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


 void openEditDialog(
     String origName, String origEmail, origPassword, String sid) {
   _nameController.text = origName;
   _emailController.text = origEmail;
   _passwordController.text = origPassword;
   showDialog(
       context: context,
       builder: (context) => UnconstrainedBox(
             child: SizedBox(
               height: 400,
               width: 400,
               child: AlertDialog(
                 title: const Text('Edit user account'),
                 content: Column(children: [
                   TextField(
                     decoration: const InputDecoration(
                       hintText: 'name',
                     ),
                     controller: _nameController,
                     autofocus: false,
                   ),
                   TextField(
                     decoration: const InputDecoration(
                       hintText: 'email',
                     ),
                     controller: _emailController,
                     autofocus: false,
                   ),
                   TextField(
                     decoration: const InputDecoration(
                       hintText: 'password',
                     ),
                     controller: _passwordController,
                     autofocus: false,
                   ),
                 ]),
                 actions: [
                   TextButton(
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                       child: const Text('cancel')),
                   TextButton(
                       onPressed: () async {
                         if (_nameController.text.isNotEmpty &&
                             _emailController.text.isNotEmpty &&
                             _passwordController.text.isNotEmpty) {
                           String hashPW = BCrypt.hashpw(
                               _passwordController.text, BCrypt.gensalt());
                           var requestBody = {
                             "name": _nameController.text,
                             "email": _emailController.text,
                             "password": hashPW
                           };
                           try {
                             await ApiService()
                                 .updateUserInfo(sid, requestBody);
                             // ignore: use_build_context_synchronously
                             Navigator.of(context).pop();
                             showSuccessDialog();
                             setState(() {
                               getAllUserInfo = ApiService().getAllUserInfo();
                             });
                           } catch (e) {
                             //print(e);
                           }
                         }
                         // ignore: use_build_context_synchronously
                         // Navigator.of(context).pop();
                       },
                       child: const Text('SUBMIT'))
                 ],
               ),
             ),
           ));
 }


 void openSignUpUserDialog() {
   _ueserIDController.text = '';
   _nameController.text = '';
   _emailController.text = '';
   _passwordController.text = '';
   showDialog(
       context: context,
       builder: (context) => UnconstrainedBox(
             child: SizedBox(
               height: 500,
               width: 400,
               child: AlertDialog(
                 title: const Text('Create user account'),
                 content: Column(children: [
                   TextField(
                     decoration: const InputDecoration(
                       hintText: 'uid',
                     ),
                     controller: _ueserIDController,
                     autofocus: false,
                   ),
                   TextField(
                     decoration: const InputDecoration(
                       hintText: 'name',
                     ),
                     controller: _nameController,
                     autofocus: false,
                   ),
                   TextField(
                     decoration: const InputDecoration(
                       hintText: 'email',
                     ),
                     controller: _emailController,
                     autofocus: false,
                   ),
                   TextField(
                     decoration: const InputDecoration(
                       hintText: 'password',
                     ),
                     controller: _passwordController,
                     autofocus: false,
                   ),
                   const SizedBox(
                     height: 30,
                   ),
                   DropdownButton(
                       value: chosenUserType,
                       items: userTypeList.map((String userType) {
                         return DropdownMenuItem(
                             value: userType, child: Text(userType));
                       }).toList(),
                       onChanged: (chosen) {
                         chosenUserType = chosen as String;
                       })
                 ]),
                 actions: [
                   TextButton(
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                       child: const Text('cancel')),
                   TextButton(
                       onPressed: () async {
                         RegExp regex = RegExp(
                             r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                         if (regex.hasMatch(_passwordController.text)) {
                           var requestBody = {
                             "email": _emailController.text,
                             "password": _passwordController.text,
                             "name": _nameController.text,
                             "uid": _ueserIDController.text,
                             "type": chosenUserType
                           };
                           //print(jsonEncode(requestBody));
                           await ApiService().signupUser(requestBody);
                           // ignore: use_build_context_synchronously
                           Navigator.of(context).pop();
                           showSuccessDialog();
                           setState(() {
                             getAllUserInfo = ApiService().getAllUserInfo();
                           });
                         } else {
                           showDialog(
                               context: context,
                               builder: ((context) => CupertinoAlertDialog(
                                     title: const Text(
                                       'Password should contain upper case & lower case & digit & Special character & 8 characters in length',
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
                       child: const Text('SUBMIT'))
                 ],
               ),
             ),
           ));
 }


 void showAlertDialog(String sid) async {
   return showDialog(
       context: context,
       builder: ((context) => CupertinoAlertDialog(
             title: const Text("Sure?"),
             content: const Text("Delete User"),
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
                     await ApiService().deleteUserByID(sid);
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
 Widget build(BuildContext context) {
   return DefaultTabController(
       length: 4,
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
                 child: Text('Students'),
               ),
               Tab(
                 child: Text('Teachers'),
               ),
               Tab(
                 child: Text('Admin'),
               )
             ]),
           ),
         ),
         body: FutureBuilder<List<UserInfo>?>(
           future: getAllUserInfo,
           builder: (context, snapshot) {
             if (snapshot.hasData) {
               List<UserInfo>? studentList = snapshot.data
                   ?.where((element) => element.type == "student")
                   .toList();
               List<UserInfo>? teacherList = snapshot.data
                   ?.where((element) => element.type == "teacher")
                   .toList();
               List<UserInfo>? adminList = snapshot.data
                   ?.where((element) => element.type == "admin")
                   .toList();
               return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 400),
                 child: TabBarView(children: [
                   // show all user
                   UserListView(snapshot.data),
                   // only show students
                   UserListView(studentList),
                   // only show teachers
                   UserListView(teacherList),
                   // only show admin
                   UserListView(adminList)
                 ]),
               );
             } else {
               return const CircularProgressIndicator(
                 color: Colors.white,
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
               openSignUpUserDialog();
             },
           ),
         ),
       ));
 }


 // ignore: non_constant_identifier_names
 Widget UserListView(List<UserInfo>? userList) => ListView.builder(
       itemCount: userList?.length,
       itemBuilder: (context, index) {
         return Column(
           children: [
             Container(
               color: Colors.white.withOpacity(0.2),
               child: ListTile(
                 title: Text(
                     "${userList?[index].name} ・id: ${userList?[index].uid}"),
                 subtitle: Text("${userList?[index].email}"),
                 trailing: Wrap(
                   spacing: 20,
                   children: [
                     Container(
                       width: 100,
                       height: 40,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(40),
                           color: (userList?[index].type == "student")
                               ? Colors.grey.withOpacity(0.5)
                               : (userList?[index].type == "teacher")
                                   ? Colors.red.withOpacity(0.5)
                                   : Colors.black.withOpacity(0.5)),
                       child: Text(
                         "${userList?[index].type}",
                         style: const TextStyle(color: Colors.white),
                       ),
                     ),
                     IconButton(
                         onPressed: () async {
                           openEditDialog(
                               "${userList?[index].name}",
                               "${userList?[index].email}",
                               "${userList?[index].password}",
                               "${userList?[index].sId}");
                         },
                         icon: const Icon(
                           Icons.edit,
                           color: Colors.green,
                         )),
                     IconButton(
                         onPressed: () {
                           showAlertDialog("${userList?[index].sId}");
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
       },
     );
}
