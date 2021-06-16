import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditec/view/screen/24x7doctor_screen.dart';
import 'package:meditec/view/screen/appointents_list_screen.dart';
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
          height: height * 0.08,
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
                  text: 'Appointment',
                  route: AppointmentsScreen.id,
                ),
                GestureDetector(
                    child: Container(
                      width: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        child: SvgPicture.string(
                          '''<svg id="Layer_1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 419 419"><image width="419" height="419" xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAaMAAAGjCAYAAACBlXr0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAF8WlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNi4wLWMwMDIgNzkuMTY0NDYwLCAyMDIwLzA1LzEyLTE2OjA0OjE3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgMjEuMiAoV2luZG93cykiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTA0LTIzVDIyOjQ5OjEzKzA2OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wNC0yNFQwMDo0NjoxNiswNjowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wNC0yNFQwMDo0NjoxNiswNjowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDplYTczMTJkMC0zNTNkLWUwNDctODZjMy1hMmRkMzAzM2JkZWMiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDo4M2Q2NDQwMC1hNTI5LWIxNGItOGRhOC1lMjY1NTI0M2ZjZmYiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDpiMTVjNDYxMS00MWIzLTY2NDMtOWVmNS0yMTUwMTMzMGNjOTEiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOmIxNWM0NjExLTQxYjMtNjY0My05ZWY1LTIxNTAxMzMwY2M5MSIgc3RFdnQ6d2hlbj0iMjAyMS0wNC0yM1QyMjo0OToxMyswNjowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIDIxLjIgKFdpbmRvd3MpIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDplYTczMTJkMC0zNTNkLWUwNDctODZjMy1hMmRkMzAzM2JkZWMiIHN0RXZ0OndoZW49IjIwMjEtMDQtMjRUMDA6NDY6MTYrMDY6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4yIChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7BNY5BAAAjHElEQVR4nO3d7XUbydW14T3v8n92BoIjYDsCtSMQHYF6IhAmgoEiMBSBmhE8UASGIjAYgcEMmhHo/VHEkKL4BaK79qnu+1pLS+NZMs6ZGRAb9dFVv/348UMATrKQ1Eiqb3/dt7v9tZHUZ+oHKM5vhBHwZq2kpaTzV/75S0krSftRugEKRhgBx7uQtJb07o3//89KoQTgFmEEvF4lqZP0YYDX+q4Uav0ArwUUjzACXqeWtJV0NuBrXimtNfUDviZQpP/nbgAoQCvpvxo2iKS01rQe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"/></svg>
''',
                          alignment: Alignment.center,
                          height: height * 0.1,
                          color: Color(0xFF00BABA),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, Dashboard.id);
                    }),
                // NavbarButton(
                //   text: "",
                //   route: "",
                // ),
                NavbarButton(
                  text: 'Emergency',
                  route: EmergencyDoctorScreen.id,
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
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.024,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
