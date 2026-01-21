import 'package:flutter/material.dart';

class HistoryDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const HistoryDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(data['date']);

    Color riskColor;
    switch (data['riskLevel']) {
      case 'Tinggi':
        riskColor = Colors.red;
        break;
      case 'Sedang':
        riskColor = Colors.orange;
        break;
      default:
        riskColor = Colors.green;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Screening',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(241, 67, 198, 1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanggal',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                Text(
                  '${date.day}/${date.month}/${date.year} '
                  '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                ),
                const SizedBox(height: 16),

                Text(
                  'Skor',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                Text('${data['score']}'),
                const SizedBox(height: 16),

                Text(
                  'Tingkat Risiko',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                Text(
                  data['riskLevel'],
                  style: TextStyle(
                      color: riskColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                Text(
                  'Rekomendasi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                Text(data['recommendation'] ?? '-'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
