import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsocial/business_logic/register_cubit/register_cubit.dart';
import 'package:gsocial/business_logic/register_cubit/register_states.dart';
import 'package:gsocial/presentation/login_screen.dart';
import 'package:gsocial/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
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
                        'Register Now',
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
                          controller: nameController,
                          textInputType: TextInputType.name,
                          validation: (String? value) {
                            if (value!.isEmpty) {
                              return 'Must Enter your Name';
                            }
                          },
                          icon: Icons.person,
                          label: 'Name'),
                      SizedBox(height: 20,),
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
                      SizedBox(
                        height: 20,
                      ),
                      myTextFormField(
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          validation: (String? value) {
                            if (value!.isEmpty) {
                              return 'Must Enter Phone Number';
                            } else if (value.length < 11) {
                              return 'Phone Number Must be 11 digits';
                            }
                          },
                          icon: Icons.phone,
                          label: 'Phone Number'),
                      SizedBox(
                        height: 20,
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
                                  RegisterCubit.get(context).newUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      name:nameController.text, );
                                }
                              },
                              child: Text('Login'),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Have an account already ?'),
                          TextButton(onPressed:() {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
                          }, child: Text('Login Now ',
                              ),),
                        ],
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
