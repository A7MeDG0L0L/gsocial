class MessageModel {
  String? senderID;
  String? receiverID;
  String? dateTime;
  String? text;



  MessageModel({

    required this.text,
    required this.dateTime,
required this.senderID,
    required this.receiverID,
  });

  MessageModel.fromJson(Map<String, dynamic>? json)
  {
    text = json!['text'];
    dateTime = json['dateTime'];
    senderID = json['senderID'];
    receiverID = json['receiverID'];
  }

  Map<String, dynamic> toMap()
  {
    return {

      'dateTime':dateTime,
      'text':text,
      'senderID':senderID,
      'receiverID':receiverID,
    };
  }
}