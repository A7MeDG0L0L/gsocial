import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_cubit.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_states.dart';
import 'package:gsocial/data/models/message_model.dart';
import 'package:gsocial/data/models/user_model.dart';
import 'package:gsocial/shared/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({Key? key, required this.model}) : super(key: key);
  final SocialUserModel model;
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SettingsCubit.get(context).getMessages(receiverID: model.uId!);
        return BlocConsumer<SettingsCubit,SettingsStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(model.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(model.name!),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(itemBuilder: (context, index) {
                        if(SettingsCubit.get(context).model!.uId ==
                            SettingsCubit.get(context).messages[index].senderID) {
                          return   buildMyMessage(SettingsCubit.get(context)
                              .messages[index]);
                        }
                   return   buildMessage(SettingsCubit.get(context)
                            .messages[index]);
                      },
                  separatorBuilder: (context, index) => SizedBox(height: 15,)
                          , itemCount: SettingsCubit.get(context).messages.length ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autofocus: true,
                                controller: messageController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'Type your text '
                                        'here ...',
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  SettingsCubit.get(context).sendMessage(text:
                                  messageController.text, receiverID: model.uId!);
                                }, icon: Icon(IconBroken.Send)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
  Widget buildMessage(MessageModel model){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )),
        padding: const EdgeInsets.all(10),
        child:  Text(model.text!),
      ),
    );
  }
  Widget buildMyMessage(MessageModel model){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )),
        padding: const EdgeInsets.all(10),
        child:  Text(model.text!),
      ),
    );
  }
}
