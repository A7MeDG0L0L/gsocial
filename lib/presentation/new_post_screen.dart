import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_cubit.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_states.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key? key}) : super(key: key);
  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit,SettingsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Text('New Post'),actions: [TextButton(onPressed:
              (){cubit.createPost(text: postController.text,);}, child: Text('Post'),),],),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:  [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Ahmed Galal',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller:  postController,
                    decoration: InputDecoration(hintText: 'What\'s on your mind '
                        '....',border: InputBorder.none),
                    keyboardType: TextInputType.text,


                  ),
                ),
                if(state is PickPostImageSuccessState)
                      SizedBox(height: 150,width: double.infinity,child: Image(image: FileImage(cubit.postImage!),)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: (){
                      cubit.pickPostImage();
                    }, child: Text('Add Photos')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
