import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditec/view/screen/upload_profile_image_screen.dart';
import 'package:meditec/view/screen/uploadpage.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return SizedBox(
      height: space * 0.25,
      width: space * 0.25,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: AssetImage('assets/images/profiles/user.png'),
              fit: BoxFit.fill,
              height: space * 0.25,
              width: space * 0.25,
            ),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: SizedBox(
              height: space * 0.1,
              width: space * 0.1,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  Navigator.pushNamed(context, UploadProfileImageScreen.id);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => MyImagePicker()));
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
