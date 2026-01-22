import 'package:flutter/material.dart';

class ScreeningDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ScreeningDetailPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screening'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard(),
            const SizedBox(height: 16),
            _recommendationCard(),
          ],
        ),
      ),
    );
  }

  Widget _infoCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Screening',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text('Skor: ${data['score']}'),
            Text('Risiko: ${data['riskLevel']}'),
            Text('Tanggal: ${data['date'] ?? '-'}'),
          ],
        ),
      ),
    );
  }

  Widget _recommendationCard() {
    return Card(
      color: const Color(0xFFE8F5E9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Rekomendasi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '• Lakukan screening rutin\n'
              '• Jaga pola tidur dan aktivitas\n'
              '• Konsultasi jika skor meningkat',
            ),
          ],
        ),
      ),
    );
  }
}
