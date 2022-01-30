class PostModel {
  String? name;
  String? uId;
  late String image;
  String? dateTime;
  String? text;
  String? postImage;
  List<String>? comments;

  PostModel({
    required this.name,
    required this.uId,
    required this.text,
    required this.postImage,
    required this.dateTime,
    required this.image,

  });

  PostModel.fromJson(Map<String, dynamic>? json)
  {
    name = json!['name'];
    uId = json['uId'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
  comments = json['comments'];
    image = json['image'];}

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
      'comments':comments,
    };
  }
}