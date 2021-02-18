import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditec/view/constants.dart';

class CatagoryButtonDashBoard extends StatelessWidget {
  CatagoryButtonDashBoard({this.category, this.color, this.onTap});

  final String category;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: color,
            child: Container(
              height: space * 0.3 * 0.9,
              width: space * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: space * 0.1,
                    width: space * 0.1,
                    child: SvgPicture.asset(
                        "assets/icons/dashboard/$category.svg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    category,
                    style: TextStyle(
                        color: kPrimaryTextColor, fontSize: space * 0.04),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
