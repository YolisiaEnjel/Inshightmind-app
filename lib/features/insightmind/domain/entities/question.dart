class AnswerOption {
  final String label; // contoh: "Tidak Pernah", "Beberapa Hari", dll
  final int score; // contoh: 0, 1, 2, 3

  const AnswerOption({required this.label, required this.score});
}

class Question {
  final String id;
  final String text;
  final List<AnswerOption> options;

  const Question({
    required this.id,
    required this.text,
    required this.options,
  });
}

/// 9 pertanyaan screening (gaya PHQ/DASS)
const defaultQuestions = <Question>[
  Question(
    id: 'q1',
    text: 'Seberapa sering anda merasa tertekan dengan tugas atau tuntutan kuliah?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q2',
    text: 'Apakah anda merasa cemas saat bersosialilasi di kelas?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q3',
    text: 'Apakah anda sering merasa terisolir dikelas?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q4',
    text: 'Apakah anda merasa terbebani oleh ekspektasi orang lain terhadap prestasi Anda?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q5',
    text: 'Apakah anda sering merasa tidak yakin terhadap kemampuan diri sendiri?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q6',
    text: 'Seberapa sering anda merasa kelelahan secara mental setelah kuliah atau belajar?',
    options: [
      AnswerOption(label: 'Tidak pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap hari', score: 3),
    ],
  ),
  Question(
    id: 'q7',
    text: 'Sesering apa anda merasa tekanan dari lingkungan kampus terlalu berat untuk ditangani?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q8',
    text: 'Seberapa sering anda merasa cemas tentang masa depan setelah lulus kuliah?',
    options: [
      AnswerOption(label: 'Tidak pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q9',
    text: 'Seberapa sering anda menunda tugas karena merasa lelah secara mental?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Kadang-kadang', score: 1),
      AnswerOption(label: 'Sering', score: 2),
      AnswerOption(label: 'Setiap Hari', score: 3),
    ],
  ),
];


