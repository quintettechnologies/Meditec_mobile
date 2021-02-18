import 'dart:convert';
import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:meditec/model/user.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  User _user;
  String number;
  String password;
  bool loginStatus = false;
  String authToken;
  var image1;
  File selectedImage;

  User currentUser() {
    return _user;
  }

  Future uploadImage(File _image) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://192.168.0.100:8080/updateAvatar?userId=${_user.userId}"));
    request.files.add(http.MultipartFile.fromBytes(
        'profileImage', File(_image.path).readAsBytesSync(),
        filename: _image.path.split("/").last));
    var res = await request.send();
    print(res.statusCode);
    getUser();
    notifyListeners();
  }

  Future editUser(User user) async {
    _user.name =
        user.name == null || user.name == _user.name ? _user.name : user.name;
    _user.email = user.email == null || user.email == _user.email
        ? _user.email
        : user.email;
    _user.mobileNumber =
        user.mobileNumber == null || user.mobileNumber == _user.mobileNumber
            ? _user.mobileNumber
            : user.mobileNumber;
    Map<String, dynamic> userMap = {
      'name': '${_user.name}',
      'email': '${_user.email}',
      'mobileNumber': '${_user.mobileNumber}',
    };
    print(userMap);
    var body = jsonEncode(userMap);
    //var uri = Uri.http('192.168.0.100:8080', '/updateUser');
    var response = await http.post("http://192.168.0.100:8080/updateUser",
        body: body, headers: {"content-type": "application/json"});

    print(response.body);
  }

  Future getUser() async {
    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('192.168.0.100:8080', '/getUser', queryParameters);
    var response = await http.get(uri);

    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      _user = User.fromJson(userMap);
      print(_user.name);
      image1 = _user.userAvatar.image;
      var image = base64.decode(image1.toString());
    }
    notifyListeners();
  }

  Future login(String number, String password) async {
    print("$number $password");
    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('192.168.0.100:8080', '/login', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      //Navigator.pushNamed(context, Dashboard.id);
      this.number = number;
      this.password = password;
      this.authToken =
          "Basic " + base64.encode(utf8.encode(number + ":" + password));
      getUser();
      this.loginStatus = true;
      notifyListeners();
    }
    return loginStatus;
  }

  Future logout() async {
    print("$number $password");
    var uri = Uri.http('192.168.0.100:8080', '/logoutUser');
    var response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      this.loginStatus = false;
      this._user = null;
      this.number = null;
      this.password = null;
      this.authToken = null;
      this.image1 = null;
      this.selectedImage = null;
      notifyListeners();
    }
    return false;
  }
}

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());
