import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:meditec/model/auth.dart';
import 'package:meditec/model/category.dart';
import 'package:meditec/model/doctorSlot.dart';
import 'package:meditec/model/index.dart';
import 'package:meditec/model/user.dart';
import 'package:meditec/model/appointment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  // String url = "182.48.90.214:8080";
  String url = "139.162.19.50:8080";
  // String url = "192.168.0.100:8080";
  User _user;
  String number;
  // String password;
  bool loginStatus = false;
  String authToken;
  // var image1;
  File selectedImage;
  List<Category> categories = [];
  Category selectedCategory;
  List<User> doctors = [];
  List<AdvertisementCategory> advertisementCategories = [];
  List<Advertisement> advertisements = [];
  List<User> emergencyDoctors = [];
  List<User> categoryDoctors = [];
  List<DoctorSlot> doctorSlots = [];
  List<Appointment> appointments = [];
  DoctorSlot selectedSlot = DoctorSlot();
  Auth _auth;
  Prescription prescriptionTemp;

  String token;
  SharedPreferences loginData;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<String> getToken() async {
    token = await _firebaseMessaging.getToken();
    return token;
  }

  User currentUser() {
    return _user;
  }

  Future<List<User>> globalSearch(String query) async {
    List<User> searchResult = [];
    var queryParameters = {
      'keyWords': '$query',
    };
    var uri = Uri.http('$url', '/searchDoctors', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> docs = jsonDecode(response.body);
      for (dynamic d in docs) {
        searchResult.add(User.fromJson(d));
      }
      for (User d in searchResult) {
        // print(d.name);
      }
      return searchResult;
    } else {
      return searchResult;
    }
  }

  Future getFullPrescription(int appointmentId) async {
    var queryParameters = {
      'appoinmentId': '$appointmentId',
    };
    var uri = Uri.http('$url', '/getFullPrescription', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: authToken,
    });
    // print(response.body);
    if (response.body != null && response.statusCode == 200) {
      try {
        Map prescriptionMap = jsonDecode(response.body);
        Prescription prescriptionFromServer =
            Prescription.fromJson(prescriptionMap);
        this.prescriptionTemp = prescriptionFromServer;
        notifyListeners();
        return true;
      } catch (e) {
        // print(e);
        return false;
      }
    }
  }

  Future<String> bookAppointment(Appointment appointment) async {
    appointment.user.userAvatar = null;
    var uri = Uri.http('$url', '/takeAppoinment');
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(appointment.toJson()),
    );
    // print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      selectedSlot = DoctorSlot();
      await getAppointments();
      return "success";
    } else if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "taken") {
      // print(response.body.toString());
      return "taken";
    } else if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "overloaded") {
      // print(response.body.toString());
      return "overloaded";
    } else {
      return "failed";
    }
  }

  Future confirmPayment(String appointmentID) async {
    var queryParameters = {
      'id': '$appointmentID',
    };
    var uri = Uri.http('$url', '/makePaymentDone', queryParameters);
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    // print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      await getAppointments();
      return true;
    } else {
      // print(response.body.toString());
      return false;
    }
  }

  Future<String> bookAppointmentPayLater(Appointment appointment) async {
    appointment.user.userAvatar = null;
    var uri = Uri.http('$url', '/takeAppoinmentPayLater');
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(appointment.toJson()),
    );
    print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      selectedSlot = DoctorSlot();
      await getAppointments();
      return "success";
    } else if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "taken") {
      // print(response.body.toString());
      return "taken";
    } else if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "overloaded") {
      // print(response.body.toString());
      return "overloaded";
    } else {
      return "failed";
    }
  }

  Future<String> deleteAppointment(Appointment appointment) async {
    appointment.doctorSlot = null;
    var uri = Uri.http('$url', '/deleteAppoinment');
    try {
      var response = await http.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: authToken,
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(appointment.toJson()),
      );
      // print(response.body);
      if (response.body != null &&
          response.statusCode == 200 &&
          response.body == "archived") {
        return "success";
      } else if (response.body != null &&
          response.statusCode == 200 &&
          response.body == "activated") {
        return "activated";
      } else {
        return "failed";
      }
    } catch (e) {
      // print(e);
      return "failed";
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
        HttpHeaders.authorizationHeader: authToken,
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

  Future getDoctorSlotsByDate(DateTime date, int chamberId) async {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    if (date.month < 10) {
      month = "0$month";
    }
    if (date.day < 10) {
      day = "0$day";
    }
    String formatDate = "$year-$month-$day";
    // print(formatDate);
    var queryParameters = {
      'date': '$formatDate',
      'chamberId': '$chamberId',
    };
    var uri = Uri.http('$url', '/slotsByDate', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    // print(response.body);

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

  // Future getPrescriptions() async {
  //   var queryParameters = {
  //     'id': '${_user.userId}',
  //   };
  //   var uri = Uri.http('$url', '/getPrescriptions', queryParameters);
  //   var response = await http.get(
  //     uri,
  //     headers: {
  //       HttpHeaders.authorizationHeader:
  //           "Basic " + base64.encode(utf8.encode(number + ":" + password)),
  //       HttpHeaders.contentTypeHeader: 'application/json',
  //     },
  //   );
  //
  //   if (response.body != null && response.statusCode == 200) {
  //     List<dynamic> press = jsonDecode(response.body);
  //     prescriptions = (press)
  //         ?.map((e) => e == null
  //             ? null
  //             : Prescription.fromJson(e as Map<String, dynamic>))
  //         ?.toList();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future uploadSample(File _image, int id) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://$url/uploadSample?appoinmentId=$id"));
    request.files.add(http.MultipartFile.fromBytes(
        'samples', File(_image.path).readAsBytesSync(),
        filename: _image.path.split("/").last));
    var res = await request.send();
    // print(res.statusCode);
    // print(res);
    if (res != null && res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<SamplePicture>> getPreviousSamples(int appointmentId) async {
    var queryParameters = {
      'appoinmentId': '$appointmentId',
    };
    var uri = Uri.http('$url', '/getSamples', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: authToken,
    });
    // print(response.body);

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> samples = jsonDecode(response.body);
      List<SamplePicture> h = (samples)
          ?.map((e) => e == null
              ? null
              : SamplePicture.fromJson(e as Map<String, dynamic>))
          ?.toList();
      return h;
    }
  }

  Future deletePreviousSample(SamplePicture samplePicture) async {
    samplePicture.appoinment = null;
    var uri = Uri.http('$url', '/deleteSample');
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(samplePicture.toJson()),
    );
    // print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      return true;
    } else {
      // print(response.body.toString());
      return false;
    }
  }

  Future uploadReports(File _image, int id) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://$url/uploadReports?appoinmentId=$id"));
    request.files.add(http.MultipartFile.fromBytes(
        'reports', File(_image.path).readAsBytesSync(),
        filename: _image.path.split("/").last));
    var res = await request.send();
    // print(res.statusCode);
    // print(res);
    if (res != null && res.statusCode == 200) {
      await _getUser();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<List<PrescriptionReport>> getPreviousReports(int appointmentId) async {
    var queryParameters = {
      'appoinmentId': '$appointmentId',
    };
    var uri = Uri.http('$url', '/getPreviousReports', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: authToken,
    });
    // print(response.body);

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> slots = jsonDecode(response.body);
      List<PrescriptionReport> h = (slots)
          ?.map((e) => e == null
              ? null
              : PrescriptionReport.fromJson(e as Map<String, dynamic>))
          ?.toList();
      return h;
    }
  }

  Future deletePreviousReport(PrescriptionReport report) async {
    report.appoinment = null;
    var uri = Uri.http('$url', '/deletePrescriptionReport');
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(report.toJson()),
    );
    // print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      return true;
    } else {
      // print(response.body.toString());
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
    // print(res.statusCode);
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
    tempUser.bloodGroup = (user.bloodGroup != _user.bloodGroup) &&
            (user.bloodGroup != null && user.bloodGroup != "")
        ? user.bloodGroup
        : tempUser.bloodGroup;
    tempUser.weight = (user.weight != _user.weight) && (user.weight != null)
        ? user.weight
        : tempUser.weight;
    tempUser.gender = (user.gender != _user.gender) &&
            (user.gender != null && user.gender != "")
        ? user.gender
        : tempUser.gender;
    tempUser.age =
        (user.age != _user.age) && (user.age != null) ? user.age : tempUser.age;
    tempUser.addressBooks =
        (user.addressBooks != null) ? user.addressBooks : tempUser.addressBooks;

    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('$url', '/updateUser', queryParameters);
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(tempUser.toJson()),
    );

    // print(response.body);
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

  Future changePassword({String previousPassword, String newPassword}) async {
    var queryParameters = {
      'previousPass': '$previousPassword',
      'newPass': '$newPassword',
      'mobileNumber': '$number',
    };
    var uri = Uri.http('$url', '/changePassword', queryParameters);
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    // print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      this.authToken = "Basic " +
          base64.encode(utf8.encode(_user.mobileNumber + ":" + newPassword));
      loginData = await SharedPreferences.getInstance();
      loginData.setString("authToken", authToken);
      return loginStatus;
    } else {
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

    // print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
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
      HttpHeaders.authorizationHeader: authToken,
    });
    // print(response.body);
    List<dynamic> updatedAppointments = jsonDecode(response.body);
    appointments = (updatedAppointments)
        ?.map((e) =>
            e == null ? null : Appointment.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  Future getCategories() async {
    var uri = Uri.http('$url', '/getCategories');
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: authToken,
    });
    List<dynamic> cats = jsonDecode(response.body);
    //print(cats);
    categories = (cats)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  Future getEmergencyDoctorList() async {
    var uri = Uri.http('$url', '/getEmmergencyDoctors');
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> docs = jsonDecode(response.body);
      emergencyDoctors.clear();
      for (dynamic d in docs) {
        emergencyDoctors.add(User.fromJson(d));
      }
      for (User d in emergencyDoctors) {
        // print(d.name);
      }
      return true;
    } else {
      return false;
    }
  }

  Future getAdvertisementCategories() async {
    var uri = Uri.http('$url', '/getAdvertisementCategories');
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> cats = jsonDecode(response.body);
      advertisementCategories = (cats)
          ?.map((e) => e == null
              ? null
              : AdvertisementCategory.fromJson(e as Map<String, dynamic>))
          ?.toList();
      return true;
    } else {
      return false;
    }
  }

  Future getAdvertisementsByCategory(int id) async {
    var queryParameters = {
      'id': '$id',
    };
    var uri = Uri.http('$url', '/getAdvertisementsByCategory', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> cats = jsonDecode(response.body);
      advertisements = (cats)
          ?.map((e) => e == null
              ? null
              : Advertisement.fromJson(e as Map<String, dynamic>))
          ?.toList();
      return true;
    } else {
      return false;
    }
  }

  Future getAdvertisements() async {
    var uri = Uri.http('$url', '/getAdvertisements');
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> cats = jsonDecode(response.body);
      advertisements = (cats)
          ?.map((e) => e == null
              ? null
              : Advertisement.fromJson(e as Map<String, dynamic>))
          ?.toList();
      return true;
    } else {
      return false;
    }
  }

  Future getDoctorList() async {
    var uri = Uri.http('$url', '/getAppDoctors');
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
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
        // print(d.name);
      }
      return true;
    } else {
      return false;
    }
  }

  Future getCategoryDoctorList(int id) async {
    var queryParameters = {
      'id': '$id',
    };
    var uri = Uri.http('$url', '/getDoctorList', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.body != null && response.statusCode == 200) {
      List<dynamic> docs = jsonDecode(response.body);
      categoryDoctors.clear();
      for (dynamic d in docs) {
        categoryDoctors.add(User.fromJson(d));
      }
      for (User d in categoryDoctors) {
        // print(d.name);
        // print(d.degree.degreeName);
        // print(d.categories[0].name);
      }
      return categoryDoctors.isNotEmpty;
    } else {
      return categoryDoctors.isNotEmpty;
    }
  }

  Future _getUser() async {
    var queryParameters = {
      'number': '$number',
    };
    var uri = Uri.http('$url', '/getUser', queryParameters);
    var response = await http.get(uri, headers: {
      // HttpHeaders.authorizationHeader:
      //     "Basic " + base64.encode(utf8.encode(number + ":" + password)),
      HttpHeaders.authorizationHeader: authToken,
    });

    // print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      _user = User.fromJson(userMap);
      // print(_user.name);
      // image1 = _user.userAvatar.image;
      // var image = base64.decode(image1.toString());
      // await getCategories();
      // await getAppointments();
      // await getDoctorList();
      // await getEmergencyDoctorList();
      // await getAdvertisementCategories();
      // await getAdvertisements();
    }
    notifyListeners();
  }

  Future loginRenew() async {
    bool timedOut = false;
    String deviceToken = await getToken();
    var queryParameters = {
      'number': '$number',
      'token': '$deviceToken',
    };
    var uri = Uri.http('$url', '/loginRenewal', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: authToken,
      HttpHeaders.contentTypeHeader: 'application/json',
    }).timeout(Duration(seconds: 60), onTimeout: () {
      // time has run out, do what you wanted to do
      timedOut = true;
      return null;
    });
    print(response.body);
    if (response.body != null &&
        response.statusCode == 200 &&
        response.body == "success") {
      this.number = number;
      await _getUser().timeout(Duration(seconds: 60), onTimeout: () {
        // time has run out, do what you wanted to do
        timedOut = true;
        return null;
      });
      if (timedOut) {
        await logout();
        this.loginStatus = false;
      } else {
        this.loginStatus = true;
      }
      notifyListeners();
    }
    return loginStatus;
  }

  Future login(String number, String password) async {
    bool timedOut = false;
    // print("$number $password");
    String deviceToken = await getToken();
    var queryParameters = {
      'number': '$number',
      'token': '$deviceToken',
    };
    var uri = Uri.http('$url', '/login', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    // print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Map loginMap = jsonDecode(response.body);
      _auth = Auth.fromJson(loginMap);
      if (_auth.authorities[0].authority == "patient") {
        this.number = number;
        // this.password = password;
        this.authToken = "Basic " +
            base64.encode(utf8.encode(
                _auth.principal.username + ":" + _auth.principal.password));
        await _getUser().timeout(Duration(seconds: 60), onTimeout: () {
          // time has run out, do what you wanted to do
          timedOut = true;
          return null;
        });
        if (timedOut) {
          await logout();
          this.loginStatus = false;
        } else {
          this.loginStatus = true;
          loginData = await SharedPreferences.getInstance();
          loginData.setBool("login", false);
          loginData.setString("number", number);
          loginData.setString("authToken", authToken);
        }
        notifyListeners();
      } else {
        // print("Not Patient");
      }
    }
    return loginStatus;
  }

  Future logout() async {
    String deviceToken = await getToken();
    var queryParameters = {
      'token': '$deviceToken',
    };
    var uri = Uri.http('$url', '/logoutUser', queryParameters);
    var response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: authToken,
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    // print(response.body);
    if (response.body != null && response.statusCode == 200) {
      this.loginStatus = false;
      this._user = null;
      this.number = null;
      // this.password = null;
      this.authToken = null;
      // this.image1 = null;
      this.selectedImage = null;
      notifyListeners();
      loginData = await SharedPreferences.getInstance();
      loginData.clear();
      // loginData.setBool("login", false);
      // loginData.setString("number", number);
      // loginData.setString("authToken", authToken);
    }
    return false;
  }
}

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());
