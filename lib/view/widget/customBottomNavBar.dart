import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/edit_profile_screen.dart';

class MyCustomNavBar extends StatefulWidget {
  @override
  _MyCustomNavBarState createState() => _MyCustomNavBarState();
}

class _MyCustomNavBarState extends State<MyCustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        child: Container(
          color: Color(0xFF00BABA),
          height: 60,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      NavbarButton(
                        text: 'Home',
                        route: Dashboard.id,
                      ),
                      NavbarButton(
                        text: 'My app',
                        route: Dashboard.id,
                      ),
                    ],
                  ),

                  // Right Tab bar icons

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      NavbarButton(
                        text: 'Blog',
                        route: Dashboard.id,
                      ),
                      NavbarButton(
                        text: 'Profile',
                        route: EditProfileScreen.id,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavbarButton extends StatelessWidget {
  final String text;
  final String route;

  const NavbarButton({this.text, this.route});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        Navigator.popAndPushNamed(context, route);
        // setState(() {
        //   // currentScreen =
        //   //     Dashboard(); // if user taps on this dashboard tab will be active
        //   // currentTab = 0;
        // });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset('assets/icons/navbar/$text.svg'),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
