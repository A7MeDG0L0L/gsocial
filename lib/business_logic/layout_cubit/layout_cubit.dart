import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/layout_cubit/layout_states.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_cubit.dart';
import 'package:gsocial/presentation/chats_screen.dart';
import 'package:gsocial/presentation/home_screen.dart';
import 'package:gsocial/presentation/new_post_screen.dart';
import 'package:gsocial/presentation/settings_screen.dart';
import 'package:gsocial/presentation/users_screen.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super(InitialLayoutState());

  static LayoutCubit get (context) => BlocProvider.of(context);

  List <Widget> screens= [
    HomeScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen(),

  ];
 List<String> appBarTitle=[
   'News Feeds','Chats','New Post','Users','Settings',
 ];

  int currentIndex =0;
  void changeNavBar(index,context){
    if(index ==1){
      SettingsCubit.get(context).getUsers();
    }
    if(index == 2){
      emit(NewPostState());
    }else{
      currentIndex = index;
      emit(ChangeNavBarState());
    }
  }


}