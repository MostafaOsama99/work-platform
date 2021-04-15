class Message {
  final bool isMe;
  final String message;
  final String senderName;
  final DateTime dateTime;

  Message({this.dateTime, this.isMe = false, this.message, this.senderName});

  String get time {
    return '${dateTime.hour <= 12 ? dateTime.hour : dateTime.hour % 12}:${dateTime.minute} ${dateTime.hour <= 12 ? 'AM' : 'PM'}';
  }
}
