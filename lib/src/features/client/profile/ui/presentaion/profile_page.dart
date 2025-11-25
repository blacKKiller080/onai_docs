import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/extension/extensions.dart';
import 'package:onai_docs/src/core/resources/resources.dart';
import 'package:onai_docs/src/features/app/bloc/app_bloc.dart';
import 'package:onai_docs/src/features/app/widgets/app_bar_with_title.dart';
import 'package:onai_docs/src/features/app/widgets/custom/common_button.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(top: 0),
        child: Column(
          children: [
            const AppBarWithTitle(title: 'Профиль'),
            const SizedBox(height: 16),
            const Spacer(),
            CommonButton(
              borderColor: AppColors.kRed,
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.kRed,
              borderWidth: 1,
              onPressed: () {
                context.appBloc.add(const AppEvent.exiting());
              },
              child: const Text('Выйти из аккаунта'),
            ),
          ],
        ),
      ),
    );
  }
}
