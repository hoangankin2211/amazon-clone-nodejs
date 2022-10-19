import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/controller/auth_controller.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Auth {
  signIn,
  signUp,
  token,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController authController = Get.find<AuthController>();

  Rx<Auth> auth = Rx<Auth>(Auth.token);
  Rx<Auth> selectedButton = Rx<Auth>(Auth.signIn);

  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();

  Future handleFutureService(Auth service) async {
    if (service == Auth.signIn) {
      GlobalVariables.userInfo = authController.getUser!;
      authController.signInUser(
        email: _email.text,
        password: _password.text,
        context: context,
      );
    } else if (service == Auth.signUp) {
      authController.signUpUser(
        email: _email.text,
        password: _password.text,
        name: _name.text,
        context: context,
      );
    } else if (service == Auth.token) {
      final checkToken = await authController.isTokenValid();
      if (checkToken) {
        GlobalVariables.userInfo = authController.getUser!;
        if (GlobalVariables.userInfo!.type == 'user') {
          Get.offAndToNamed(RouteName.dashboardScreen);
        } else {
          Get.offAndToNamed(RouteName.adminScreen);
        }
        return false;
      } else {
        auth.value = Auth.signIn;
      }
    }
    return true;
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: Obx(
        () {
          return FutureBuilder(
            future: handleFutureService(auth.value),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data as bool) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome',
                              style: TextStyle(fontSize: 24),
                            ),
                            ListTile(
                              title: const Text(
                                'Create Account',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              leading: Obx(() {
                                return Radio(
                                  value: Auth.signUp,
                                  groupValue: selectedButton.value,
                                  onChanged: (Auth? val) {
                                    selectedButton.value = val!;
                                  },
                                  activeColor: GlobalVariables.secondaryColor,
                                );
                              }),
                            ),
                            Obx(
                              () {
                                if (selectedButton.value == Auth.signUp) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: GlobalVariables.backgroundColor,
                                    ),
                                    child: Form(
                                      key: _signUpFormKey,
                                      child: Column(
                                        children: [
                                          CustomTextField(
                                            hintText: 'Name',
                                            controller: _name,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Email',
                                            controller: _email,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Password',
                                            controller: _password,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomButton(
                                            title: 'Sign Up',
                                            onTap: () {
                                              if (_signUpFormKey.currentState!
                                                  .validate()) {
                                                auth.value = Auth.signUp;
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox(height: 0);
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Sign-In',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              leading: Obx(() {
                                return Radio(
                                  value: Auth.signIn,
                                  groupValue: selectedButton.value,
                                  onChanged: (Auth? val) {
                                    selectedButton.value = val!;
                                  },
                                  activeColor: GlobalVariables.secondaryColor,
                                );
                              }),
                            ),
                            Obx(() {
                              if (selectedButton.value == Auth.signIn) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: GlobalVariables.backgroundColor,
                                  ),
                                  child: Form(
                                    key: _signUpFormKey,
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          hintText: 'Email',
                                          controller: _email,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextField(
                                          hintText: 'Password',
                                          controller: _password,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomButton(
                                          title: 'Sign in',
                                          onTap: () {
                                            auth.value = Auth.signIn;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox(
                                height: 0,
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  }
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
