import '../constant.dart';

class Message {
  final String message;
  final String id;
  Message({
    required this.message,
    required this.id,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map[kMessage],
      id: map['id'],
    );
  }
}
