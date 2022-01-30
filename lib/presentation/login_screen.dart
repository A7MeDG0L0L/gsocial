import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/login_cubit/login_cubit.dart';
import 'package:gsocial/business_logic/login_cubit/login_states.dart';
import 'package:gsocial/presentation/layout_screen.dart';
import 'package:gsocial/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ErrorLoginState) {
            String result= state.error.replaceAll('[firebase_auth/wrong-password]','' );
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text
              (result)));
            print(result);
          }
          if(state is SuccessLoginState){
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => LayoutScreen(),), (route) =>
            false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login Now',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Communicate with your friends',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      myTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validation: (String? value) {
                            if (value!.isEmpty) {
                              return 'Must Enter email address';
                            }
                          },
                          icon: Icons.person,
                          label: 'Email Address'),
                      SizedBox(
                        height: 20,
                      ),
                      myTextFormField(
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        validation: (String? value) {
                          if (value!.isEmpty) {
                            return 'Must Enter Password';
                          }
                        },
                        label: 'Password',
                        icon: Icons.password,
                        isObscure: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(
                          child: SizedBox(
                            height: 60,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  print('Validated!');
                                  LoginCubit.get(context).loginUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text('Login'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
