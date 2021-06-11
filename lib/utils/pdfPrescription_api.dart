import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meditec/model/index.dart';
import 'package:meditec/utils/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfPrescriptionApi {
  static Future<File> generate(Prescription prescription) async {
    final pdf = Document();
    final imageSvg =
        await rootBundle.loadString('assets/images/meditec_logo.svg');

    final pageTheme = PageTheme(
        pageFormat: PdfPageFormat.a4,
        buildBackground: (context) {
          // return FullPage(
          //     ignoreMargins: false,
          //     child: Container(
          //         height: PdfPageFormat.a4.height * 0.4,
          //         child: SvgImage(svg: imageSvg, fit: BoxFit.cover)));
          return Center(
              child: Opacity(
                  opacity: 0.05,
                  child: Container(
                    child: SvgImage(svg: imageSvg, fit: BoxFit.fitHeight),
                  )));
        });

    pdf.addPage(MultiPage(
      pageTheme: pageTheme,
      build: (context) => [
        buildTitle(prescription, imageSvg),
        SizedBox(height: PdfPageFormat.cm * 0.4),
        Divider(),
        SizedBox(height: PdfPageFormat.cm * 0.4),
        buildPatientDetail(prescription),
        SizedBox(height: PdfPageFormat.cm * 0.8),
        buildPrescriptionMedicine(prescription),
        SizedBox(height: PdfPageFormat.cm * 0.8),
        buildPrescriptionTest(prescription),
        SizedBox(height: PdfPageFormat.cm * 0.8),
        buildPrescriptionAdvice(prescription),
        SizedBox(height: PdfPageFormat.cm * 0.8),
        buildPrescriptionRefer(prescription),
      ],
    ));

    return PdfApi.saveDocument(
        name:
            'C-Prescription_${prescription.id}-${DateFormat('yyyyMMdd').format(prescription.appoinment.doctorSlot.startTime)}.pdf',
        pdf: pdf);
  }

  static Widget buildTitle(Prescription prescription, String imageSVG) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: [
          SvgImage(svg: imageSVG, width: PdfPageFormat.a4.width * 0.1)
        ]),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prescription.doctor.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                prescription.doctor.categories[0].name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: PdfColor(0, 0.72, 0.72),
                ),
              ),
              Text(
                prescription.doctor.degree.degreeName,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                prescription.doctor.hospitalName,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                prescription.doctor.doctorRegistrationNumber,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ])
      ],
    );
  }

  static Widget buildPatientDetail(Prescription prescription) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text(
        //   "Name: ${prescription.patient.name}",
        //   style: TextStyle(
        //     fontSize: 14,
        //   ),
        // ),
        RichText(
          text: TextSpan(
              text: "Name: ",
              style: TextStyle(
                fontSize: 14,
              ),
              children: [
                TextSpan(
                    text: "${prescription.patient.name}",
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
        ),
        Text(
          "Age: ${prescription.patient.age}",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        Text(
          "Gender: ${prescription.patient.gender}",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  static Widget buildPrescriptionMedicine(Prescription prescription) {
    final headers = ['Medicine', 'Morning', 'Day', 'Evening', 'Days', 'Take'];
    final data = prescription.scedules.map((item) {
      return [
        item.medicine.medicineName,
        '${(item.morning == 0) ? "-" : item.morning}',
        '${(item.day == 0) ? "-" : item.day}',
        '${(item.night == 0) ? "-" : item.night}',
        '${item.days} Days',
        item.afterMeal ? "After Meal" : "Before Meal",
      ];
    }).toList();

    return Container(
        // height: PdfPageFormat.a4.height * 0.3,
        child: Column(children: [
      Table.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle:
            TextStyle(fontWeight: FontWeight.bold, color: PdfColors.white),
        headerDecoration: BoxDecoration(color: PdfColor(0, 0.72, 0.72, 0)),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.center,
          2: Alignment.center,
          3: Alignment.center,
          4: Alignment.center,
          5: Alignment.centerRight,
        },
      )
    ]));
  }

  static Widget buildPrescriptionTest(Prescription prescription) {
    return Container(
        // height: PdfPageFormat.a4.height * 0.15,
        child: Column(children: [
      Container(
        padding: EdgeInsets.all(6),
        color: PdfColor(0, 0.72, 0.72, 0),
        child: Row(children: [
          Text(
            "Tests",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
        ]),
      ),
      for (Test test in prescription.tests)
        Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              SizedBox(width: PdfPageFormat.cm * 0.8),
              Text(
                test.testName,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ]))
    ]));
  }

  static Widget buildPrescriptionAdvice(Prescription prescription) {
    return Container(
        child: Column(children: [
      Container(
        padding: EdgeInsets.all(6),
        child: Row(children: [
          Text(
            "Advice",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: PdfPageFormat.cm * 0.8),
          Text(
            prescription.advice ?? "",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
      ),
    ]));
  }

  static Widget buildPrescriptionRefer(Prescription prescription) {
    return Container(
        child: Column(children: [
      Container(
        padding: EdgeInsets.all(6),
        child: Row(children: [
          Text(
            "Reffered to",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: PdfPageFormat.cm * 0.8),
          Text(
            (prescription.referredDoctor != null)
                ? prescription.referredDoctor.name
                : "",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
      ),
    ]));
  }
}
