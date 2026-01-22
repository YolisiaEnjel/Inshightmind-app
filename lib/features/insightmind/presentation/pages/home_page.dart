// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'screening_page.dart';

// class HomePage extends ConsumerWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final answers = ref.watch(answersProvider);

//     return Scaffold(
//       extendBodyBehindAppBar: true, // biar warna full sampai ke status bar
//       appBar: AppBar(
//         title: const Text(
//           'InsightMind',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color.fromRGBO(241, 67, 198, 1),
//               Color(0xFFF9F9F9), // transisi ke putih lembut di bawah
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Kartu sambutan
//                 Card(
//                   color: const Color(0xFFFFF0F8),
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         const Icon(Icons.psychology_alt,
//                             color: Color.fromRGBO(241, 67, 198, 1), size: 50),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Selamat Datang di InsightMind',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Mulai screening sederhana untuk memprediksi risiko kesehatan mental Anda secara cepat dan mudah.',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromRGBO(241, 67, 198, 1),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 24, vertical: 12),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => const ScreeningPage()),
//                             );
//                           },
//                           child: const Text(
//                             'Mulai Screening',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // Kartu riwayat simulasi
//                 Card(
//                   color: const Color(0xFFFFF0F8),
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         const Text(
//                           'Riwayat Simulasi Minggu 2',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Wrap(
//                           spacing: 8,
//                           children: [
//                             for (int i = 0; i < answers.length; i++)
//                               Chip(label: Text('${answers[i]}')),
//                             if (answers.isEmpty)
//                               const Chip(label: Text('0')),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),

//       // Tombol +
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         onPressed: () {
//           final newValue = DateTime.now().millisecondsSinceEpoch % 4;
//           final current = [...ref.read(answersProvider)];
//           current.add(newValue);
//           ref.read(answersProvider.notifier).state = current;
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'screening_page.dart';
// import 'dashboard_page.dart'; // ✅ TAMBAHAN SAJA

// class HomePage extends ConsumerWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final answers = ref.watch(answersProvider);

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text(
//           'InsightMind',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color.fromRGBO(241, 67, 198, 1),
//               Color(0xFFF9F9F9),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // ================= KARTU SAMBUTAN =================
//                 Card(
//                   color: const Color(0xFFFFF0F8),
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         const Icon(Icons.psychology_alt,
//                             color: Color.fromRGBO(241, 67, 198, 1), size: 50),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Selamat Datang di InsightMind',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Mulai screening sederhana untuk memprediksi risiko kesehatan mental Anda secara cepat dan mudah.',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         const SizedBox(height: 16),

//                         // 🔹 TOMBOL SCREENING (ASLI)
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromRGBO(241, 67, 198, 1),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 24, vertical: 12),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => const ScreeningPage()),
//                             );
//                           },
//                           child: const Text(
//                             'Mulai Screening',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         // ✅ TOMBOL DASHBOARD (TAMBAHAN AMAN)
//                         OutlinedButton.icon(
//                           icon: const Icon(Icons.dashboard),
//                           label: const Text('Buka Dashboard'),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => const DashboardPage()),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 // ================= RIWAYAT SIMULASI =================
//                 Card(
//                   color: const Color(0xFFFFF0F8),
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         const Text(
//                           'Riwayat Simulasi Minggu 2',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Wrap(
//                           spacing: 8,
//                           children: [
//                             for (int i = 0; i < answers.length; i++)
//                               Chip(label: Text('${answers[i]}')),
//                             if (answers.isEmpty)
//                               const Chip(label: Text('0')),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),

//       // ================= FLOATING BUTTON (ASLI) =================
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         onPressed: () {
//           final newValue = DateTime.now().millisecondsSinceEpoch % 4;
//           final current = [...ref.read(answersProvider)];
//           current.add(newValue);
//           ref.read(answersProvider.notifier).state = current;
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../pages/result_page.dart';


// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   int totalScreening = 0;
//   String lastRisk = '-';
//   double lastScore = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadSummary();
//   }

//   Future<void> _loadSummary() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList('screening_history') ?? [];

//     if (data.isNotEmpty) {
//       final last =
//           jsonDecode(data.last) as Map<String, dynamic>;

//       setState(() {
//         totalScreening = data.length;
//         lastRisk = last['riskLevel'];
//         lastScore = (last['score'] as num).toDouble();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Dashboard',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ================= RINGKASAN =================
//             Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Ringkasan Screening',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text('• Total Screening: $totalScreening'),
//                     Text('• Risiko Terakhir: $lastRisk'),
//                     Text('• Skor Terakhir: $lastScore'),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),

//             // ================= MENU =================
//             const Text(
//               'Fitur Dashboard',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 12),

//             _DashboardMenu(
//               icon: Icons.history,
//               title: 'Riwayat Screening',
//               subtitle: 'Lihat detail hasil screening sebelumnya',
//               onTap: () {},
//             ),

//             _DashboardMenu(
//               icon: Icons.show_chart,
//               title: 'Grafik Perkembangan',
//               subtitle: 'Pantau perubahan skor dari waktu ke waktu',
//               onTap: () {},
//             ),

//             _DashboardMenu(
//               icon: Icons.picture_as_pdf,
//               title: 'Laporan PDF',
//               subtitle: 'Unduh laporan screening dalam bentuk PDF',
//               onTap: () {},
//             ),

//             _DashboardMenu(
//               icon: Icons.notifications_active,
//               title: 'Reminder Screening',
//               subtitle: 'Atur pengingat screening berkala',
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ================= MENU ITEM =================
// class _DashboardMenu extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;

//   const _DashboardMenu({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: ListTile(
//         leading: Icon(
//           icon,
//           color: const Color.fromRGBO(241, 67, 198, 1),
//         ),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.chevron_right),
//         onTap: onTap,
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/result_page.dart';
import '../pages/screening_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int totalScreening = 0;
  String lastRisk = '-';
  double lastScore = 0;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('screening_history') ?? [];

    if (data.isNotEmpty) {
      final last = jsonDecode(data.last) as Map<String, dynamic>;

      setState(() {
        totalScreening = data.length;
        lastRisk = last['riskLevel'];
        lastScore = (last['score'] as num).toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= RINGKASAN =================
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan Screening',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('• Total Screening: $totalScreening'),
                    Text('• Risiko Terakhir: $lastRisk'),
                    Text('• Skor Terakhir: $lastScore'),
                  ],
                ),
              ),
            ),

            // ================= TOMBOL MULAI SCREENING (FINAL) =================
            const SizedBox(height: 16),
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
                  backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            // =================================================================

            const SizedBox(height: 24),

            // ================= MENU =================
            const Text(
              'Fitur Dashboard',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _DashboardMenu(
              icon: Icons.history,
              title: 'Riwayat Screening',
              subtitle: 'Lihat detail hasil screening sebelumnya',
              onTap: () {},
            ),

            _DashboardMenu(
              icon: Icons.show_chart,
              title: 'Grafik Perkembangan',
              subtitle: 'Pantau perubahan skor dari waktu ke waktu',
              onTap: () {},
            ),

            _DashboardMenu(
              icon: Icons.picture_as_pdf,
              title: 'Laporan PDF',
              subtitle: 'Unduh laporan screening dalam bentuk PDF',
              onTap: () {},
            ),

            _DashboardMenu(
              icon: Icons.notifications_active,
              title: 'Reminder Screening',
              subtitle: 'Atur pengingat screening berkala',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// ================= MENU ITEM =================
class _DashboardMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DashboardMenu({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromRGBO(241, 67, 198, 1),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
