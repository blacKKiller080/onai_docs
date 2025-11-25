import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/extension/extensions.dart';
import 'package:onai_docs/src/core/resources/resources.dart';
import 'package:onai_docs/src/features/app/bloc/app_bloc.dart';
import 'package:onai_docs/src/features/app/widgets/custom/common_button.dart';
import 'package:onai_docs/src/features/app/widgets/custom/common_input.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController loginTextController = TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 40),
                const Text(
                  'Добро пожаловать!',
                  style: AppTextStyles.os18w400,
                ),
                CommonInput(
                  'Логин',
                  controller: loginTextController,
                  margin: const EdgeInsets.only(top: 35, bottom: 20),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Логин не может быть пустым';
                    }
                    return null;
                  },
                ),
                CommonInput(
                  'Пароль',
                  controller: passwordTextController,
                  type: InputType.PASSWORD,
                  textInputAction: TextInputAction.done,
                ),
                const Spacer(),
                CommonButton(
                  child: const Text('Войти'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.repository.authRepository
                          .setUserForTest(user: loginTextController.text);
                      context.appBloc.add(const AppEvent.logining());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
