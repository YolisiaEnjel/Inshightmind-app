// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/score_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';


// class ResultPage extends ConsumerWidget {
//   const ResultPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final result = ref.watch(resultProvider);

//     String recommendation;
//     Color riskColor;

//     // 🎯 Warna sesuai tingkat risiko
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

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50, // lembut seperti halaman lainnya
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
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Card(
//             elevation: 5,
//             shadowColor: Colors.pink.shade100,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             color: Colors.white,
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(
//                     Icons.lightbulb_outline_rounded,
//                     size: 60,
//                     color: Color.fromRGBO(241, 67, 198, 1),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Skor Anda: ${result.score}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Tingkat Risiko: ${result.riskLevel}',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: riskColor,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     recommendation,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.black87,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 28),
//                   ElevatedButton.icon(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.arrow_back_rounded),
//                     label: const Text(
//                       'Kembali',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 24, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
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
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('screening_history') ?? [];
    setState(() {
      history = data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    });
  }

  Future<void> _saveResult(String riskLevel, double score) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('screening_history') ?? [];

    final newResult = {
      'date': DateTime.now().toIso8601String(),
      'riskLevel': riskLevel,
      'score': score,
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

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(resultProvider);

    String recommendation;
    Color riskColor;

    switch (result.riskLevel) {
      case 'Tinggi':
        recommendation =
            'Disarankan untuk segera mencari dukungan, baik melalui konselor kampus, psikolog, atau teman terpercaya.';
        riskColor = Colors.red;
        break;
      case 'Sedang':
        recommendation =
            'Luangkan waktu untuk istirahat, berbicara dengan teman, atau melakukan aktivitas yang menenangkan pikiran.';
        riskColor = Colors.orange;
        break;
      default:
        recommendation =
            'Pertahankan kebiasaan baik. Jaga tidur, makan, dan olahraga.';
        riskColor = Colors.green;
    }

    // Simpan hasil setelah halaman dibuka pertama kali
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveResult(result.riskLevel, result.score.toDouble());
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
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔹 Kartu Hasil Utama
            Card(
              elevation: 5,
              shadowColor: Colors.pink.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 60,
                      color: Color.fromRGBO(241, 67, 198, 1),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Skor Anda: ${result.score}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tingkat Risiko: ${result.riskLevel}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: riskColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      recommendation,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text(
                        'Kembali',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 🔹 Riwayat Screening
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Riwayat Screening Sebelumnya',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 12),

            if (history.isEmpty)
              const Text(
                'Belum ada riwayat screening.',
                style: TextStyle(color: Colors.grey),
              )
            else
              ...history.reversed.map((item) {
                final date = DateTime.parse(item['date']);
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.history,
                        color: Color.fromRGBO(241, 67, 198, 1)),
                    title: Text('Risiko: ${item['riskLevel']}'),
                    subtitle: Text(
                      'Skor: ${item['score']} • ${date.day}/${date.month}/${date.year} '
                      '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                    ),
                  ),
                );
              }),

            const SizedBox(height: 12),

            if (history.isNotEmpty)
              TextButton.icon(
                onPressed: _clearHistory,
                icon: const Icon(Icons.delete_outline, color: Colors.black54),
                label: const Text(
                  'Hapus Riwayat',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
