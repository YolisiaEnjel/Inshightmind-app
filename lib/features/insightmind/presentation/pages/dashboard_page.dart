// import 'package:flutter/material.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard InsightMind'),
//         backgroundColor: Colors.pink,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _summaryCard(),
//             const SizedBox(height: 16),
//             _graphPlaceholder(),
//             const SizedBox(height: 16),
//             _actionButtons(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _summaryCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Hasil Screening Terakhir',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text('Skor: 7'),
//             Text(
//               'Risiko: Rendah',
//               style: TextStyle(color: Colors.green),
//             ),
//             Text('Tanggal: 15/01/2026'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _graphPlaceholder() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         height: 200,
//         child: Center(
//           child: Text(
//             'Grafik Perkembangan Skor\n(akan dihubungkan ke data)',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _actionButtons() {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//           icon: const Icon(Icons.picture_as_pdf),
//           label: const Text('Export Laporan PDF'),
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.redAccent,
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ElevatedButton.icon(
//           icon: const Icon(Icons.notifications),
//           label: const Text('Atur Reminder Screening'),
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';
// // 🔹 TAMBAHAN SAJA (tidak mengubah UI)
// import 'result_page.dart';
// import '../../../../core/notification_service.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard InsightMind'),
//         backgroundColor: Colors.pink,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _summaryCard(),
//             const SizedBox(height: 16),
//             _graphPlaceholder(),
//             const SizedBox(height: 16),
//             _actionButtons(context), // 🔹 parameter ditambahkan
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= KODE LAMA (TIDAK DIUBAH) =================
//   Widget _summaryCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Hasil Screening Terakhir',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text('Skor: 7'),
//             Text(
//               'Risiko: Rendah',
//               style: TextStyle(color: Colors.green),
//             ),
//             Text('Tanggal: 15/01/2026'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _graphPlaceholder() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         height: 200,
//         child: Center(
//           child: Text(
//             'Grafik Perkembangan Skor\n(akan dihubungkan ke data)',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }

//   // ================= TAMBAHAN LOGIKA SAJA =================
//   Widget _actionButtons(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//           icon: const Icon(Icons.picture_as_pdf),
//           label: const Text('Export Laporan PDF'),
//           onPressed: () {
//             // 🔹 ARAHKAN KE RESULT PAGE (PDF sudah ada di sana)
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const ResultPage(),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.redAccent,
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ElevatedButton.icon(
//           icon: const Icon(Icons.notifications),
//           label: const Text('Atur Reminder Screening'),
//           onPressed: () async {
//             // 🔹 NOTIFIKASI REMINDER (TAMBAHAN SAJA)
//             // await NotificationService.scheduleDailyReminder();
//             NotificationService.setDailyReminder(
//               time: TimeOfDay(hour: 8, minute: 0),
//             );

//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Reminder screening berhasil diaktifkan'),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';
// // 🔹 TAMBAHAN SAJA (tidak mengubah UI)
// import 'result_page.dart';
// import '../../../../core/notification_service.dart';

// // 🔹 TAMBAHAN UNTUK DATA RINGKASAN (TIDAK MERUSAK KODE LAMA)
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';


// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard InsightMind'),
//         backgroundColor: Colors.pink,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ================= KODE LAMA (TETAP ADA) =================
//             _summaryCard(),
//             const SizedBox(height: 16),

//             // ================= TAMBAHAN (TIDAK MENGGANTI) =================
//             _dynamicSummaryCard(),
//             const SizedBox(height: 16),

//             _graphPlaceholder(),
//             const SizedBox(height: 16),
//             _actionButtons(context),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= KODE LAMA (TIDAK DIUBAH) =================
//   Widget _summaryCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Hasil Screening Terakhir',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text('Skor: 7'),
//             Text(
//               'Risiko: Rendah',
//               style: TextStyle(color: Colors.green),
//             ),
//             Text('Tanggal: 15/01/2026'),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= TAMBAHAN RINGKASAN REALTIME =================
//   Widget _dynamicSummaryCard() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }

//         final prefs = snapshot.data!;
//         final data = prefs.getStringList('screening_history') ?? [];

//         if (data.isEmpty) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'Belum ada data screening.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           );
//         }

//         final last = jsonDecode(data.last) as Map<String, dynamic>;

//         return Card(
//           color: const Color(0xFFFFF0F8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Ringkasan Screening (Realtime)',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text('Total Screening: ${data.length}'),
//                 Text('Skor Terakhir: ${last['score']}'),
//                 Text('Risiko Terakhir: ${last['riskLevel']}'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _graphPlaceholder() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         height: 200,
//         child: Center(
//           child: Text(
//             'Grafik Perkembangan Skor\n(akan dihubungkan ke data)',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }

//   // ================= TAMBAHAN LOGIKA SAJA =================
//   Widget _actionButtons(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//           icon: const Icon(Icons.picture_as_pdf),
//           label: const Text('Export Laporan PDF'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const ResultPage(),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.redAccent,
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ElevatedButton.icon(
//           icon: const Icon(Icons.notifications),
//           label: const Text('Atur Reminder Screening'),
//           onPressed: () {
//             NotificationService.setDailyReminder(
//               time: TimeOfDay(hour: 8, minute: 0),
//             );

//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Reminder screening berhasil diaktifkan'),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'score_chart_detail_page.dart';
// // 🔹 TAMBAHAN SAJA (tidak mengubah UI)
// import 'result_page.dart';
// import '../../../../core/notification_service.dart';

// // 🔹 TAMBAHAN UNTUK DATA RINGKASAN (TIDAK MERUSAK KODE LAMA)
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// // 🔹 TAMBAHAN GRAFIK (AMAN)
// import 'package:fl_chart/fl_chart.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard InsightMind'),
//         backgroundColor: Colors.pink,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ================= KODE LAMA (TETAP ADA) =================
//             _summaryCard(),
//             const SizedBox(height: 16),

//             // ================= TAMBAHAN (TIDAK MENGGANTI) =================
//             _dynamicSummaryCard(),
//             const SizedBox(height: 16),

//             // ================= KODE LAMA =================
//             _graphPlaceholder(),
//             const SizedBox(height: 16),

//             // ================= TAMBAHAN GRAFIK REAL =================
//             _realScoreChart(),
//             const SizedBox(height: 16),

//             _actionButtons(context),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= KODE LAMA (TIDAK DIUBAH) =================
//   Widget _summaryCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Hasil Screening Terakhir',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text('Skor: 7'),
//             Text(
//               'Risiko: Rendah',
//               style: TextStyle(color: Colors.green),
//             ),
//             Text('Tanggal: 15/01/2026'),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= TAMBAHAN RINGKASAN REALTIME =================
//   Widget _dynamicSummaryCard() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }

//         final prefs = snapshot.data!;
//         final data = prefs.getStringList('screening_history') ?? [];

//         if (data.isEmpty) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'Belum ada data screening.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           );
//         }

//         final last = jsonDecode(data.last) as Map<String, dynamic>;

//         return Card(
//           color: const Color(0xFFFFF0F8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Ringkasan Screening (Realtime)',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text('Total Screening: ${data.length}'),
//                 Text('Skor Terakhir: ${last['score']}'),
//                 Text('Risiko Terakhir: ${last['riskLevel']}'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ================= KODE LAMA =================
//   Widget _graphPlaceholder() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         height: 200,
//         child: Center(
//           child: Text(
//             'Grafik Perkembangan Skor\n(akan dihubungkan ke data)',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }

//   // ================= TAMBAHAN GRAFIK REAL =================
//   Widget _realScoreChart() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }

//         final prefs = snapshot.data!;
//         final data = prefs.getStringList('screening_history') ?? [];

//         if (data.length < 2) {
//           return const Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               'Grafik akan muncul setelah minimal 2 kali screening',
//               style: TextStyle(color: Colors.grey),
//             ),
//           );
//         }

//         final spots = <FlSpot>[];

//         for (int i = 0; i < data.length; i++) {
//           final item = jsonDecode(data[i]) as Map<String, dynamic>;
//           final score = (item['score'] as num).toDouble();
//           spots.add(FlSpot(i.toDouble() + 1, score));
//         }

//         return Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: SizedBox(
//             height: 220,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: true),
//                   borderData: FlBorderData(show: false),
//                   titlesData: FlTitlesData(show: true),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: spots,
//                       isCurved: true,
//                       barWidth: 3,
//                       dotData: FlDotData(show: true),
//                       color: Colors.pink,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ================= TAMBAHAN LOGIKA SAJA =================
//   Widget _actionButtons(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//           icon: const Icon(Icons.picture_as_pdf),
//           label: const Text('Export Laporan PDF'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const ResultPage(),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.redAccent,
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ElevatedButton.icon(
//           icon: const Icon(Icons.notifications),
//           label: const Text('Atur Reminder Screening'),
//           onPressed: () {
//             NotificationService.setDailyReminder(
//               time: TimeOfDay(hour: 8, minute: 0),
//             );

//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Reminder screening berhasil diaktifkan'),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'score_chart_detail_page.dart';
// import 'screening_page.dart';

// // 🔹 TAMBAHAN SAJA (tidak mengubah UI)
// import 'result_page.dart';
// import '../../../../core/notification_service.dart';

// // 🔹 TAMBAHAN UNTUK DATA RINGKASAN (TIDAK MERUSAK KODE LAMA)
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// // 🔹 TAMBAHAN GRAFIK (AMAN)
// import 'package:fl_chart/fl_chart.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard InsightMind'),
//         backgroundColor: Colors.pink,

//         // ================= TAMBAHAN SAJA =================
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // kembali ke halaman screening
//           },
//         ),
//         // =================================================
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ================= KODE LAMA (TETAP ADA) =================
//             _summaryCard(),
//             const SizedBox(height: 16),

//             // ================= TAMBAHAN (TIDAK MENGGANTI) =================
//             _dynamicSummaryCard(),
//             const SizedBox(height: 16),

//             // ================= KODE LAMA =================
//             _graphPlaceholder(),
//             const SizedBox(height: 16),

//             // ================= TAMBAHAN GRAFIK REAL =================
//             _realScoreChart(),
//             const SizedBox(height: 16),

//             _actionButtons(context),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= KODE LAMA (TIDAK DIUBAH) =================
//   Widget _summaryCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Hasil Screening Terakhir',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text('Skor: 7'),
//             Text(
//               'Risiko: Rendah',
//               style: TextStyle(color: Colors.green),
//             ),
//             Text('Tanggal: 15/01/2026'),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= TAMBAHAN RINGKASAN REALTIME =================
//   Widget _dynamicSummaryCard() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }

//         final prefs = snapshot.data!;
//         final data = prefs.getStringList('screening_history') ?? [];

//         if (data.isEmpty) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'Belum ada data screening.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           );
//         }

//         final last = jsonDecode(data.last) as Map<String, dynamic>;

//         return Card(
//           color: const Color(0xFFFFF0F8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Ringkasan Screening (Realtime)',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text('Total Screening: ${data.length}'),
//                 Text('Skor Terakhir: ${last['score']}'),
//                 Text('Risiko Terakhir: ${last['riskLevel']}'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ================= KODE LAMA =================
//   Widget _graphPlaceholder() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         height: 200,
//         child: Center(
//           child: Text(
//             'Grafik Perkembangan Skor\n(akan dihubungkan ke data)',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }

//   // ================= TAMBAHAN GRAFIK REAL =================
//   Widget _realScoreChart() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }

//         final prefs = snapshot.data!;
//         final data = prefs.getStringList('screening_history') ?? [];

//         if (data.length < 2) {
//           return const Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               'Grafik akan muncul setelah minimal 2 kali screening',
//               style: TextStyle(color: Colors.grey),
//             ),
//           );
//         }

//         final spots = <FlSpot>[];

//         for (int i = 0; i < data.length; i++) {
//           final item = jsonDecode(data[i]) as Map<String, dynamic>;
//           final score = (item['score'] as num).toDouble();
//           spots.add(FlSpot(i.toDouble() + 1, score));
//         }

//         return Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: SizedBox(
//             height: 220,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: true),
//                   borderData: FlBorderData(show: false),
//                   titlesData: FlTitlesData(show: true),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: spots,
//                       isCurved: true,
//                       barWidth: 3,
//                       dotData: FlDotData(show: true),
//                       color: Colors.pink,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ================= TAMBAHAN LOGIKA SAJA =================
//   Widget _actionButtons(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//           icon: const Icon(Icons.picture_as_pdf),
//           label: const Text('Export Laporan PDF'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const ResultPage(),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.redAccent,
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ElevatedButton.icon(
//           icon: const Icon(Icons.notifications),
//           label: const Text('Atur Reminder Screening'),
//           onPressed: () {
//             NotificationService.setDailyReminder(
//               time: TimeOfDay(hour: 8, minute: 0),
//             );

//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Reminder screening berhasil diaktifkan'),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),

//         // ================= TAMBAHAN TOMBOL SCREENING =================
//         const SizedBox(height: 8),
//         ElevatedButton.icon(
//           icon: const Icon(Icons.play_arrow),
//           label: const Text('Mulai Screening'),
//           onPressed: () {
//             Navigator.pop(context); // kembali ke halaman screening
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.pink,
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//         // =============================================================
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'score_chart_detail_page.dart';
// import 'screening_page.dart';

// // 🔹 TAMBAHAN SAJA (tidak mengubah UI)
// import 'result_page.dart';
// import '../../../../core/notification_service.dart';

// // 🔹 TAMBAHAN UNTUK DATA RINGKASAN (TIDAK MERUSAK KODE LAMA)
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// // 🔹 TAMBAHAN GRAFIK (AMAN)
// import 'package:fl_chart/fl_chart.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard InsightMind'),
//         backgroundColor: Colors.pink,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),

//       // ================= TOMBOL MULAI SCREENING (PASTI TERLIHAT) =================
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: Colors.pink,
//         icon: const Icon(Icons.play_arrow),
//         label: const Text('Mulai Screening'),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const ScreeningPage(),
//             ),
//           );
//         },
//       ),
//       // ========================================================================

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _summaryCard(),
//             const SizedBox(height: 16),

//             _dynamicSummaryCard(),
//             const SizedBox(height: 16),

//             _graphPlaceholder(),
//             const SizedBox(height: 16),

//             _realScoreChart(),
//             const SizedBox(height: 16),

//             _actionButtons(context),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= KODE LAMA =================
//   Widget _summaryCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Hasil Screening Terakhir',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text('Skor: 7'),
//             Text(
//               'Risiko: Rendah',
//               style: TextStyle(color: Colors.green),
//             ),
//             Text('Tanggal: 15/01/2026'),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= RINGKASAN REALTIME =================
//   Widget _dynamicSummaryCard() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }

//         final prefs = snapshot.data!;
//         final data = prefs.getStringList('screening_history') ?? [];

//         if (data.isEmpty) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'Belum ada data screening.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           );
//         }

//         final last = jsonDecode(data.last) as Map<String, dynamic>;

//         return Card(
//           color: const Color(0xFFFFF0F8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Ringkasan Screening (Realtime)',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text('Total Screening: ${data.length}'),
//                 Text('Skor Terakhir: ${last['score']}'),
//                 Text('Risiko Terakhir: ${last['riskLevel']}'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ================= KODE LAMA =================
//   Widget _graphPlaceholder() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         height: 200,
//         child: Center(
//           child: Text(
//             'Grafik Perkembangan Skor\n(akan dihubungkan ke data)',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }

//   // ================= GRAFIK REAL =================
//   Widget _realScoreChart() {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }

//         final prefs = snapshot.data!;
//         final data = prefs.getStringList('screening_history') ?? [];

//         if (data.length < 2) {
//           return const Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               'Grafik akan muncul setelah minimal 2 kali screening',
//               style: TextStyle(color: Colors.grey),
//             ),
//           );
//         }

//         final spots = <FlSpot>[];

//         for (int i = 0; i < data.length; i++) {
//           final item = jsonDecode(data[i]) as Map<String, dynamic>;
//           final score = (item['score'] as num).toDouble();
//           spots.add(FlSpot(i.toDouble() + 1, score));
//         }

//         return Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: SizedBox(
//             height: 220,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: true),
//                   borderData: FlBorderData(show: false),
//                   titlesData: FlTitlesData(show: true),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: spots,
//                       isCurved: true,
//                       barWidth: 3,
//                       dotData: FlDotData(show: true),
//                       color: Colors.pink,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ================= TOMBOL AKSI =================
//   Widget _actionButtons(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton.icon(
//           icon: const Icon(Icons.picture_as_pdf),
//           label: const Text('Export Laporan PDF'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const ResultPage(),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.redAccent,
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ElevatedButton.icon(
//           icon: const Icon(Icons.notifications),
//           label: const Text('Atur Reminder Screening'),
//           onPressed: () {
//             NotificationService.setDailyReminder(
//               time: TimeOfDay(hour: 8, minute: 0),
//             );

//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Reminder screening berhasil diaktifkan'),
//               ),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(48),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'score_chart_detail_page.dart';
import 'screening_page.dart';
import 'result_page.dart';
import '../../../../core/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard InsightMind'),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= MULAI SCREENING (FIX & PASTI MUNCUL) =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  'Mulai Screening',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ScreeningPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ======================================================================

            _summaryCard(),
            const SizedBox(height: 16),

            _dynamicSummaryCard(),
            const SizedBox(height: 16),

            _graphPlaceholder(),
            const SizedBox(height: 16),

            _realScoreChart(),
            const SizedBox(height: 16),

            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  // ================= KODE LAMA =================
  Widget _summaryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hasil Screening Terakhir',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('Skor: 7'),
            Text(
              'Risiko: Rendah',
              style: TextStyle(color: Colors.green),
            ),
            Text('Tanggal: 15/01/2026'),
          ],
        ),
      ),
    );
  }

  // ================= RINGKASAN REALTIME =================
  Widget _dynamicSummaryCard() {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final prefs = snapshot.data!;
        final data = prefs.getStringList('screening_history') ?? [];

        if (data.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Belum ada data screening.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        final last = jsonDecode(data.last) as Map<String, dynamic>;

        return Card(
          color: const Color(0xFFFFF0F8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ringkasan Screening (Realtime)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Total Screening: ${data.length}'),
                Text('Skor Terakhir: ${last['score']}'),
                Text('Risiko Terakhir: ${last['riskLevel']}'),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= KODE LAMA =================
  Widget _graphPlaceholder() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'Grafik Perkembangan Skor\n(akan dihubungkan ke data)',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // ================= GRAFIK REAL =================
  Widget _realScoreChart() {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final prefs = snapshot.data!;
        final data = prefs.getStringList('screening_history') ?? [];

        if (data.length < 2) {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Grafik akan muncul setelah minimal 2 kali screening',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        final spots = <FlSpot>[];

        for (int i = 0; i < data.length; i++) {
          final item = jsonDecode(data[i]) as Map<String, dynamic>;
          spots.add(FlSpot(i.toDouble() + 1, (item['score'] as num).toDouble()));
        }

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      color: Colors.pink,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= TOMBOL AKSI =================
  Widget _actionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('Export Laporan PDF'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ResultPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.notifications),
          label: const Text('Atur Reminder Screening'),
          onPressed: () {
            NotificationService.setDailyReminder(
              time: const TimeOfDay(hour: 8, minute: 0),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Reminder screening berhasil diaktifkan'),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
      ],
    );
  }
}
