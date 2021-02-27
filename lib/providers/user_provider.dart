import 'dart:convert';
import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:meditec/model/auth.dart';
import 'package:meditec/model/category.dart';
import 'package:meditec/model/chamber.dart';
import 'package:meditec/model/doctorSlot.dart';
import 'package:meditec/model/index.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/model/appointment.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String url = "182.48.90.214:8080";
  // String url = "192.168.0.100:8080";
  User _user;
  String number;
  String password;
  bool loginStatus = false;
  String authToken;
  var image1;
  File selectedImage;
  List<Category> categories;
  List<User> doctors = [];
  List<DoctorSlot> doctorSlots = [];
  List<Appointment> appointments = [];
  List<Prescription> prescriptions = [];
  DoctorSlot selectedSlot = DoctorSlot();
  Auth _auth;

  User currentUser() {
    return _user;
  }

  Future bookAppointment(DoctorSlot doctorSlot) async {
    Appointment appointment = new Appointment();
    print(doctorSlot);
    _user.userAvatar = null;
    appointment.user = _user;
    appointment.time = doctorSlot.startTime.toIso8601String();
    appointment.doctorSlot = doctorSlot;
    var uri = Uri.http('$url', '/takeAppoinment');
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader:
            "Basic " + base64.encode(utf8.encode(number + ":" + password)),
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(appointment.toJson()),
    );
    print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      selectedSlot = DoctorSlot();
      await _getUser();
      return true;
    } else {
      print(response.body.toString());
      await _getUser();
      return false;
    }
  }

  void selectSlot(DoctorSlot doctorSlot) {
    selectedSlot = doctorSlot;
  }

  Future getDoctorSlots(String id) async {
    var queryParameters = {
      'id': '$id',
    };
    var uri = Uri.http('$url', '/getSlots', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader:
            "Basic " + base64.encode(utf8.encode(number + ":" + password)),
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> slots = jsonDecode(response.body);
      doctorSlots = (slots)
          ?.map((e) =>
              e == null ? null : DoctorSlot.fromJson(e as Map<String, dynamic>))
          ?.toList();
      return true;
    } else {
      return false;
    }
  }

  Future getPrescriptions() async {
    var queryParameters = {
      'id': '${_user.userId}',
    };
    var uri = Uri.http('$url', '/getPrescriptions', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader:
            "Basic " + base64.encode(utf8.encode(number + ":" + password)),
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> press = jsonDecode(response.body);
      prescriptions = (press)
          ?.map((e) => e == null
              ? null
              : Prescription.fromJson(e as Map<String, dynamic>))
          ?.toList();
      return true;
    } else {
      return false;
    }
  }

  Future uploadImage(File _image) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://$url/updateAvatar?userId=${_user.userId}"));
    request.files.add(http.MultipartFile.fromBytes(
        'profileImage', File(_image.path).readAsBytesSync(),
        filename: _image.path.split("/").last));
    var res = await request.send();
    print(res.statusCode);
    if (res != null && res.statusCode == 200) {
      await _getUser();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future editUser(User user) async {
    _user.userAvatar = null;
    User tempUser = _user;
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

    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('$url', '/updateUser', queryParameters);
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
      await _getUser();
      return loginStatus;
    } else {
      await _getUser();
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
      "http://$url/signup",
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

  Future getAppointments() async {
    var queryParameters = {
      'mobileNumber': '$number',
    };
    var uri = Uri.http('$url', '/myAppoinments', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
    });
    List<dynamic> updatedAppointments = jsonDecode(response.body);
    //print(cats);
    appointments = (updatedAppointments)
        ?.map((e) =>
            e == null ? null : Appointment.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  Future getCategories() async {
    var uri = Uri.http('$url', '/getCategories');
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
    });
    List<dynamic> cats = jsonDecode(response.body);
    //print(cats);
    categories = (cats)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  Future getDoctorList(int id) async {
    var queryParameters = {
      'id': '$id',
    };
    var uri = Uri.http('$url', '/getDoctorList', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader:
            "Basic " + base64.encode(utf8.encode(number + ":" + password)),
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> docs = jsonDecode(response.body);
      doctors.clear();
      for (dynamic d in docs) {
        doctors.add(User.fromJson(d));
      }
      for (User d in doctors) {
        print(d.name);
        print(d.degree.degreeName);
        print(d.categories[0].name);
      }
      return true;
    } else {
      return false;
    }
  }

  Future _getUser() async {
    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('$url', '/getUser', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
    });

    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      _user = User.fromJson(userMap);
      print(_user.name);
      // image1 = _user.userAvatar.image;
      var image = base64.decode(image1.toString());
      await getCategories();
      await getAppointments();
      await getPrescriptions();
    }
    notifyListeners();
  }

  Future login(String number, String password) async {
    print("$number $password");
    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('$url', '/login', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Map loginMap = jsonDecode(response.body);
      _auth = Auth.fromJson(loginMap);
      if (_auth.authorities[0].authority == "patient") {
        this.number = number;
        this.password = password;
        this.authToken = "Basic " +
            base64.encode(utf8.encode(
                _auth.principal.username + ":" + _auth.principal.password));
        await _getUser();
        this.loginStatus = true;
        notifyListeners();
      } else {
        print("Not Patient");
      }
    }
    return loginStatus;
  }

  Future logout() async {
    print("$number $password");
    var uri = Uri.http('$url', '/logoutUser');
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
