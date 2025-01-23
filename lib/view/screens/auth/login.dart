import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/auth/login_controller.dart';
import 'package:promotion_dashboard/core/classes/validator.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/auth/login/login_text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return GetBuilder<LoginControllerImp>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isDesktop = constraints.maxWidth >= 600;

                  BoxDecoration? containerDecoration = isDesktop
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        )
                      : null;

                  Widget content = Form(
                    key: controller.formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Enter your account',
                          textAlign: TextAlign.center,
                          style: MyText
                              .appStyle.fs25.wMedium.reColorLightGray.style,
                        ),
                        const SizedBox(height: 30),

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
                          isSeen: true,
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        LoginTextField(
                          controller: controller.password,
                          validator: (value) => MyValidator.validate(
                            value,
                            type: ValidatorType.password,
                            fieldName: 'the password',
                          ),
                          isPassword: true,
                          isSeen: controller.isSeenPassword,
                          hintText: 'Password',
                          onTapEye: controller.togglePasswordVisibility,
                        ),
                        const SizedBox(height: 20),

                        // Remember Me and Forget Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.rememberMe,
                              onChanged: controller.toggleRememberMe,
                            ),
                            Text('Remember me',
                                style: MyText.appStyle.fs13.wMedium
                                    .reColorLightGray.style),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Login Button
                        CustomButton(
                          title: !controller.loading ? 'login' : 'Loading...',
                          onPressed: controller.login,
                        ),
                      ],
                    ),
                  );

                  return Container(
                    width: isDesktop ? 400 : null,
                    padding: const EdgeInsets.all(16),
                    decoration: containerDecoration,
                    child: content,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
