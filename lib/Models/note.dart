class Note {
  final int id;
  final String content;
  final String? imageUrl;

  Note({required this.id, required this.content, this.imageUrl});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      imageUrl: map['image_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'content': content, 'image_url': imageUrl};
  }
}
