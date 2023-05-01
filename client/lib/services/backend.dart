import 'package:client/services/Models/models.dart';
import 'package:flutter/material.dart';


class Backend extends ChangeNotifier {
 int? routes;
 List<UserInfo>? studentList = [];
 List<UserInfo>? teacherList = [];
 List<UserInfo>? adminList = [];


 Backend({
   this.routes = 0,
 });


 void setRoutes(int newValue) {
   routes = newValue;
   notifyListeners();
 }


 void setStudentList(var newValue) {
   studentList = newValue;
   notifyListeners();
 }


 void setTeacherList(List<UserInfo>? newValue) {
   teacherList = newValue;
   notifyListeners();
 }


 void setAdminList(List<UserInfo>? newValue) {
   adminList = newValue;
   notifyListeners();
 }
}
