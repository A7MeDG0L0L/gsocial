class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
 late String image;
late  String cover;
  String? bio;

  SocialUserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
    required this.cover,
    required this.image,
    required this.bio,
  });

  SocialUserModel.fromJson(Map<String, dynamic>? json)
  {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    cover = json['cover'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'isEmailVerified':isEmailVerified,
      'bio':bio,
      'image':image,
      'cover':cover,
      'uId':uId,
    };
  }
}