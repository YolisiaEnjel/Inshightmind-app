// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../../domain/usecases/get_recommendation.dart';


// class ResultPage extends ConsumerStatefulWidget {
//   const ResultPage({super.key});

//   @override
//   ConsumerState<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends ConsumerState<ResultPage> {
//   List<Map<String, dynamic>> history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];
//     setState(() {
//       history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//     });
//   }

//   Future<void> _saveResult(String riskLevel, double score) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];

//     final newResult = {
//       'date': DateTime.now().toIso8601String(),
//       'riskLevel': riskLevel,
//       'score': score,
//     };

//     data.add(jsonEncode(newResult));
//     await prefs.setStringList('screening_history', data);
//   }

//   Future<void> _clearHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('screening_history');
//     setState(() {
//       history.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final result = ref.watch(resultProvider);

//     String recommendation;
//     Color riskColor;

//     switch (result.riskLevel) {
//       case 'Tinggi':
//         recommendation =
//             'Disarankan untuk segera mencari dukungan, baik melalui konselor kampus, psikolog, atau teman terpercaya.';
//         riskColor = Colors.red;
//         break;
//       case 'Sedang':
//         recommendation =
//             'Luangkan waktu untuk istirahat, berbicara dengan teman, atau melakukan aktivitas yang menenangkan pikiran.';
//         riskColor = Colors.orange;
//         break;
//       default:
//         recommendation =
//             'Pertahankan kebiasaan baik. Jaga tidur, makan, dan olahraga.';
//         riskColor = Colors.green;
//     }

