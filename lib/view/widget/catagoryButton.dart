import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditec/constants.dart';

class CategoryButton extends StatelessWidget {
  CategoryButton({this.category, this.color});

  final String category;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(15),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: SvgPicture.asset(
                    "assets/icons/doctor_page/$category.svg",
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          category,
          style: TextStyle(color: kPrimaryTextColor, fontSize: space * 0.04),
        ),
      ],
    );
  }
}
// Image(
// image: AssetImage('assets/icons/doctor_page/$category.png'),
// ),
