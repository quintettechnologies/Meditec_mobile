import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meditec/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/view/screen/notificationScreen.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDashboard;
  final bool enableSearch;
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final Function onChangedCallback;

  const MyCustomAppBar(
      {Key key,
      this.isDashboard = false,
      this.enableSearch = false,
      this.searchController,
      this.onChangedCallback,
      this.searchFocus})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.zero,
        color: Color(0xFFF7F7F7),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDashboard
                          ? Row(
                              children: [
                                (context
                                            .read(userProvider)
                                            .currentUser()
                                            .userAvatar !=
                                        null)
                                    ? Padding(
                                        padding:
                                            EdgeInsets.only(left: space * 0.06),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: Image(
                                              image: Image.memory(base64.decode(
                                                      context
                                                          .read(userProvider)
                                                          .currentUser()
                                                          .userAvatar
                                                          .image))
                                                  .image,
                                              fit: BoxFit.fitHeight,
                                              height: 40,
                                            )
                                            // child: Image(
                                            //   image:
                                            //       AssetImage('assets/images/profiles/user.png'),
                                            // ),
                                            ),
                                      )
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(left: space * 0.06),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.only(left: space * 0.02),
                                  child: Text(
                                    // "Welcome\n${context.read(userProvider).currentUser().name}",
                                    "Welcome",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF00CACA),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            )
                          : FlatButton(
                              onPressed: !isDashboard
                                  ? () {
                                      Navigator.pop(context);
                                    }
                                  : null,
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
                      FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, NotificationScreen.id);
                          },
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "cicil",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF00CACA)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            enableSearch
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: Row(
                      children: [
                        FlatButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            padding: EdgeInsets.zero,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFFEDF0F0),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.menu,
                                color: Color(0xFF00CACA),
                              ),
                            )),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: TextField(
                              controller: searchController,
                              onChanged: onChangedCallback,
                              focusNode: searchFocus,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF777A95)),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search_outlined),
                                suffixIcon: Icon(Icons.menu),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Doctor,Hospitals and more...',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF777A95),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFA8A8A8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 25,
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(enableSearch ? 120 : 70);
}
