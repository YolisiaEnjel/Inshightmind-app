import '../entities/recommendation.dart';

class GetRecommendation {
  Recommendation execute(String riskLevel) {
    switch (riskLevel) {
      case 'Rendah':
        return Recommendation(
          riskLevel: riskLevel,
          message:
              'Kondisi kesehatan mental Anda berada pada tingkat risiko rendah. '
              'Tetap pertahankan pola hidup sehat, istirahat yang cukup, dan lakukan aktivitas positif secara rutin.',
        );

      case 'Sedang':
        return Recommendation(
          riskLevel: riskLevel,
          message:
              'Hasil skrining menunjukkan tingkat risiko sedang. '
              'Disarankan untuk mulai memperhatikan kondisi emosional, mengelola stres dengan baik, '
              'serta berbagi cerita dengan orang terpercaya.',
        );

      case 'Tinggi':
        return Recommendation(
          riskLevel: riskLevel,
          message:
              'Hasil skrining menunjukkan tingkat risiko tinggi. '
              'Sangat disarankan untuk mencari bantuan profesional seperti psikolog atau konselor.',
        );

      default:
        return Recommendation(
          riskLevel: riskLevel,
          message:
              'Rekomendasi belum tersedia. Silakan lakukan skrining kembali.',
        );
    }
  }
}
