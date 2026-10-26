class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.date,
    required this.readCount,
  });

  final int id;
  final String title;
  final String content;
  final String author;
  final String category;
  final String date;
  final int readCount;

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? 'Tanpa Judul',
      content: json['content'] as String? ?? json['body'] as String? ?? '',
      author: json['author'] as String? ?? 'Admin Jurusan',
      category: json['category'] as String? ?? 'Akademik',
      date: json['date'] as String? ?? '2026-09-01',
      readCount: json['readCount'] is int ? json['readCount'] as int : 0,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'content': content,
    'author': author,
    'category': category,
    'date': date,
    'readCount': readCount,
  };

  static List<Announcement> getSampleAnnouncements() {
    return const <Announcement>[
      Announcement(
        id: 1,
        title: 'Jadwal UTS Semester Ganjil 2026/2027',
        content: 'Ujian Tengah Semester akan dilaksanakan pada 15–20 September 2026.',
        author: 'Bagian Akademik Poliwangi',
        category: 'Akademik',
        date: '2026-09-01',
        readCount: 245,
      ),
      Announcement(
        id: 5,
        title: 'Pengisian KRS Online Semester Ganjil',
        content: 'Pengisian KRS online dibuka 1–10 September 2026 melalui SIAKAD.',
        author: 'Bagian Akademik Poliwangi',
        category: 'Akademik',
        date: '2026-09-01',
        readCount: 389,
      ),
    ];
  }
}