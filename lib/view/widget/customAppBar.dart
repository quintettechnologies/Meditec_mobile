import 'package:flutter/material.dart';
import 'package:meditec/view/constants.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.zero,
        color: Color(0xFFF7F7F7),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFEDF0F0),
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF00CACA),
                        ),
                      )),
                  Text(
                    "Make an appointment",
                    style: TextStyle(color: Color(0xFF00CACA)),
                    textAlign: TextAlign.center,
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFEDF0F0),
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.notifications,
                          color: Color(0xFF00CACA),
                        ),
                      )),
                ],
              ),
            ),
            // Container(
            //   height: MediaQuery.of(context).size.width * 0.2,
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            //     child: TextField(
            //       style: TextStyle(fontSize: 16, color: Color(0xFF777A95)),
            //       decoration: InputDecoration(
            //         prefixIcon: Icon(Icons.search),
            //         suffixIcon: Icon(Icons.list),
            //         filled: true,
            //         fillColor: Colors.white,
            //         hintText: 'Doctor,Hospitals and more...',
            //         hintStyle: TextStyle(
            //           fontSize: 16,
            //           color: Color(0xFF777A95),
            //         ),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10),
            //           borderSide: BorderSide(
            //             color: Color(0xFFA8A8A8),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
