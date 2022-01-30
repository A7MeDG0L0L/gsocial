import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/layout_cubit/layout_cubit.dart';
import 'package:gsocial/business_logic/layout_cubit/layout_states.dart';
import 'package:gsocial/presentation/new_post_screen.dart';
import 'package:gsocial/shared/icon_broken.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:  (context) =>  LayoutCubit(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context, state) {
if (state is NewPostState) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewPostScreen(),));

}
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  LayoutCubit.get(context).appBarTitle[LayoutCubit.get
                    (context).currentIndex],
                  style:
                TextStyle(color: Colors
                    .black),),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconBroken.Chat,
                      ),
                      label: 'Chats'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconBroken.Arrow___Up_Square,
                      ),
                      label: 'New Post'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.User), label: 'Users'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Setting),
                      label: 'Settin'
                          'gs'),
                ],
                onTap: (index){
                  LayoutCubit.get(context).changeNavBar(index,context);
                },
                currentIndex: LayoutCubit.get(context).currentIndex,
              ),
              body: LayoutCubit.get(context)
                  .screens[LayoutCubit.get(context).currentIndex]);
        },
      ),
    );
  }
}
