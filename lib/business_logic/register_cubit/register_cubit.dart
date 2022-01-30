import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/register_cubit/register_states.dart';
import 'package:gsocial/data/models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void newUser({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value);
      userCreate(
          email: email,
          password: password,
          phone: phone,
          image: 'https'
              '://image.freepik.com/free-photo/waist-up-portrait-handsome-serious'
              '-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has'
              '-talk-with-interlocutor-stands-against-white-wall-self-confident'
              '-man-freelancer_273609-16320.jpg',
          bio: 'Bio. . . ',
          isEmailVerified: false,
          name: name,
          uId: value.user!.uid,
          cover: 'https://image'
              '.freepik.com/free-photo/indoor-shot-confused-ethnic-couple-cross-hands-chest-point-left-right-show-directions-cannot-make-choice_273609-38998.jpg');
      emit(SuccessRegisterNewUserState());
    });
  }

  void userCreate({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String bio,
    required String image,
    required bool isEmailVerified,
    required String uId,
    required String cover,
  }) {
    SocialUserModel model = SocialUserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        isEmailVerified: isEmailVerified,
        cover: cover,
        image: image,
        bio: bio);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SuccessCreateNewUserState());
    });
  }
}
