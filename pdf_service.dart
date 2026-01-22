import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static Future<File> generateReport({
    required String nama,
    required String risiko,
    required int skor,
    required DateTime tanggal,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "LAPORAN HASIL SCREENING",
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),
              pw.Text("Nama: $nama"),
              pw.Text("Tanggal: $tanggal"),
              pw.SizedBox(height: 10),
              pw.Text("Skor: $skor"),
              pw.Text("Risiko: $risiko"),

              pw.SizedBox(height: 30),
              pw.Text(
                "InsightMind App",
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey, // ✅ sekarang tidak error
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/laporan_screening.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
