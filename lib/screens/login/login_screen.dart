import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/validators/form/form_validator.dart';
import 'package:pyc/controllers/login/login_controller.dart';
import 'package:pyc/screens/components/button/default_input_button.dart';
import 'package:pyc/screens/components/input/default_input_field.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    String password = '';
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ConstrainedBox(
            //Use MediaQuery.of(context).size.height for max Height
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Form(
              key: formKey,
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '반가워요!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      kQuarterHeightSizedBox,
                      const Text(
                        '서비스를 이용하기 위해 로그인 해주세요.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: kGreyTextColor,
                        ),
                      ),
                      kDoubleHeightSizeBox,
                      Image.asset('assets/images/login.png'),
                      kDoubleHeightSizeBox,
                      DefaultInputField(
                        label: '이름',
                        hint: '이름을 입력해주세요.',
                        autoFocus: true,
                        onSaved: (value) => name = value!,
                        validator: requiredStringValidator,
                      ),
                      kHeightSizeBox,
                      GetBuilder<LoginController>(
                        builder: (controller) => DefaultInputField(
                          label: '비밀번호',
                          hint: '비밀번호를 입력해주세요.',
                          inputType: TextInputType.visiblePassword,
                          obscureText: controller.obscureText,
                          suffixIcon: IconButton(
                            color: kPrimaryColor,
                            icon: Icon(controller.obscureIcon),
                            onPressed: controller.toggleObscureText,
                          ),
                          onSaved: (value) => password = value!,
                          validator: requiredStringValidator,
                        ),
                      ),
                      kDoubleHeightSizeBox,
                      DefaultInputButton(
                        onPressed: () async {
                          if (formKey.currentState != null && !formKey.currentState!.validate()) return;
                          formKey.currentState!.save();
                          final controller = Get.find<LoginController>();
                          await controller.login(name, password);
                        },
                        label: '로그인',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
