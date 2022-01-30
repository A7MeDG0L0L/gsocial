import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/layout_cubit/layout_cubit.dart';
import 'package:gsocial/business_logic/layout_cubit/layout_states.dart';
import 'package:gsocial/business_logic/settings_cubit/settings_cubit.dart';
import 'package:gsocial/presentation/layout_screen.dart';
import 'package:gsocial/presentation/login_screen.dart';
import 'package:gsocial/presentation/register_screen.dart';
import 'package:gsocial/shared/cache_helper/cache_helper.dart';
import 'package:gsocial/shared/constants/constants.dart';

import 'BlocObserver.dart';
import 'business_logic/settings_cubit/settings_states.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    //print(value);
    print('Firebase Initialized Successfully !');
  });
 await CacheHelper.init();

 var token = await FirebaseMessaging.instance.getToken();
 print(token);
 FirebaseMessaging.onMessage.listen((event) {
   print(event.data);
 });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data);
  });
  BlocOverrides.runZoned(
        () {
      // Use blocs...
          runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

  print(uid);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context) => LayoutCubit(),),
        BlocProvider(create: (context) => SettingsCubit()..getUserData()
          ..getPosts(),),
      ],
      child: BlocConsumer<SettingsCubit,SettingsStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,


            theme: ThemeData(
              //primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(color: Colors.white,elevation: 0,
                iconTheme:
                IconThemeData(color: Colors.black),titleTextStyle: TextStyle(color:
                Colors.black,fontSize: 20), ),
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData
                (selectedItemColor: Colors.black,unselectedItemColor: Colors.grey),

            ),
            home:uid !=null ? const LayoutScreen() : RegisterScreen(),
          );
        },
      ),
    );
  }
}

