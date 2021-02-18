import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditec/model/doctor.dart';

class Doctors extends ChangeNotifier {
  List<Doctor> _doctors = [
    Doctor(
      id: "01",
      displayName: "Dr. Kim Jong Unn",
      degrees: "MBBS,FRCS,FCPS,SCC,UK,CD,CN",
      category: "General & Colorectal Surgery",
      hospital: "Apollo Hospital",
      status: "Available",
      photoUrl: "https://randomuser.me/api/portraits/men/5.jpg",
      rating: 4.5,
      bio:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    ),
    Doctor(
      id: "02",
      displayName: "Dr. Kim Jong Unn",
      degrees: "MBBS,FRCS,FCPS,SCC,UK,CD,CN",
      category: "General & Colorectal Surgery",
      hospital: "Square Hospital",
      status: "Available",
      photoUrl: "https://randomuser.me/api/portraits/women/81.jpg",
      rating: 5,
      bio:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    ),
    Doctor(
      id: "03",
      displayName: "Dr. K P Sinha",
      degrees: "MBBS,FRCS,FCPS,SCC,UK,CD,CN",
      category: "General & Colorectal Surgery",
      hospital: "Labaid Hospital",
      status: "Available",
      photoUrl: "https://randomuser.me/api/portraits/men/10.jpg",
      rating: 3.5,
      bio:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    ),
    Doctor(
      id: "04",
      displayName: "Dr. Kim Jong Unn",
      degrees: "MBBS,FRCS,FCPS,SCC,UK,CD,CN",
      category: "General & Colorectal Surgery",
      hospital: "Popular Hospital",
      status: "Available",
      photoUrl: "https://randomuser.me/api/portraits/women/6.jpg",
      rating: 3.5,
      bio:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    ),
  ];

  int length() {
    return this._doctors.length;
  }

  List<Doctor> get doctors => _doctors;
}

final doctorsProvider = Provider((ref) => Doctors().doctors);
