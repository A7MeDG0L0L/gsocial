import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_cubit.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_states.dart';
import 'package:gsocial/shared/components/components.dart';
import 'package:gsocial/shared/icon_broken.dart';

class EditPageScreen extends StatelessWidget {
  EditPageScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SettingsCubit()..getUserData();
      },
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {
          if (SettingsCubit.get(context).model != null) {
            nameController.text = SettingsCubit.get(context).model!.name!;
            bioController.text = SettingsCubit.get(context).model!.bio!;
          }
        },
        builder: (context, state) {
          var model = SettingsCubit.get(context).model;
          var profileImage = SettingsCubit.get(context).profileImage;

          print(model);
          if (model != null) {
            nameController.text = SettingsCubit.get(context).model!.name!;
            bioController.text = SettingsCubit.get(context).model!.bio!;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('Edit Profile'),
                actions: [TextButton(onPressed: (){
                  if(profileImage!=null) {
                    SettingsCubit.get(context).uploadProfileImage();
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select a photo man ! ')));
                  }

                  }, child: Text('Update'),),],
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: const Radius.circular(20),
                                    topRight: const Radius.circular(20)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                       NetworkImage(model.cover),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 57,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:profileImage == null ?
          NetworkImage(model.image): FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SettingsCubit.get(context).getProfileImage();
                              },
                              icon: Icon(IconBroken.Camera),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    myTextFormField(
                        controller: nameController,
                        textInputType: TextInputType.name,
                        validation: (String? value) {
                          if (value!.isEmpty) return 'name must be entered';
                        },
                        label: 'Name',
                        icon: Icons.person),
                    SizedBox(
                      height: 10,
                    ),
                    myTextFormField(
                        controller: bioController,
                        textInputType: TextInputType.text,
                        validation: (String? value) {
                          if (value!.isEmpty) return 'name must be entered';
                        },
                        label: 'Bio',
                        icon: Icons.text_fields),
                  ],
                ),
              ),
            );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
