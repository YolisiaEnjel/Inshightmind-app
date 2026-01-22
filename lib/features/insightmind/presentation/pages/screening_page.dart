
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/questionnaire_provider.dart';
import '../../domain/entities/question.dart';
import '../providers/score_provider.dart';
import 'result_page.dart';
import 'screening_detail_page.dart';


class ScreeningPage extends ConsumerWidget {
  const ScreeningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionnaireProvider);
    final questions = ref.watch(questionsProvider);

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text('Screening InsightMind'),
        backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
        foregroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final q = questions[index];
          final selectedScore = state.answers[q.id];

          return QuestionTile(
            question: q,
            selectedScore: selectedScore,
            onSelected: (score) {
              ref
                  .read(questionnaireProvider.notifier)
                  .selectAnswer(questionId: q.id, score: score);
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Tombol Lihat Hasil
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                label: const Text(
                  'Lihat Hasil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  if (!state.isComplete) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lengkapi semua pertanyaan terlebih dahulu...'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  final answersOrdered = <int>[];
                  for (final q in questions) {
                    answersOrdered.add(state.answers[q.id]!);
                  }
                  ref.read(answersProvider.notifier).state = answersOrdered;

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ResultPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),

            // 🔁 Tombol Reset Jawaban (ikon + teks)
            TextButton.icon(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Text(
                      'Konfirmasi Reset',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    content: const Text(
                      'Apakah Anda yakin ingin menghapus semua jawaban?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Batal'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
                          foregroundColor: const Color.fromARGB(255, 12, 11, 11),
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Ya, Reset'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  ref.read(questionnaireProvider.notifier).resetAnswers();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Jawaban telah direset.'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.refresh,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
              label: const Text(
                'Reset Jawaban',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
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

class QuestionTile extends StatelessWidget {
  final Question question;
  final int? selectedScore;
  final void Function(int score) onSelected;

  const QuestionTile({
    super.key,
    required this.question,
    required this.selectedScore,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shadowColor: Colors.indigo.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟣 Pertanyaan
            Text(
              question.text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.indigo.shade900,
              ),
            ),
            const SizedBox(height: 8),

            // 🔹 Opsi Jawaban
            Column(
              children: [
                for (final opt in question.options)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: selectedScore == opt.score
                          ? Colors.indigo.shade100
                          : Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedScore == opt.score
                            ? Colors.indigo
                            : Colors.indigo.shade200,
                      ),
                    ),
                    child: RadioListTile<int>(
                      title: Text(
                        opt.label,
                        style: TextStyle(
                          color: selectedScore == opt.score
                              ? Colors.indigo.shade900
                              : Colors.black87,
                        ),
                      ),
                      value: opt.score,
                      groupValue: selectedScore,
                      activeColor: const Color.fromRGBO(241, 67, 198, 1),
                      onChanged: (value) {
                        if (value != null) {
                          onSelected(value);
                        }
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// import '../providers/questionnaire_provider.dart';
// import '../../domain/entities/question.dart';
// import '../providers/score_provider.dart';
// import 'result_page.dart';

// class ScreeningPage extends ConsumerWidget {
//   const ScreeningPage({super.key});

//   // 🧠 Simpan hasil screening ke local storage
//   Future<void> saveScreeningResult(double score) async {
//     final prefs = await SharedPreferences.getInstance();
//     final history = prefs.getStringList('screening_history') ?? [];

//     final newEntry = jsonEncode({
//       'date': DateTime.now().toIso8601String(),
//       'score': score,
//     });

//     history.add(newEntry);
//     await prefs.setStringList('screening_history', history);
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(questionnaireProvider);
//     final questions = ref.watch(questionsProvider);

//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text('Screening InsightMind'),
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         foregroundColor: Colors.white,
//         elevation: 3,
//         centerTitle: true,
//       ),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: questions.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 16),
//         itemBuilder: (context, index) {
//           final q = questions[index];
//           final selectedScore = state.answers[q.id];

//           return QuestionTile(
//             question: q,
//             selectedScore: selectedScore,
//             onSelected: (score) {
//               ref
//                   .read(questionnaireProvider.notifier)
//                   .selectAnswer(questionId: q.id, score: score);
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: SafeArea(
//         minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // 🔹 Tombol Lihat Hasil
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.check_circle_outline, color: Colors.white),
//                 label: const Text(
//                   'Lihat Hasil',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 4,
//                 ),
//                 onPressed: () async {
//                   if (!state.isComplete) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Lengkapi semua pertanyaan terlebih dahulu...'),
//                         behavior: SnackBarBehavior.floating,
//                       ),
//                     );
//                     return;
//                   }

//                   final answersOrdered = <int>[];
//                   for (final q in questions) {
//                     answersOrdered.add(state.answers[q.id]!);
//                   }
//                   ref.read(answersProvider.notifier).state = answersOrdered;

//                   // 🔹 Simpan hasil ke riwayat
//                   await saveScreeningResult(state.totalScore.toDouble());

//                   // 🔹 Navigasi ke halaman hasil
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (_) => const ResultPage()),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 8),

//             // 🔁 Tombol Reset Jawaban
//             TextButton.icon(
//               onPressed: () async {
//                 final confirm = await showDialog<bool>(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     title: const Text(
//                       'Konfirmasi Reset',
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     content: const Text(
//                       'Apakah Anda yakin ingin menghapus semua jawaban?',
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.of(context).pop(false),
//                         child: const Text('Batal'),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//                           foregroundColor: Colors.white,
//                         ),
//                         onPressed: () => Navigator.of(context).pop(true),
//                         child: const Text('Ya, Reset'),
//                       ),
//                     ],
//                   ),
//                 );

//                 if (confirm == true) {
//                   ref.read(questionnaireProvider.notifier).reset();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Jawaban telah direset.'),
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                 }
//               },
//               icon: const Icon(Icons.refresh, color: Colors.black),
//               label: const Text(
//                 'Reset Jawaban',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),

//             // 🕓 Tombol ke Riwayat Hasil
//             TextButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const HistoryScreen()),
//                 );
//               },
//               icon: const Icon(Icons.history, color: Colors.black87),
//               label: const Text(
//                 'Lihat Riwayat Hasil',
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuestionTile extends StatelessWidget {
//   final Question question;
//   final int? selectedScore;
//   final void Function(int score) onSelected;

//   const QuestionTile({
//     super.key,
//     required this.question,
//     required this.selectedScore,
//     required this.onSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       color: Colors.white,
//       shadowColor: Colors.indigo.shade100,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               question.text,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.indigo.shade900,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Column(
//               children: [
//                 for (final opt in question.options)
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     decoration: BoxDecoration(
//                       color: selectedScore == opt.score
//                           ? Colors.indigo.shade100
//                           : Colors.indigo.shade50,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: selectedScore == opt.score
//                             ? Colors.indigo
//                             : Colors.indigo.shade200,
//                       ),
//                     ),
//                     child: RadioListTile<int>(
//                       title: Text(
//                         opt.label,
//                         style: TextStyle(
//                           color: selectedScore == opt.score
//                               ? Colors.indigo.shade900
//                               : Colors.black87,
//                         ),
//                       ),
//                       value: opt.score,
//                       groupValue: selectedScore,
//                       activeColor: const Color.fromRGBO(241, 67, 198, 1),
//                       onChanged: (value) {
//                         if (value != null) onSelected(value);
//                       },
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});

//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen> {
//   List<Map<String, dynamic>> _history = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final stored = prefs.getStringList('screening_history') ?? [];

//     setState(() {
//       _history =
//           stored.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
//       _history.sort(
//           (a, b) => DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Riwayat Hasil Screening"),
//         backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
//         centerTitle: true,
//         foregroundColor: Colors.white,
//       ),
//       body: _history.isEmpty
//           ? const Center(child: Text("Belum ada hasil screening."))
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: _history.length,
//               itemBuilder: (context, index) {
//                 final item = _history[index];
//                 final date = DateTime.parse(item['date']);
//                 final formattedDate =
//                     "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
//                 final score = item['score'];

//                 return Card(
//                   color: Colors.pink.shade50,
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: ListTile(
//                     leading: const Icon(Icons.analytics, color: Colors.pink),
//                     title: Text(
//                       "Skor: $score",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text("Tanggal: $formattedDate"),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
