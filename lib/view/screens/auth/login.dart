import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/auth/login_controller.dart';
import 'package:promotion_dashboard/core/classes/validator.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/functions/size.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/login/login_text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return GetBuilder<LoginControllerImp>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width(16)),
            child: Form(
              key: controller.formState,
              child: ListView(
                children: [
                  SizedBox(height: height(180)),
                  Text(
                    'Enter your account',
                    textAlign: TextAlign.center,
                    style: MyText.appStyle.fs25.wMedium.reColorLightGray.style,
                  ),
                  SizedBox(height: height(50)),

                  // Email Field
                  LoginTextField(
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    controller: controller.email,
                    validator: (value) => MyValidator.validate(
                      value,
                      type: ValidatorType.email,
                      fieldName: 'the email',
                    ),
                  ),
                  SizedBox(height: height(20)),

                  // Password Field
                  LoginTextField(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    isPassword: true,
                    isSeen: controller.isSeenPassword,
                    onTapEye: controller.showPassword,
                    controller: controller.password,
                    validator: (value) => MyValidator.validate(
                      value,
                      type: ValidatorType.password,
                      fieldName: 'the password',
                      min: 8,
                    ),
                  ),
                  SizedBox(height: height(20)),

                  // Remember Me and Forget Password
                  Row(
                    children: [
                      Checkbox(
                        value: controller.rememberMe,
                        onChanged: controller.toggleRememberMe,
                      ),
                      Text('Remember me',
                          style: MyText
                              .appStyle.fs13.wMedium.reColorLightGray.style),
                    ],
                  ),
                  SizedBox(height: height(40)),

                  // Login Button
                  CustomButton(
                    title: !controller.loading ? 'login' : 'Loading...',
                    onPressed: controller.login,
                  ),
                  SizedBox(height: height(50)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
