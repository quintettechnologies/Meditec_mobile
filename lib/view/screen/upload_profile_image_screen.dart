import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/widget/customAppBar.dart';
import 'package:meditec/view/widget/customBottomNavBar.dart';
import 'package:meditec/view/widget/customDrawer.dart';
import 'package:meditec/view/widget/customFAB.dart';
import 'dart:io';
import 'package:meditec/model/user.dart';

class UploadProfileImageScreen extends StatefulWidget {
  static const String id = 'upload_profile_image';
  @override
  _UploadProfileImageScreenState createState() =>
      _UploadProfileImageScreenState();
}

class _UploadProfileImageScreenState extends State<UploadProfileImageScreen> {
  File _image;
  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(),
      drawer: MyCustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: _image != null
                        ? FileImage(_image)
                        : AssetImage('assets/images/profiles/user.png'),
                    fit: BoxFit.fill,
                    height: space * 0.5,
                    width: space * 0.5,
                  ),
                ),
                SizedBox(
                  height: space * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: Container(
                        width: space * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Color(0xFF00BABA),
                            ),
                            SizedBox(
                              width: space * 0.02,
                            ),
                            Text('Camera')
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: _getImage,
                      child: Container(
                        width: space * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.image,
                              color: Color(0xFF00BABA),
                            ),
                            SizedBox(
                              width: space * 0.02,
                            ),
                            Text('Gallery')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: space * 0.1,
                ),
                RaisedButton(
                  onPressed: () {
                    context.read(userProvider).uploadImage(_image);
                    Navigator.popAndPushNamed(context, Dashboard.id);
                  },
                  child: Container(
                    width: space * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.save,
                          color: Color(0xFF00BABA),
                        ),
                        SizedBox(
                          width: space * 0.02,
                        ),
                        Text('Save')
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
      floatingActionButton: MyCustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}

// class UploadProfileImageScreen extends HookWidget {
//   static const String id = 'upload_profile_image';
//   File _image;
//   Future _getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     _image = image;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double space = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: MyCustomAppBar(),
//       drawer: MyCustomDrawer(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Consumer(
//                   builder: (context, watch, child) {
//                     // User user = context.read(userProvider).currentUser();
//                     // return ClipRRect(
//                     //   borderRadius: BorderRadius.circular(10.0),
//                     //   child: Image(
//                     //     image: _image != null
//                     //         ? FileImage(_image)
//                     //         : Image.memory(
//                     //                 base64.decode(user.userAvatar['image']))
//                     //             .image,
//                     //     fit: BoxFit.fill,
//                     //     height: space * 0.5,
//                     //     width: space * 0.5,
//                     //   ),
//                     // );
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(10.0),
//                       child: Image(
//                         image: _image != null
//                             ? FileImage(_image)
//                             : AssetImage('assets/images/profiles/user.png'),
//                         fit: BoxFit.fill,
//                         height: space * 0.5,
//                         width: space * 0.5,
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: space * 0.1,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     RaisedButton(
//                       onPressed: () {},
//                       child: Container(
//                         width: space * 0.2,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Icon(
//                               Icons.camera_alt,
//                               color: Color(0xFF00BABA),
//                             ),
//                             SizedBox(
//                               width: space * 0.02,
//                             ),
//                             Text('Camera')
//                           ],
//                         ),
//                       ),
//                     ),
//                     RaisedButton(
//                       onPressed: _getImage,
//                       child: Container(
//                         width: space * 0.2,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Icon(
//                               Icons.image,
//                               color: Color(0xFF00BABA),
//                             ),
//                             SizedBox(
//                               width: space * 0.02,
//                             ),
//                             Text('Gallery')
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: space * 0.1,
//                 ),
//                 Consumer(builder: (context, watch, child) {
//                   return RaisedButton(
//                     onPressed: () {
//                       context.read(userProvider).uploadImage(_image);
//                       Navigator.popAndPushNamed(context, Dashboard.id);
//                     },
//                     child: Container(
//                       width: space * 0.2,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Icon(
//                             Icons.save,
//                             color: Color(0xFF00BABA),
//                           ),
//                           SizedBox(
//                             width: space * 0.02,
//                           ),
//                           Text('Save')
//                         ],
//                       ),
//                     ),
//                   );
//                 })
//               ],
//             )),
//       ),
//       floatingActionButton: MyCustomFAB(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: MyCustomNavBar(),
//     );
//   }
// }
