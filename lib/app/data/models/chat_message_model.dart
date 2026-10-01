class ChatMessageModel {
  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.sentAt,
    required this.isMine,
    this.isRead = false,
  });

  final String id;
  final String text;
  final DateTime sentAt;
  final bool isMine;
  final bool isRead;

  // Demo data. Replace with API / socket stream later.
  static List<ChatMessageModel> samples() {
    final now = DateTime.now();
    DateTime at(int h, int m) => DateTime(now.year, now.month, now.day, h, m);
    return [
      ChatMessageModel(
        id: 'm1',
        text: "Hi! I'm interested in this property. Is it still available?",
        sentAt: at(10, 10),
        isMine: true,
        isRead: true,
      ),
      ChatMessageModel(
        id: 'm2',
        text: 'Yes, it\'s available. Would you like to schedule a site visit?',
        sentAt: at(10, 12),
        isMine: false,
      ),
      ChatMessageModel(
        id: 'm3',
        text: 'Yes, please. Can we plan a visit this weekend?',
        sentAt: at(10, 14),
        isMine: true,
        isRead: true,
      ),
      ChatMessageModel(
        id: 'm4',
        text: 'Sure. How about Saturday, 11 AM?',
        sentAt: at(10, 15),
        isMine: false,
      ),
    ];
  }
}
