class Note {
  final String? id;
  final String title;
  final String content;
  final List<String> imageUrls;
  final String? audioUrl;
  final int colorIndex;
  final bool isPinned;
  final DateTime createdAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrls = const [],
    this.audioUrl,
    required this.colorIndex,
    this.isPinned = false,
    required this.createdAt,
  });
}