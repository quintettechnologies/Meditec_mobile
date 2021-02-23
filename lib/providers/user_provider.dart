import 'dart:convert';
import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:meditec/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:meditec/model/addressBooks.dart';

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
    if (res != null && res.statusCode == 200) {
      _getUser();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future editUser(User user) async {
    _user.userAvatar = null;
    User tempUser = _user;
    print(tempUser.toJson());
    tempUser.name =
        (user.name != _user.name) && (user.name != null && user.name != "")
            ? user.name
            : tempUser.name;
    tempUser.email =
        (user.email != _user.email) && (user.email != null && user.email != "")
            ? user.email
            : tempUser.email;
    tempUser.mobileNumber = (user.mobileNumber != _user.mobileNumber) &&
            (user.mobileNumber != null && user.mobileNumber != "")
        ? user.mobileNumber
        : tempUser.mobileNumber;
    tempUser.addressBooks =
        (user.addressBooks != null) ? user.addressBooks : tempUser.addressBooks;
    // tempUser.addressBooks.street1 =
    //     (user.addressBooks.street1 != _user.addressBooks.street1)
    //         ? user.addressBooks.street1
    //         : tempUser.addressBooks.street1;
    // tempUser.addressBooks.street2 =
    //     (user.addressBooks.street2 != _user.addressBooks.street2)
    //         ? user.addressBooks.street2
    //         : tempUser.addressBooks.street2;
    // tempUser.addressBooks.street3 =
    //     (user.addressBooks.street3 != _user.addressBooks.street3)
    //         ? user.addressBooks.street3
    //         : tempUser.addressBooks.street3;
    // tempUser.addressBooks.city =
    //     (user.addressBooks.city != _user.addressBooks.city)
    //         ? user.addressBooks.city
    //         : tempUser.addressBooks.city;
    // tempUser.addressBooks.country =
    //     (user.addressBooks.country != _user.addressBooks.country)
    //         ? user.addressBooks.country
    //         : tempUser.addressBooks.country;
    // tempUser.addressBooks.zip =
    //     (user.addressBooks.zip != _user.addressBooks.zip)
    //         ? user.addressBooks.zip
    //         : tempUser.addressBooks.zip;
    // print(
    //     "****************************#######################################****************************");
    // print(tempUser.toJson());
    // print(
    //     "****************************#######################################****************************");
    // print(tempUser.addressBooks.toJson());
    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('192.168.0.100:8080', '/updateUser', queryParameters);
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader:
            "Basic " + base64.encode(utf8.encode(number + ":" + password)),
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(tempUser.toJson()),
    );

    print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      _getUser();
      return loginStatus;
    } else {
      _getUser();
      return false;
    }
  }

  Future signUp(User user) async {
    var queryParameters = {
      "name": user.name,
      "email": user.email,
      "mobileNumber": user.mobileNumber,
      "password": user.password
    };
    var response = await http.post(
      "http://192.168.0.100:8080/signup",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(queryParameters),
    );

    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      bool status = await login(user.mobileNumber, user.password);
      return status;
    } else {
      return false;
    }
  }

  Future _getUser() async {
    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('192.168.0.100:8080', '/getUser', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
    });

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
      _getUser();
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
