import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_states.dart';
import 'package:gsocial/data/models/message_model.dart';
import 'package:gsocial/data/models/post_model.dart';
import 'package:gsocial/data/models/user_model.dart';
import 'package:gsocial/shared/cache_helper/cache_helper.dart';
import 'package:gsocial/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(InitialSettingsState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;
  void getUserData() {
    print('-----------Getting User Data...-----------');
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      model = SocialUserModel.fromJson(value.data());
      emit(GetUserDataSuccessSettingsState(model!));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorSettingsState(error.toString()));
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    CacheHelper.removeData(key: 'uid');
    print(uid);
    emit(SignOutSettingsState());
  }

  var picker = ImagePicker();
  File? profileImage;

  // XFile? xProfileImage;

  Future getProfileImage() async {
    try {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 1);

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        print(pickedFile.path);
        emit(PickedImageSuccessState());
      } else {
        print('No image selected.');
        emit(PickedImageErrorState());
      }
    } catch (exeption) {
      print(exeption);
    }
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
      }).catchError((error) {
        print(error);
      });
    });
  }

  File? postImage;
  Future pickPostImage() async {
    try {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 1);

      if (pickedFile != null) {
        postImage = File(pickedFile.path);
        print(pickedFile.path);
        emit(PickPostImageSuccessState());
      } else {
        print('No image selected.');
        emit(PickPostImageErrorState());
      }
    } catch (exeption) {
      print(exeption);
    }
  }

  void createPost({required String text}) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
      name: model!.name!,
      uId: model!.uId,
      text: text,
      postImage: 'www.facebook.com/A7MeDG0L0L',
      dateTime: DateTime.now().toString(),
      image: model!.image,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      print(value.snapshots().toString());
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsID = [];
  List<String> comments = [];
  List<int> likes = [];

  void getPosts() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          value.docs.forEach((element) {
            print(element.data());
            comments.add(element.data()['comment']);
            print(comments);
          });
        }).catchError((error) {});
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsID.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          print(posts);
          emit(GetPostSuccessState());
        }).catchError((error) {
          print(error);
        });
      });
    }).catchError((error) {
      print(error);
      emit(GetPostErrorState());
    });
  }

  void likePost(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': true}).then((value) {
      emit(PostLikeSuccessState());
    }).catchError((error) {
      emit(PostLikeErrorState());
    });
  }

  void commentOnPost(String postID, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('comments')
        .doc(model!.uId)
        .set({'comment': comment}).then((value) {
      emit(CommentOnPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CommentOnPostErrorState());
    });
  }

  void commentsOnPost() {}

  List<SocialUserModel> users = [];
  void getUsers() {
    emit(GetUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        print(model!.name);
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(GetUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetUsersErrorState());
      });
    }
  }

  void sendMessage({required String text, required String receiverID}) {
    MessageModel messageModel = MessageModel(
        text: text,
        dateTime: DateTime.now().toString(),
        senderID: model!.uId,
        receiverID: receiverID);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('Chats')
        .doc(receiverID)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
          print(value.id);
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error);
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('Chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error);
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverID}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('Chats')
        .doc(receiverID)
        .collection('messages').orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));

          });

    });
    emit(GetMessageSuccessState());
  }
}
