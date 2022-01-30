import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_cubit.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_states.dart';
import 'package:gsocial/data/models/user_model.dart';
import 'package:gsocial/presentation/chat_details_screen.dart';
import 'package:intl/intl.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit,SettingsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(itemBuilder: (context, index) => chatBuilder
                (SettingsCubit.get(context).users[index],context),
                separatorBuilder: (context, index) => Divider(height: 1,),
                itemCount: SettingsCubit.get(context).users.length,shrinkWrap: true,),
            ],
          ),
        );
      },
    );
  }
  Widget chatBuilder (SocialUserModel model,context){
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) =>
            ChatDetailsScreen(model: model),));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(model.image),
            ),
            SizedBox(width: 10,),
            Text(
              model.name!,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
