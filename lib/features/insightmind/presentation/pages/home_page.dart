import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/score_provider.dart';
import 'screening_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(answersProvider);

    return Scaffold(
      extendBodyBehindAppBar: true, // biar warna full sampai ke status bar
      appBar: AppBar(
        title: const Text(
          'InsightMind',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(241, 67, 198, 1),
              Color(0xFFF9F9F9), // transisi ke putih lembut di bawah
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Kartu sambutan
                Card(
                  color: const Color(0xFFFFF0F8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(Icons.psychology_alt,
                            color: Color.fromRGBO(241, 67, 198, 1), size: 50),
                        const SizedBox(height: 8),
                        const Text(
                          'Selamat Datang di InsightMind',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Mulai screening sederhana untuk memprediksi risiko kesehatan mental Anda secara cepat dan mudah.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(241, 67, 198, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ScreeningPage()),
                            );
                          },
                          child: const Text(
                            'Mulai Screening',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Kartu riwayat simulasi
                Card(
                  color: const Color(0xFFFFF0F8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'Riwayat Simulasi Minggu 2',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (int i = 0; i < answers.length; i++)
                              Chip(label: Text('${answers[i]}')),
                            if (answers.isEmpty)
                              const Chip(label: Text('0')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Tombol +
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
        foregroundColor: Colors.white,
        onPressed: () {
          final newValue = DateTime.now().millisecondsSinceEpoch % 4;
          final current = [...ref.read(answersProvider)];
          current.add(newValue);
          ref.read(answersProvider.notifier).state = current;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

