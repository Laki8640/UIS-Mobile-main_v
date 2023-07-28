import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

Future<File> generateCertificate(String name) async {
  final pdf = pw.Document();

  final image = pw.MemoryImage(
    File('assets/certificate_background.png').readAsBytesSync(),
  );

  pdf.addPage(pw.Page(
    build: (pw.Context context) => pw.Container(
      decoration: pw.BoxDecoration(
        image: pw.DecorationImage(
          image: image,
          fit: pw.BoxFit.cover,
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          'Certificate of Completion',
          style: pw.TextStyle(
            fontSize: 32,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
      ),
    ),
  ));

  pdf.addPage(pw.Page(
    build: (pw.Context context) => pw.Center(
      child: pw.Text(
        'This certificate is awarded to',
        style: pw.TextStyle(
          fontSize: 24,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ),
  ));

  pdf.addPage(pw.Page(
    build: (pw.Context context) => pw.Center(
      child: pw.Text(
        name,
        style: pw.TextStyle(
          fontSize: 32,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ),
  ));

  final file = File('${name}_certificate.pdf');
  await file.writeAsBytes(pdf.save() as List<int>);

  return file;
}
