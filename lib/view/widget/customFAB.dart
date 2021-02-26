import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditec/view/screen/dashboard_screen.dart';

class MyCustomFAB extends StatefulWidget {
  @override
  _MyCustomFABState createState() => _MyCustomFABState();
}

class _MyCustomFABState extends State<MyCustomFAB> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: 70.0,
      child: FittedBox(
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xFF00BABA), width: 5),
              borderRadius: BorderRadius.circular(100)),
          backgroundColor: Color(0xFF00BABA),
          elevation: 0,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            child: SvgPicture.string(
                '''<svg xmlns="http://www.w3.org/2000/svg" width="56" height="56" viewBox="0 0 56 56">
  <g id="Home" transform="translate(-0.14 -0.14)">
    <g id="Logo_Icon" data-name="Logo Icon" transform="translate(0)">
      <circle id="Ellipse_230" data-name="Ellipse 230" cx="28" cy="28" r="28" transform="translate(0.14 0.14)" fill="#eef1f6"/>
    </g>
    <g id="Group_2754" data-name="Group 2754" transform="translate(13.14 16.14)">
      <path id="Path_1568" data-name="Path 1568" d="M165.758,356.6l-6.018-6.075v18.191h6.018Z" transform="translate(-159.74 -344.242)" fill="#00baba"/>
      <path id="Path_1569" data-name="Path 1569" d="M377.666,356.6l6.018-6.075v18.191h-6.018Z" transform="translate(-357.298 -344.242)" fill="#00baba"/>
      <path id="Path_1570" data-name="Path 1570" d="M190.5,283.35l-4.37,4.37-13.191,13.191-13.2-13.2,8.547.069,4.349,4.349,4.773-4.383.1-.093.1-.093.2-.187.1-.093.1-.093,4.178-3.837Z" transform="translate(-159.74 -283.35)" fill="#00baba"/>
      <g id="Group_2753" data-name="Group 2753" transform="translate(17.669 1.041)">
        <path id="Path_1571" data-name="Path 1571" d="M358.966,298.258l-.374.374h-1.717l-.452,1.031a.232.232,0,0,1-.2.134l-.022,0a.225.225,0,0,1-.194-.156l-.333-1.313-.325,1.05a.083.083,0,0,1-.008.022.224.224,0,0,1-.2.134l-.028,0a.226.226,0,0,1-.2-.183l-.386-2.537L354.1,300.3a.226.226,0,0,1-.218.2h-.007a.226.226,0,0,1-.221-.181l-.444-2.437-.34.658a.225.225,0,0,1-.2.122h-2.79l.1-.093.2-.187.1-.093h2.293l.5-.963a.223.223,0,0,1,.2-.122l.032,0a.224.224,0,0,1,.191.179l.346,1.9.434-3.595a.226.226,0,0,1,.219-.2h0a.227.227,0,0,1,.227.185l.452,2.97.289-.936.007-.02a.227.227,0,0,1,.208-.135h.01a.223.223,0,0,1,.2.157l.357,1.406.319-.726a.229.229,0,0,1,.206-.133Z" transform="translate(-349.778 -295.397)" fill="#00baba"/>
        <path id="Path_1572" data-name="Path 1572" d="M355.791,297.258a.319.319,0,0,0-.286.177l0,.006,0,.007-.209.477L355,296.787l0-.006v-.006a.319.319,0,0,0-.288-.221H354.7a.32.32,0,0,0-.293.19.239.239,0,0,0-.012.034l-.168.544-.391-2.565v-.007a.317.317,0,0,0-.312-.261h-.013a.317.317,0,0,0-.306.277l-.36,2.984-.235-1.291a.322.322,0,0,0-.27-.256.252.252,0,0,0-.045,0,.317.317,0,0,0-.283.173l-.472.912H349.4l-.1.093-.1.093h2.451l.524-1.013a.13.13,0,0,1,.117-.072l.019,0a.13.13,0,0,1,.112.1l.456,2.508.508-4.209a.132.132,0,0,1,.129-.116h0a.132.132,0,0,1,.128.108l.513,3.37.41-1.325a.045.045,0,0,1,0-.01.133.133,0,0,1,.122-.079h.006a.132.132,0,0,1,.12.092l.422,1.665.427-.976a.135.135,0,0,1,.121-.077h2.094l.187-.187Zm-.441,1.461a.136.136,0,0,1-.12.078h-.012a.132.132,0,0,1-.115-.092l-.413-1.63-.423,1.367a.043.043,0,0,1,0,.01.133.133,0,0,1-.121.079l-.016,0a.132.132,0,0,1-.116-.107l-.489-3.211-.5,4.17a.132.132,0,0,1-.128.116h0a.131.131,0,0,1-.13-.107l-.493-2.7-.466.9a.134.134,0,0,1-.118.072h-2.688l-.1.093-.1.093h2.892a.319.319,0,0,0,.284-.173l.214-.415.394,2.165a.321.321,0,0,0,.314.26h.01a.32.32,0,0,0,.307-.277l.339-2.812.282,1.855v.007a.317.317,0,0,0,.277.259.252.252,0,0,0,.038,0,.32.32,0,0,0,.292-.192.311.311,0,0,0,.012-.033l.225-.729.25.985v.006l0,.006a.319.319,0,0,0,.277.221l.029,0a.323.323,0,0,0,.285-.178l0-.006,0-.006.427-.976h1.563l.187-.187h-1.871Z" transform="translate(-348.79 -294.49)" fill="#fff"/>
      </g>
    </g>
  </g>
</svg>
'''),
          ),
          onPressed: () {
            Navigator.popAndPushNamed(context, Dashboard.id);
          },
        ),
      ),
    );
  }
}
