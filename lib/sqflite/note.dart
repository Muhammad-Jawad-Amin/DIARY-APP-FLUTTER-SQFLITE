class Note {
  int? id;
  String title;
  String description;
  DateTime createdAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt.toString(),
    };
  }
}
