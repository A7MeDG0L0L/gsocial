import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/shared/cache_helper/cache_helper.dart';
import 'package:gsocial/shared/constants/constants.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

 static LoginCubit get(context) => BlocProvider.of(context);

  void loginUser({required String email, required String password}) {
    emit(LoadingLoginState());
    CacheHelper.sharedPreferences.remove('uid');
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print(value.user!.email);
          CacheHelper.sharedPreferences.setString('uid', value.user!.uid);
          print(value.user!.uid);
          print(uid);
      emit(SuccessLoginState());
    }).catchError((error) {
    //  print(error.toString());
      emit(ErrorLoginState(error.toString()));
    });
  }
}
