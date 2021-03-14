import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditec/view/screen/appointents_screen.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';
import 'package:meditec/view/screen/profile_screen.dart';

class MyCustomNavBar extends StatefulWidget {
  @override
  _MyCustomNavBarState createState() => _MyCustomNavBarState();
}

class _MyCustomNavBarState extends State<MyCustomNavBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: BottomAppBar(
        child: Container(
          color: Color(0xFF00BABA),
          height: height * 0.1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.01),
            //padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NavbarButton(
                  text: 'Home',
                  route: Dashboard.id,
                ),
                NavbarButton(
                  text: 'Appointments',
                  route: AppointmentsScreen.id,
                ),
                NavbarButton(
                  text: "",
                  route: "",
                ),
                NavbarButton(
                  text: 'Blog',
                  route: Dashboard.id,
                ),
                NavbarButton(
                  text: 'Profile',
                  route: ProfileScreen.id,
                ),
              ],
            ),
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print(height);
    // print(width);
    return MaterialButton(
      minWidth: 40,
      padding: EdgeInsets.zero,
      onPressed: route != ""
          ? () {
              Navigator.pushNamed(context, route);
              // setState(() {
              //   // currentScreen =
              //   //     Dashboard(); // if user taps on this dashboard tab will be active
              //   // currentTab = 0;
              // });
            }
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          text != ""
              ? SvgPicture.asset('assets/icons/navbar/$text.svg')
              : Container(),
          SizedBox(
            width: width * 0.15,
            height: height * 0.05,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: height * 0.022,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
