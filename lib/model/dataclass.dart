class Chapter {
  final String id;
  final String name;
  final List<Lesson> lessons;

  Chapter({required this.id, required this.name, required this.lessons});
}

class Lesson {
  final String id;
  final String meaning;
  final String videoUrl;

  Lesson({required this.id, required this.meaning, required this.videoUrl});
}