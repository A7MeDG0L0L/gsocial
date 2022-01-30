import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_cubit.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_states.dart';
import 'package:gsocial/presentation/edit_profile_screen.dart';
import 'package:gsocial/presentation/login_screen.dart';
import 'package:gsocial/shared/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  => SettingsCubit()..getUserData(),
      child: BlocConsumer<SettingsCubit,SettingsStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var model = SettingsCubit.get(context).model;
          if (model != null) {
            return  Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 160,
                            decoration:  BoxDecoration(borderRadius: const BorderRadius.only
                              (topLeft: const Radius.circular(20),topRight: const Radius.circular(20)),
                              image: DecorationImage(fit: BoxFit.cover,image:
                              NetworkImage(  model.cover ),),  ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 57,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child:  CircleAvatar(radius: 50,backgroundImage:
                        NetworkImage(model.image),),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Text(model.name!,style: const TextStyle(fontWeight: FontWeight
                    .bold,
                    fontSize: 20),),
                const SizedBox(height: 15,),
                Text(model.bio!),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const <Widget>[
                            Text('140',style: TextStyle(fontWeight: FontWeight.bold,),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Posts',style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const <Widget>[
                            Text('93',style: TextStyle(fontWeight: FontWeight.bold,),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Photos',style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const <Widget>[
                            Text('14K',style: TextStyle(fontWeight: FontWeight.bold,)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Followers',style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const <Widget>[
                            Text('263',style: TextStyle(fontWeight: FontWeight.bold,),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Following',style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    Expanded(child: OutlinedButton(onPressed: (){}, child: const Text('Add Photos'),)),
                    const SizedBox(width: 10,),
                    OutlinedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context) => EditPageScreen(),),);
                    }, child: const Icon(IconBroken.Edit),),
                    const SizedBox(width: 10,),
                  ],
                ),

                OutlinedButton(onPressed:() {
                  SettingsCubit.get(context).signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route)
                  => false);

                }, child:const Text('Sign out')),

              ],
            );

          }
          else {
            return const Center(child:  CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