//     // Simpan hasil setelah halaman dibuka pertama kali
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _saveResult(result.riskLevel, result.score.toDouble());
//     });

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text(
//           'Hasil Screening',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         elevation: 3,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // 🔹 Kartu Hasil Utama
//             Card(
//               elevation: 5,
//               shadowColor: Colors.pink.shade100,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               color: Colors.white,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.lightbulb_outline_rounded,
//                       size: 60,
//                       color: Color.fromRGBO(241, 67, 198, 1),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Skor Anda: ${result.score}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Tingkat Risiko: ${result.riskLevel}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: riskColor,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       recommendation,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         height: 1.4,
//                       ),
//                     ),
//                     const SizedBox(height: 28),
//                     ElevatedButton.icon(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.arrow_back_rounded),
//                       label: const Text(
//                         'Kembali',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w500),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             // 🔹 Riwayat Screening
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Riwayat Screening Sebelumnya',
//                 style: TextStyle(
//                     fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
//               ),
//             ),
//             const SizedBox(height: 12),

//             if (history.isEmpty)
//               const Text(
//                 'Belum ada riwayat screening.',
//                 style: TextStyle(color: Colors.grey),
//               )
//             else
//               ...history.reversed.map((item) {
//                 final date = DateTime.parse(item['date']);
//                 return Card(
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     leading: const Icon(Icons.history,
//                         color: Color.fromRGBO(241, 67, 198, 1)),
//                     title: Text('Risiko: ${item['riskLevel']}'),
//                     subtitle: Text(
//                       'Skor: ${item['score']} • ${date.day}/${date.month}/${date.year} '
//                       '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
//                     ),
//                   ),
//                 );
//               }),

//             const SizedBox(height: 12),

//             if (history.isNotEmpty)
//               TextButton.icon(
//                 onPressed: _clearHistory,
//                 icon: const Icon(Icons.delete_outline, color: Colors.black54),
//                 label: const Text(
//                   'Hapus Riwayat',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../../domain/usecases/get_recommendation.dart';

// class ResultPage extends ConsumerStatefulWidget {
//   const ResultPage({super.key});

//   @override
//   ConsumerState<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends ConsumerState<ResultPage> {
//   List<Map<String, dynamic>> history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];
//     setState(() {
//       history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//     });
//   }

//   Future<void> _saveResult(String riskLevel, double score) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];

//     final newResult = {
//       'date': DateTime.now().toIso8601String(),
//       'riskLevel': riskLevel,
//       'score': score,
//     };

//     data.add(jsonEncode(newResult));
//     await prefs.setStringList('screening_history', data);
//   }

//   Future<void> _clearHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('screening_history');
//     setState(() {
//       history.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final result = ref.watch(resultProvider);

//     // 🔹 REKOMENDASI MENGGUNAKAN USE CASE (TAMBAHAN)
//     final recommendationResult =
//         GetRecommendation().execute(result.riskLevel);

//     Color riskColor;
//     switch (result.riskLevel) {
//       case 'Tinggi':
//         riskColor = Colors.red;
//         break;
//       case 'Sedang':
//         riskColor = Colors.orange;
//         break;
//       default:
//         riskColor = Colors.green;
//     }

//     // Simpan hasil setelah halaman dibuka pertama kali
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _saveResult(result.riskLevel, result.score.toDouble());
//     });

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text(
//           'Hasil Screening',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         elevation: 3,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // 🔹 Kartu Hasil Utama
//             Card(
//               elevation: 5,
//               shadowColor: Colors.pink.shade100,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 40.0, horizontal: 24.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.lightbulb_outline_rounded,
//                       size: 60,
//                       color: Color.fromRGBO(241, 67, 198, 1),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Skor Anda: ${result.score}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Tingkat Risiko: ${result.riskLevel}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: riskColor,
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // 🔹 REKOMENDASI AWAL (TETAP DI POSISI YANG SAMA)
//                     Text(
//                       recommendationResult.message,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         height: 1.4,
//                       ),
//                     ),

//                     const SizedBox(height: 28),
//                     ElevatedButton.icon(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.arrow_back_rounded),
//                       label: const Text(
//                         'Kembali',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w500),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             // 🔹 Riwayat Screening
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Riwayat Screening Sebelumnya',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87),
//               ),
//             ),
//             const SizedBox(height: 12),

//             if (history.isEmpty)
//               const Text(
//                 'Belum ada riwayat screening.',
//                 style: TextStyle(color: Colors.grey),
//               )
//             else
//               ...history.reversed.map((item) {
//                 final date = DateTime.parse(item['date']);
//                 return Card(
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     leading: const Icon(Icons.history,
//                         color: Color.fromRGBO(241, 67, 198, 1)),
//                     title: Text('Risiko: ${item['riskLevel']}'),
//                     subtitle: Text(
//                       'Skor: ${item['score']} • ${date.day}/${date.month}/${date.year} '
//                       '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
//                     ),
//                   ),
//                 );
//               }),

//             const SizedBox(height: 12),

//             if (history.isNotEmpty)
//               TextButton.icon(
//                 onPressed: _clearHistory,
//                 icon: const Icon(Icons.delete_outline, color: Colors.black54),
//                 label: const Text(
//                   'Hapus Riwayat',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../../domain/usecases/get_recommendation.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:pdf/widgets.dart' as pw;


// class ResultPage extends ConsumerStatefulWidget {
//   const ResultPage({super.key});

//   @override
//   ConsumerState<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends ConsumerState<ResultPage> {
//   List<Map<String, dynamic>> history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];
//     setState(() {
//       history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//     });
//   }

//   // 🔹 DITAMBAHKAN: rekomendasi ikut disimpan (TIDAK MERUSAK DATA LAMA)
//   Future<void> _saveResult(
//     String riskLevel,
//     double score,
//     String recommendation,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];

//     final newResult = {
//       'date': DateTime.now().toIso8601String(),
//       'riskLevel': riskLevel,
//       'score': score,
//       'recommendation': recommendation,
//     };

//     data.add(jsonEncode(newResult));
//     await prefs.setStringList('screening_history', data);
//   }

//   Future<void> _clearHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('screening_history');
//     setState(() {
//       history.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final result = ref.watch(resultProvider);

//     // 🔹 REKOMENDASI MENGGUNAKAN USECASE (TAMBAHAN SAJA)
//     final recommendationResult =
//         GetRecommendation().execute(result.riskLevel);

//     Color riskColor;
//     switch (result.riskLevel) {
//       case 'Tinggi':
//         riskColor = Colors.red;
//         break;
//       case 'Sedang':
//         riskColor = Colors.orange;
//         break;
//       default:
//         riskColor = Colors.green;
//     }

//     // 🔹 Simpan hasil + rekomendasi (UI TIDAK TERPENGARUH)
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _saveResult(
//         result.riskLevel,
//         result.score.toDouble(),
//         recommendationResult.message,
//       );
//     });

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text(
//           'Hasil Screening',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         elevation: 3,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // 🔹 Kartu Hasil Utama
//             Card(
//               elevation: 5,
//               shadowColor: Colors.pink.shade100,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 40.0, horizontal: 24.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.lightbulb_outline_rounded,
//                       size: 60,
//                       color: Color.fromRGBO(241, 67, 198, 1),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Skor Anda: ${result.score}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Tingkat Risiko: ${result.riskLevel}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: riskColor,
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // 🔹 REKOMENDASI (POSISI & UI TETAP)
//                     Text(
//                       recommendationResult.message,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         height: 1.4,
//                       ),
//                     ),

//                     const SizedBox(height: 28),
//                     ElevatedButton.icon(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.arrow_back_rounded),
//                       label: const Text(
//                         'Kembali',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w500),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             // 🔹 Riwayat Screening
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Riwayat Screening Sebelumnya',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87),
//               ),
//             ),
//             const SizedBox(height: 12),

//             if (history.isEmpty)
//               const Text(
//                 'Belum ada riwayat screening.',
//                 style: TextStyle(color: Colors.grey),
//               )
//             else
//               ...history.reversed.map((item) {
//                 final date = DateTime.parse(item['date']);
//                 return Card(
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     leading: const Icon(Icons.history,
//                         color: Color.fromRGBO(241, 67, 198, 1)),
//                     title: Text('Risiko: ${item['riskLevel']}'),
//                     subtitle: Text(
//                       'Skor: ${item['score']} • ${date.day}/${date.month}/${date.year} '
//                       '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
//                     ),
//                   ),
//                 );
//               }),

//             const SizedBox(height: 12),

//             if (history.isNotEmpty)
//               TextButton.icon(
//                 onPressed: _clearHistory,
//                 icon: const Icon(Icons.delete_outline, color: Colors.black54),
//                 label: const Text(
//                   'Hapus Riwayat',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../../domain/usecases/get_recommendation.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'history_detail_page.dart';


// class ResultPage extends ConsumerStatefulWidget {
//   const ResultPage({super.key});

//   @override
//   ConsumerState<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends ConsumerState<ResultPage> {
//   List<Map<String, dynamic>> history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];
//     setState(() {
//       history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//     });
//   }

//   // 🔹 SIMPAN HASIL + REKOMENDASI (TIDAK MERUSAK DATA LAMA)
//   Future<void> _saveResult(
//     String riskLevel,
//     double score,
//     String recommendation,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];

//     final newResult = {
//       'date': DateTime.now().toIso8601String(),
//       'riskLevel': riskLevel,
//       'score': score,
//       'recommendation': recommendation,
//     };

//     data.add(jsonEncode(newResult));
//     await prefs.setStringList('screening_history', data);
//   }

//   Future<void> _clearHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('screening_history');
//     setState(() {
//       history.clear();
//     });
//   }

//   // 🔹 EXPORT RIWAYAT KE PDF (TAMBAHAN SAJA)
//   Future<void> _exportHistoryToPdf() async {
//     final pdf = pw.Document();
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/riwayat_screening.pdf');

//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) => [
//           pw.Text(
//             'Riwayat Screening Kesehatan Mental',
//             style: pw.TextStyle(
//               fontSize: 20,
//               fontWeight: pw.FontWeight.bold,
//             ),
//           ),
//           pw.SizedBox(height: 16),
//           ...history.reversed.map((item) {
//             final date = DateTime.parse(item['date']);
//             return pw.Container(
//               margin: const pw.EdgeInsets.only(bottom: 12),
//               padding: const pw.EdgeInsets.all(10),
//               decoration: pw.BoxDecoration(
//                 border: pw.Border.all(),
//                 borderRadius: pw.BorderRadius.circular(8),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'Tanggal: ${date.day}/${date.month}/${date.year}',
//                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                   ),
//                   pw.Text('Skor: ${item['score']}'),
//                   pw.Text('Risiko: ${item['riskLevel']}'),
//                   pw.Text(
//                     'Rekomendasi:\n${item['recommendation'] ?? '-'}',
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );

//     await file.writeAsBytes(await pdf.save());
//     await OpenFilex.open(file.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final result = ref.watch(resultProvider);

//     final recommendationResult =
//         GetRecommendation().execute(result.riskLevel);

//     Color riskColor;
//     switch (result.riskLevel) {
//       case 'Tinggi':
//         riskColor = Colors.red;
//         break;
//       case 'Sedang':
//         riskColor = Colors.orange;
//         break;
//       default:
//         riskColor = Colors.green;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _saveResult(
//         result.riskLevel,
//         result.score.toDouble(),
//         recommendationResult.message,
//       );
//     });

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text(
//           'Hasil Screening',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         elevation: 3,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Card(
//               elevation: 5,
//               shadowColor: Colors.pink.shade100,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 40.0, horizontal: 24.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.lightbulb_outline_rounded,
//                       size: 60,
//                       color: Color.fromRGBO(241, 67, 198, 1),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Skor Anda: ${result.score}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Tingkat Risiko: ${result.riskLevel}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: riskColor,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       recommendationResult.message,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         height: 1.4,
//                       ),
//                     ),
//                     const SizedBox(height: 28),
//                     ElevatedButton.icon(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.arrow_back_rounded),
//                       label: const Text(
//                         'Kembali',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w500),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color.fromRGBO(241, 67, 198, 1),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Riwayat Screening Sebelumnya',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87),
//               ),
//             ),
//             const SizedBox(height: 12),

//             if (history.isEmpty)
//               const Text(
//                 'Belum ada riwayat screening.',
//                 style: TextStyle(color: Colors.grey),
//               )
//             else
//               ...history.reversed.map((item) {
//                 final date = DateTime.parse(item['date']);
//                 return Card(
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     leading: const Icon(Icons.history,
//                         color: Color.fromRGBO(241, 67, 198, 1)),
//                     title: Text('Risiko: ${item['riskLevel']}'),
//                     subtitle: Text(
//                       'Skor: ${item['score']} • ${date.day}/${date.month}/${date.year} '
//                       '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
//                     ),
//                   ),
//                 );
//               }),

//             const SizedBox(height: 12),

//             if (history.isNotEmpty)
//               TextButton.icon(
//                 onPressed: _clearHistory,
//                 icon:
//                     const Icon(Icons.delete_outline, color: Colors.black54),
//                 label: const Text(
//                   'Hapus Riwayat',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),

//             if (history.isNotEmpty)
//               TextButton.icon(
//                 onPressed: _exportHistoryToPdf,
//                 icon:
//                     const Icon(Icons.picture_as_pdf, color: Colors.red),
//                 label: const Text(
//                   'Export PDF',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../../domain/usecases/get_recommendation.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'history_detail_page.dart';
// import 'package:fl_chart/fl_chart.dart';


// class ResultPage extends ConsumerStatefulWidget {
//   const ResultPage({super.key});

//   @override
//   ConsumerState<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends ConsumerState<ResultPage> {
//   List<Map<String, dynamic>> history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];
//     setState(() {
//       history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//     });
//   }

//   // 🔹 SIMPAN HASIL + REKOMENDASI (AMAN UNTUK DATA LAMA)
//   Future<void> _saveResult(
//     String riskLevel,
//     double score,
//     String recommendation,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];

//     final newResult = {
//       'date': DateTime.now().toIso8601String(),
//       'riskLevel': riskLevel,
//       'score': score,
//       'recommendation': recommendation,
//     };

//     data.add(jsonEncode(newResult));
//     await prefs.setStringList('screening_history', data);
//   }

//   Future<void> _clearHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('screening_history');
//     setState(() {
//       history.clear();
//     });
//   }

//   // 🔹 EXPORT RIWAYAT KE PDF
//   Future<void> _exportHistoryToPdf() async {
//     final pdf = pw.Document();
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/riwayat_screening.pdf');

//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) => [
//           pw.Text(
//             'Riwayat Screening Kesehatan Mental',
//             style: pw.TextStyle(
//               fontSize: 20,
//               fontWeight: pw.FontWeight.bold,
//             ),
//           ),
//           pw.SizedBox(height: 16),
//           ...history.reversed.map((item) {
//             final date = DateTime.parse(item['date']);
//             return pw.Container(
//               margin: const pw.EdgeInsets.only(bottom: 12),
//               padding: const pw.EdgeInsets.all(10),
//               decoration: pw.BoxDecoration(
//                 border: pw.Border.all(),
//                 borderRadius: pw.BorderRadius.circular(8),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'Tanggal: ${date.day}/${date.month}/${date.year}',
//                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                   ),
//                   pw.Text('Skor: ${item['score']}'),
//                   pw.Text('Risiko: ${item['riskLevel']}'),
//                   pw.Text(
//                     'Rekomendasi:\n${item['recommendation'] ?? '-'}',
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );

//     await file.writeAsBytes(await pdf.save());
//     await OpenFilex.open(file.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final result = ref.watch(resultProvider);
//     final recommendationResult =
//         GetRecommendation().execute(result.riskLevel);

//     Color riskColor;
//     switch (result.riskLevel) {
//       case 'Tinggi':
//         riskColor = Colors.red;
//         break;
//       case 'Sedang':
//         riskColor = Colors.orange;
//         break;
//       default:
//         riskColor = Colors.green;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _saveResult(
//         result.riskLevel,
//         result.score.toDouble(),
//         recommendationResult.message,
//       );
//     });

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text(
//           'Hasil Screening',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         elevation: 3,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Card(
//               elevation: 5,
//               shadowColor: Colors.pink.shade100,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 40.0, horizontal: 24.0),
//                 child: Column(
//                   children: [
//                     const Icon(
//                       Icons.lightbulb_outline_rounded,
//                       size: 60,
//                       color: Color.fromRGBO(241, 67, 198, 1),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Skor Anda: ${result.score}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Tingkat Risiko: ${result.riskLevel}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: riskColor,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       recommendationResult.message,
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 28),
//                     ElevatedButton.icon(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.arrow_back),
//                       label: const Text('Kembali'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Riwayat Screening Sebelumnya',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 12),

//             if (history.isEmpty)
//               const Text('Belum ada riwayat screening.')
//             else
//               ...history.reversed.map((item) {
//                 final date = DateTime.parse(item['date']);
//                 return Card(
//                   child: ListTile(
//                     // 🔹 TAMBAHAN FITUR: KLIK KE DETAIL (TIDAK MERUSAK UI)
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               HistoryDetailPage(data: item),
//                         ),
//                       );
//                     },
//                     leading: const Icon(Icons.history,
//                         color: Color.fromRGBO(241, 67, 198, 1)),
//                     title: Text('Risiko: ${item['riskLevel']}'),
//                     subtitle: Text(
//                       'Skor: ${item['score']} • '
//                       '${date.day}/${date.month}/${date.year}',
//                     ),
//                   ),
//                 );
//               }),

//             if (history.isNotEmpty)
//               TextButton.icon(
//                 onPressed: _clearHistory,
//                 icon: const Icon(Icons.delete),
//                 label: const Text('Hapus Riwayat'),
//               ),

//             if (history.isNotEmpty)
//               TextButton.icon(
//                 onPressed: _exportHistoryToPdf,
//                 icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
//                 label: const Text('Export PDF'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../../domain/usecases/get_recommendation.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'history_detail_page.dart';
// import 'package:fl_chart/fl_chart.dart';

// class ResultPage extends ConsumerStatefulWidget {
//   const ResultPage({super.key});

//   @override
//   ConsumerState<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends ConsumerState<ResultPage> {
//   List<Map<String, dynamic>> history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];
//     setState(() {
//       history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//     });
//   }

//   Future<void> _saveResult(
//     String riskLevel,
//     double score,
//     String recommendation,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];

//     final newResult = {
//       'date': DateTime.now().toIso8601String(),
//       'riskLevel': riskLevel,
//       'score': score,
//       'recommendation': recommendation,
//     };

//     data.add(jsonEncode(newResult));
//     await prefs.setStringList('screening_history', data);
//   }

//   Future<void> _clearHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('screening_history');
//     setState(() {
//       history.clear();
//     });
//   }

//   // ===================== PDF (KODE LAMA – TIDAK DIUBAH) =====================
//   Future<void> _exportHistoryToPdf() async {
//     final pdf = pw.Document();
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/riwayat_screening.pdf');

//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) => [
//           pw.Text(
//             'Riwayat Screening Kesehatan Mental',
//             style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
//           ),
//           pw.SizedBox(height: 16),
//           ...history.reversed.map((item) {
//             final date = DateTime.parse(item['date']);
//             return pw.Container(
//               margin: const pw.EdgeInsets.only(bottom: 12),
//               padding: const pw.EdgeInsets.all(10),
//               decoration: pw.BoxDecoration(
//                 border: pw.Border.all(),
//                 borderRadius: pw.BorderRadius.circular(8),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'Tanggal: ${date.day}/${date.month}/${date.year}',
//                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                   ),
//                   pw.Text('Skor: ${item['score']}'),
//                   pw.Text('Risiko: ${item['riskLevel']}'),
//                   pw.Text(
//                     'Rekomendasi:\n${item['recommendation'] ?? '-'}',
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );

//     await file.writeAsBytes(await pdf.save());
//     await OpenFilex.open(file.path);
//   }

//   // ===================== TAMBAHAN: GRAFIK PERKEMBANGAN =====================
//   Widget _buildScoreChart() {
//     if (history.length < 2) {
//       return const Text(
//         'Grafik akan muncul setelah minimal 2 kali screening.',
//         style: TextStyle(color: Colors.grey),
//       );
//     }

//     final spots = <FlSpot>[];
//     for (int i = 0; i < history.length; i++) {
//       final score = (history[i]['score'] as num).toDouble();
//       spots.add(FlSpot(i.toDouble() + 1, score));
//     }

//     return SizedBox(
//       height: 220,
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: true),
//           borderData: FlBorderData(show: true),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: true),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   return Text(
//                     value.toInt().toString(),
//                     style: const TextStyle(fontSize: 10),
//                   );
//                 },
//               ),
//             ),
//           ),
//           lineBarsData: [
//             LineChartBarData(
//               spots: spots,
//               isCurved: true,
//               barWidth: 3,
//               dotData: FlDotData(show: true),
//               color: const Color.fromRGBO(241, 67, 198, 1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final result = ref.watch(resultProvider);
//     final recommendationResult =
//         GetRecommendation().execute(result.riskLevel);

//     Color riskColor;
//     switch (result.riskLevel) {
//       case 'Tinggi':
//         riskColor = Colors.red;
//         break;
//       case 'Sedang':
//         riskColor = Colors.orange;
//         break;
//       default:
//         riskColor = Colors.green;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _saveResult(
//         result.riskLevel,
//         result.score.toDouble(),
//         recommendationResult.message,
//       );
//     });

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text(
//           'Hasil Screening',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // ===================== UI LAMA (TIDAK DIUBAH) =====================
//             Card(
//               child: ListTile(
//                 title: Text('Skor Anda: ${result.score}'),
//                 subtitle: Text(
//                   'Risiko: ${result.riskLevel}',
//                   style: TextStyle(color: riskColor),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             // ===================== TAMBAHAN GRAFIK =====================
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Grafik Perkembangan Skor',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildScoreChart(),

//             const SizedBox(height: 32),

//             // ===================== RIWAYAT (TETAP) =====================
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Riwayat Screening Sebelumnya',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),

//             ...history.reversed.map((item) {
//               final date = DateTime.parse(item['date']);
//               return ListTile(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => HistoryDetailPage(data: item),
//                     ),
//                   );
//                 },
//                 title: Text('Risiko: ${item['riskLevel']}'),
//                 subtitle: Text(
//                     'Skor: ${item['score']} • ${date.day}/${date.month}/${date.year}'),
//               );
//             }),

//             TextButton.icon(
//               onPressed: _exportHistoryToPdf,
//               icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
//               label: const Text('Export PDF'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../../domain/usecases/get_recommendation.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'history_detail_page.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../../core/notification_service.dart';


// class ResultPage extends ConsumerStatefulWidget {
//   const ResultPage({super.key});

//   @override
//   ConsumerState<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends ConsumerState<ResultPage> {
//   List<Map<String, dynamic>> history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];
//     setState(() {
//       history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//     });
//   }

//   Future<void> _saveResult(
//     String riskLevel,
//     double score,
//     String recommendation,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];

//     final newResult = {
//       'date': DateTime.now().toIso8601String(),
//       'riskLevel': riskLevel,
//       'score': score,
//       'recommendation': recommendation,
//     };

//     data.add(jsonEncode(newResult));
//     await prefs.setStringList('screening_history', data);
//   }

//   Future<void> _clearHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('screening_history');
//     setState(() {
//       history.clear();
//     });
//   }

//   Future<void> _exportHistoryToPdf() async {
//     final pdf = pw.Document();
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/riwayat_screening.pdf');

//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) => [
//           pw.Text(
//             'Riwayat Screening Kesehatan Mental',
//             style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
//           ),
//           pw.SizedBox(height: 16),
//           ...history.reversed.map((item) {
//             final date = DateTime.parse(item['date']);
//             return pw.Container(
//               margin: const pw.EdgeInsets.only(bottom: 12),
//               padding: const pw.EdgeInsets.all(10),
//               decoration: pw.BoxDecoration(
//                 border: pw.Border.all(),
//                 borderRadius: pw.BorderRadius.circular(8),
//               ),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'Tanggal: ${date.day}/${date.month}/${date.year}',
//                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                   ),
//                   pw.Text('Skor: ${item['score']}'),
//                   pw.Text('Risiko: ${item['riskLevel']}'),
//                   pw.Text(
//                     'Rekomendasi:\n${item['recommendation'] ?? '-'}',
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );

//     await file.writeAsBytes(await pdf.save());
//     await OpenFilex.open(file.path);
//   }

//   // ===================== GRAFIK (TAMBAHAN) =====================
//   Widget _buildScoreChart() {
//     if (history.length < 2) {
//       return const Text(
//         'Grafik akan muncul setelah minimal 2 kali screening.',
//         style: TextStyle(color: Colors.grey),
//       );
//     }

//     final spots = <FlSpot>[];
//     for (int i = 0; i < history.length; i++) {
//       final score = (history[i]['score'] as num).toDouble();
//       spots.add(FlSpot(i.toDouble() + 1, score));
//     }

//     return SizedBox(
//       height: 220,
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: true),
//           borderData: FlBorderData(show: true),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: true),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   return Text(
//                     value.toInt().toString(),
//                     style: const TextStyle(fontSize: 10),
//                   );
//                 },
//               ),
//             ),
//           ),
//           lineBarsData: [
//             LineChartBarData(
//               spots: spots,
//               isCurved: true,
//               barWidth: 3,
//               dotData: FlDotData(show: true),
//               color: const Color.fromRGBO(241, 67, 198, 1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final result = ref.watch(resultProvider);
//     final recommendationResult =
//         GetRecommendation().execute(result.riskLevel);

//     Color riskColor;
//     switch (result.riskLevel) {
//       case 'Tinggi':
//         riskColor = Colors.red;
//         break;
//       case 'Sedang':
//         riskColor = Colors.orange;
//         break;
//       default:
//         riskColor = Colors.green;
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _saveResult(
//         result.riskLevel,
//         result.score.toDouble(),
//         recommendationResult.message,
//       );
//     });

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text(
//           'Hasil Screening',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Card(
//               child: ListTile(
//                 title: Text('Skor Anda: ${result.score}'),
//                 subtitle: Text(
//                   'Risiko: ${result.riskLevel}',
//                   style: TextStyle(color: riskColor),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),

//             // ===== HASIL SCREENING (DIKEMBALIKAN) =====
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(recommendationResult.message),
//               ),
//             ),

//             const SizedBox(height: 32),

//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Grafik Perkembangan Skor',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildScoreChart(),

//             const SizedBox(height: 32),

//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Riwayat Screening Sebelumnya',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),

//             ...history.reversed.map((item) {
//               final date = DateTime.parse(item['date']);
//               return ListTile(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => HistoryDetailPage(data: item),
//                     ),
//                   );
//                 },
//                 title: Text('Risiko: ${item['riskLevel']}'),
//                 subtitle: Text(
//                   'Skor: ${item['score']} • ${date.day}/${date.month}/${date.year}',
//                 ),
//               );
//             }),

//             // ===== HAPUS RIWAYAT (DIKEMBALIKAN) =====
//             if (history.isNotEmpty)
//               TextButton.icon(
//                 onPressed: _clearHistory,
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 label: const Text(
//                   'Hapus Riwayat',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),

//             TextButton.icon(
//               onPressed: _exportHistoryToPdf,
//               icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
//               label: const Text('Export PDF'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/score_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/usecases/get_recommendation.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/widgets.dart' as pw;
import 'history_detail_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:insightmind_app/core/notification_service.dart';



class ResultPage extends ConsumerStatefulWidget {
  const ResultPage({super.key});

  @override
  ConsumerState<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends ConsumerState<ResultPage> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();

    // 🔔 REMINDER SCREENING (TAMBAHAN SAJA, TIDAK MENGUBAH UI)
    Future.delayed(const Duration(seconds: 2), () {
      NotificationService.showNotification(
        title: 'Reminder Screening',
        body: 'Jangan lupa lakukan screening kesehatan mental hari ini 💙',
      );
    });
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('screening_history') ?? [];
    setState(() {
      history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    });
  }

  Future<void> _saveResult(
    String riskLevel,
    double score,
    String recommendation,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('screening_history') ?? [];

    final newResult = {
      'date': DateTime.now().toIso8601String(),
      'riskLevel': riskLevel,
      'score': score,
      'recommendation': recommendation,
    };

    data.add(jsonEncode(newResult));
    await prefs.setStringList('screening_history', data);
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('screening_history');
    setState(() {
      history.clear();
    });
  }

  Future<void> _exportHistoryToPdf() async {
    final pdf = pw.Document();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/riwayat_screening.pdf');

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text(
            'Riwayat Screening Kesehatan Mental',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          ...history.reversed.map((item) {
            final date = DateTime.parse(item['date']);
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 12),
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Tanggal: ${date.day}/${date.month}/${date.year}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text('Skor: ${item['score']}'),
                  pw.Text('Risiko: ${item['riskLevel']}'),
                  pw.Text(
                    'Rekomendasi:\n${item['recommendation'] ?? '-'}',
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );

    await file.writeAsBytes(await pdf.save());
    await OpenFilex.open(file.path);
  }

  Widget _buildScoreChart() {
    if (history.length < 2) {
      return const Text(
        'Grafik akan muncul setelah minimal 2 kali screening.',
        style: TextStyle(color: Colors.grey),
      );
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < history.length; i++) {
      final score = (history[i]['score'] as num).toDouble();
      spots.add(FlSpot(i.toDouble() + 1, score));
    }

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 3,
              dotData: FlDotData(show: true),
              color: const Color.fromRGBO(241, 67, 198, 1),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(resultProvider);
    final recommendationResult =
        GetRecommendation().execute(result.riskLevel);

    Color riskColor;
    switch (result.riskLevel) {
      case 'Tinggi':
        riskColor = Colors.red;
        break;
      case 'Sedang':
        riskColor = Colors.orange;
        break;
      default:
        riskColor = Colors.green;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveResult(
        result.riskLevel,
        result.score.toDouble(),
        recommendationResult.message,
      );
    });

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text(
          'Hasil Screening',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Skor Anda: ${result.score}'),
                subtitle: Text(
                  'Risiko: ${result.riskLevel}',
                  style: TextStyle(color: riskColor),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(recommendationResult.message),
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Grafik Perkembangan Skor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            _buildScoreChart(),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Riwayat Screening Sebelumnya',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...history.reversed.map((item) {
              final date = DateTime.parse(item['date']);
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HistoryDetailPage(data: item),
                    ),
                  );
                },
                title: Text('Risiko: ${item['riskLevel']}'),
                subtitle: Text(
                  'Skor: ${item['score']} • ${date.day}/${date.month}/${date.year}',
                ),
              );
            }),
            if (history.isNotEmpty)
              TextButton.icon(
                onPressed: _clearHistory,
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  'Hapus Riwayat',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            TextButton.icon(
              onPressed: _exportHistoryToPdf,
              icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
              label: const Text('Export PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
