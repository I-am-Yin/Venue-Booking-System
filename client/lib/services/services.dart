import 'dart:convert';
import 'package:client/services/Models/models.dart';
import 'package:http/http.dart' as http;


Map<String, String> requestHeaders = {
 'Content-type': 'application/json',
 'Accept': 'application/json'
};


class ApiConstants {
 static String baseUrl = 'http://localhost:4000/api';
 static String roomEndpoint = '/rooms/';
 static String userEndpoint = '/user';
 static String signupEndpoint = '/signup';
 static String loginEndpoint = '/login';
}


class ApiService {
 var client = http.Client();
 // ignore: body_might_complete_normally_nullable
 Future<List<RoomInfo>?> getRoomsInfo() async {
   try {
     var client = http.Client();
     var uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.roomEndpoint);
     final response = await client.get(uri, headers: requestHeaders);
     if (response.statusCode == 200) {
       List jsonResponse = json.decode(response.body);
       return jsonResponse.map((e) => RoomInfo.fromJson(e)).toList();
     }
   } catch (e) {
     //print(e.toString());
   }
 }


 // ignore: body_might_complete_normally_nullable
 Future<UserInfo?> getUserInfo(String sid) async {
   try {
     var uri =
         Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$sid');
     final response = await client.get(uri, headers: requestHeaders);
     if (response.statusCode == 200) {
       var jsonResponse = jsonDecode(response.body);
       return UserInfo.fromJson(jsonResponse);
     }
   } catch (e) {
     //print(e);
   }
 }


 // ignore: body_might_complete_normally_nullable
 Future<List<UserInfo>?> getAllUserInfo() async {
   try {
     var uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint);
     final response = await client.get(uri, headers: requestHeaders);
     if (response.statusCode == 200) {
       List jsonResponse = jsonDecode(response.body);
       return jsonResponse.map((e) => UserInfo.fromJson(e)).toList();
     }
   } catch (e) {
     //print(e);
   }
 }


 Future updateUserInfo(String sid, var requestBody) async {
   try {
     var uri =
         Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$sid');
     //var requestBody = {"currentBooking": {}};
     final response = await client.patch(uri,
         headers: requestHeaders, body: jsonEncode(requestBody));
     if (response.statusCode == 200) {
       //print('done');
     }
   } catch (e) {
     //print(e);
   }
 }


 Future deleteUserByID(String sid) async {
   try {
     var uri =
         Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$sid');
     final response = await client.delete(uri, headers: requestHeaders);
     if (response.statusCode == 200) {
       //print('delete User');
     }
   } catch (e) {
     //print(e);
   }
 }


 Future deleteRoomByID(String sid) async {
   try {
     var uri =
         Uri.parse('${ApiConstants.baseUrl}${ApiConstants.roomEndpoint}$sid');
     final response = await client.delete(uri, headers: requestHeaders);
     if (response.statusCode == 200) {
       //print('delete room');
     }
   } catch (e) {
     //print(e);
   }
 }


 Future signupUser(var requestBody) async {
   try {
     var uri = Uri.parse(ApiConstants.baseUrl +
         ApiConstants.userEndpoint +
         ApiConstants.signupEndpoint);
     final response = await client.post(uri,
         headers: requestHeaders, body: jsonEncode(requestBody));
     if (response.statusCode == 200) {
       //print("created user");
     }
   } catch (e) {
     //print(e);
   }
 }


 Future createNewRoom(var requestBody) async {
   try {
     var uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.roomEndpoint);
     final response = await client.post(uri,
         headers: requestHeaders, body: jsonEncode(requestBody));
     if (response.statusCode == 200) {
       //print("created user");
     }
   } catch (e) {
     //print(e);
   }
 }


 Future changeRoomIsAvailable(String sid, var requestBody) async {
   try {
     var uri =
         Uri.parse(ApiConstants.baseUrl + ApiConstants.roomEndpoint + sid);
     final response = await client.patch(uri,
         headers: requestHeaders, body: jsonEncode(requestBody));
     if (response.statusCode == 200) {
       //print("updated room");
     }
   } catch (e) {
     //print(e);
   }
 }


 Future changeBookingIsAvailable(String sid, var requestBody) async {
   try {
     var uri =
         Uri.parse("${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$sid");
     final response = await client.patch(uri,
         headers: requestHeaders, body: jsonEncode(requestBody));
     if (response.statusCode == 200) {
       //print("updated booking");
     }
   } catch (e) {
     //print(e);
   }
 }
}


