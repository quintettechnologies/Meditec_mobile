import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class home_background extends StatelessWidget {
  home_background({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.9, 414.0, 896.0),
          size: Size(414.4, 897.5),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child:
              // Adobe XD layer: 'Backgroung Shape' (shape)
              Container(
            decoration: BoxDecoration(
              color: const Color(0xff265dd7),
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.9, 414.4, 445.3),
          size: Size(414.4, 897.5),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_9owwaj,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 451.9, 399.9, 445.3),
          size: Size(414.4, 897.5),
          pinLeft: true,
          pinRight: true,
          pinBottom: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_lgrth5,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 253.1, 153.8),
          size: Size(414.4, 897.5),
          pinLeft: true,
          pinTop: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_h9ncep,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(283.8, 746.8, 130.7, 150.7),
          size: Size(414.4, 897.5),
          pinRight: true,
          pinBottom: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_cvog78,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}

const String _svg_9owwaj =
    '<svg viewBox="0.0 0.9 414.4 445.3" ><path transform="translate(-957.55, -20.11)" d="M 1372 466.3252868652344 C 1372 466.3252868652344 1242.594116210938 463.6502990722656 1222.895385742188 348.4508056640625 C 1203.19677734375 233.2513122558594 1209.338134765625 153.5281982421875 1109.83837890625 165.0104217529297 C 1010.338623046875 176.4926300048828 957.552001953125 228.9899291992188 957.552001953125 228.9899291992188 L 957.552001953125 21.05208206176758 L 1372 21.05208206176758 L 1372 466.3252868652344 Z" fill="#2663e2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lgrth5 =
    '<svg viewBox="0.0 451.9 399.9 445.3" ><path transform="translate(0.0, 451.89)" d="M 0 0 C 0 0 129.4058837890625 2.67498779296875 149.1046142578125 117.8744812011719 C 168.80322265625 233.073974609375 162.661865234375 312.7970886230469 262.16162109375 301.3148803710938 C 361.661376953125 289.8326416015625 441.60302734375 321.0260009765625 376.0625 357.0155944824219 C 310.522216796875 393.0051879882813 0 445.273193359375 0 445.273193359375 L 0 0 Z" fill="#2663e2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_h9ncep =
    '<svg viewBox="0.0 0.0 253.1 153.8" ><path transform="translate(-978.0, -1290.11)" d="M 978 1443.8828125 C 978 1443.8828125 1058.729248046875 1444.125 1090.095947265625 1386.637451171875 C 1121.462646484375 1329.14990234375 1135.673706054688 1290.109375 1217.705932617188 1290.109375 C 1299.73876953125 1290.109375 978 1290.109375 978 1290.109375 L 978 1443.8828125 Z" fill="#71d5d3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cvog78 =
    '<svg viewBox="283.8 746.8 130.7 150.7" ><path transform="translate(-928.4, -1249.92)" d="M 1342.8515625 1998.755981445313 C 1342.8515625 1998.755981445313 1285.65625 1980.763793945313 1274.339477539063 2051.509765625 C 1263.022705078125 2122.255859375 1212.1875 2147.40966796875 1212.1875 2147.40966796875 L 1342.8515625 2147.40966796875 L 1342.8515625 1998.755981445313 Z" fill="#fda31e" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
