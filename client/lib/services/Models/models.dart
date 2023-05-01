

// 1. set roomInfo available time range
// 2. check roomForm.startTime > roomInfo.startTime =True  && roomForm.endTime < roomInfo.endTime
import 'package:flutter/material.dart';


class RoomInfo extends ChangeNotifier {
 String? rid;
 String? cat;
 String? reason;
 String? dates;
 String? startTime;
 String? endTime;
 bool? available;
 String? sId;
 String? createdAt;
 String? updatedAt;
 int? iV;


 RoomInfo(
     {this.rid,
     this.cat,
     this.reason,
     this.dates,
     this.startTime,
     this.endTime,
     this.available,
     this.sId,
     this.createdAt,
     this.updatedAt,
     this.iV});


 RoomInfo.fromJson(Map<String, dynamic> json) {
   rid = json['rid'];
   cat = json['cat'];
   reason = json['reason'];
   dates = json['dates'];
   startTime = json['startTime'];
   endTime = json['endTime'];
   available = json['available'];
   sId = json['_id'];
   createdAt = json['createdAt'];
   updatedAt = json['updatedAt'];
   iV = json['__v'];
 }


 Map<String, dynamic> toJson() {
   // ignore: prefer_collection_literals
   final Map<String, dynamic> data = Map<String, dynamic>();
   data['rid'] = rid;
   data['cat'] = cat;
   data['reason'] = reason;
   data['dates'] = dates;
   data['startTime'] = startTime;
   data['endTime'] = endTime;
   data['available'] = available;
   data['_id'] = sId;
   data['createdAt'] = createdAt;
   data['updatedAt'] = updatedAt;
   data['__v'] = iV;
   return data;
 }
}


class UserInfo {
 CurrentBooking? currentBooking;
 String? sId;
 String? uid;
 String? email;
 String? password;
 String? name;
 String? type;
 List<Record>? record;
 String? createdAt;
 String? updatedAt;
 int? iV;


 UserInfo(
     {this.currentBooking,
     this.sId,
     this.uid,
     this.email,
     this.password,
     this.name,
     this.type,
     this.record,
     this.createdAt,
     this.updatedAt,
     this.iV});


 UserInfo.fromJson(Map<String, dynamic> json) {
   currentBooking = json['currentBooking'] != null
       ? CurrentBooking.fromJson(json['currentBooking'])
       : null;
   sId = json['_id'];
   uid = json['uid'];
   email = json['email'];
   password = json['password'];
   name = json['name'];
   type = json['type'];
   if (json['record'] != null) {
     record = <Record>[];
     json['record'].forEach((v) {
       record!.add(Record.fromJson(v));
     });
   }
   createdAt = json['createdAt'];
   updatedAt = json['updatedAt'];
   iV = json['__v'];
 }


 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = <String, dynamic>{};
   if (currentBooking != null) {
     data['currentBooking'] = currentBooking!.toJson();
   }
   data['_id'] = sId;
   data['uid'] = uid;
   data['email'] = email;
   data['password'] = password;
   data['name'] = name;
   data['type'] = type;
   if (record != null) {
     data['record'] = record!.map((v) => v.toJson()).toList();
   }
   data['createdAt'] = createdAt;
   data['updatedAt'] = updatedAt;
   data['__v'] = iV;
   return data;
 }
}


class CurrentBooking {
 String? rid;
 String? cat;
 String? reason;
 String? dates;
 String? startTime;
 String? endTime;
 bool? available;


 CurrentBooking(
     {this.rid,
     this.cat,
     this.reason,
     this.dates,
     this.startTime,
     this.endTime,
     this.available});


 CurrentBooking.fromJson(Map<String, dynamic> json) {
   rid = json['rid'];
   cat = json['cat'];
   reason = json['reason'];
   dates = json['dates'];
   startTime = json['startTime'];
   endTime = json['endTime'];
   available = json['available'];
 }


 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = <String, dynamic>{};
   data['rid'] = rid;
   data['cat'] = cat;
   data['reason'] = reason;
   data['dates'] = dates;
   data['startTime'] = startTime;
   data['endTime'] = endTime;
   data['available'] = available;
   return data;
 }
}


class Record {
 String? rid;
 String? cat;
 String? reason;
 String? dates;
 String? startTime;
 String? endTime;


 Record(
     {this.rid,
     this.cat,
     this.reason,
     this.dates,
     this.startTime,
     this.endTime});


 Record.fromJson(Map<String, dynamic> json) {
   rid = json['rid'];
   cat = json['cat'];
   reason = json['reason'];
   dates = json['dates'];
   startTime = json['startTime'];
   endTime = json['endTime'];
 }


 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = <String, dynamic>{};
   data['rid'] = rid;
   data['cat'] = cat;
   data['reason'] = reason;
   data['dates'] = dates;
   data['startTime'] = startTime;
   data['endTime'] = endTime;
   return data;
 }
}
