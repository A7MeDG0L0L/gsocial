import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_cubit.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_states.dart';
import 'package:gsocial/data/models/post_model.dart';
import 'package:gsocial/shared/icon_broken.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
   var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit,SettingsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is! GetUsersLoadingState) {
          return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 20.0,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      const Image(
                          image: NetworkImage('https://image.freepik'
                              '.com/free-photo/indoor-shot-positive-bearded-male-casual-red-t-shirt-points-with-index-finger-aside_273609-16274.jpg')),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Communicate with your friends',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(itemBuilder: (context, index) => cardBuilder
                (SettingsCubit.get(context).posts[index],context,index),
                itemCount:
              SettingsCubit.get(context).posts.length,
                shrinkWrap: true,),

            ],
          ),
        );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },

    );
  }
  Widget cardBuilder(PostModel model,context,index){
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(model.image),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:  [
                          Text(
                            model.name!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ],
                      ),
                      Text(
                        '${TimeOfDay.now().format(context)} in ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
          Container(
              height: 0.6, width: double.infinity, color: Colors.grey),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${model.text}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if(model.postImage !='www.facebook.com/A7MeDG0L0L')
          Container(
            child:  Image(
              image :
              NetworkImage
                (model
                  .postImage!),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children:  [
                const Icon(
                  IconBroken.Heart,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${SettingsCubit.get(context).likes[index]}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const Spacer(),
                 IconButton(onPressed: (){
                   Scaffold.of(context).showBottomSheet((context) {
                     return Padding(
                       padding: const EdgeInsets.all(30.0),
                       child: SizedBox(
                         height: double.infinity,
                         width: double.infinity,
                         child: Column(
                           children: [
                             ListView.separated(shrinkWrap: true,itemBuilder:
                                 (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(SettingsCubit.get(context).comments[index]),
                            );},
                                 separatorBuilder: (context,
                                 index)
                             => const
                             Divider
                                   (height: 1,thickness: 1,),
                                 itemCount: SettingsCubit.get(context).comments.length)
                           ],
                         ),
                       ),
                     );
                   });
                 },
                  icon :Icon(IconBroken.Chat,),
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${SettingsCubit.get(context).comments.length} comments',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
              height: 0.6, width: double.infinity, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(SettingsCubit.get(context)
                      .model!.image),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  height: 15,width: 150,
                  child: TextFormField(
                    controller: commentController,
                    decoration: const InputDecoration(hintText: 'Write a comment...',
                        border:InputBorder.none,hintStyle: TextStyle
                          (fontSize: 13) ),
                  ),
                ),
                const Spacer(),
                TextButton(onPressed: (){
                 if(commentController.text.isNotEmpty){
                   SettingsCubit.get(context).commentOnPost(SettingsCubit.get
                     (context).postsID[index], commentController.text);

                   commentController.clear();
                 }else{
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar
                     (content: Text('Write Some Text to comment on the post.',)
                     ,backgroundColor: Colors.amber,));
                 }
                }, child: const Text('Comment',
                  style:TextStyle
                  (fontSize: 13),)),
                IconButton(onPressed: (){
                  SettingsCubit.get(context).likePost(SettingsCubit.get
                    (context).postsID[index]);
                }, icon: const Icon(IconBroken.Heart,
                  color: Colors.red,),),const Text('Like'),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
