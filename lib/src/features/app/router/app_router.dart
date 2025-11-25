import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onai_docs/src/features/app/presentation/launcher.dart';
import 'package:onai_docs/src/features/auth/ui/presentation/login_page.dart';
import 'package:onai_docs/src/features/client/cart/ui/presentation/cart_page.dart';
import 'package:onai_docs/src/features/client/main_page/ui/presentation/main_page.dart';
import 'package:onai_docs/src/features/client/profile/ui/presentaion/profile_page.dart';
import 'package:onai_docs/src/features/client/task/model/task_dto.dart';
import 'package:onai_docs/src/features/client/task/ui/presentation/create_order_page.dart';
import 'package:onai_docs/src/features/client/task/ui/presentation/edit_order_page.dart';
import 'package:onai_docs/src/features/client/task/ui/presentation/task_page.dart';

part 'app_router.gr.dart';

// @MaterialAutoRouter(
//   replaceInRouteName: 'Page,Route',
//   routes: [
//     AutoRoute<void>(
//       page: Launcher,
//       initial: true,P
//       name: 'LauncherRoute',
//       children: [
//         CustomRoute<void>(
//           page: MainPage,
//           // transitionsBuilder: TransitionsBuilders.slideTop,
//           // SlideTransition(
//           //   position: Tween<Offset>(
//           //     begin: Offset(0.0, -1.0),
//           //     end: Offset.zero,
//           //   ).animate(animation),
//           //   child: child,
//           // ),
//         ),
//         AutoRoute<void>(page: PolicesPage),
//         AutoRoute<void>(page: InsurancePage),
//         CustomRoute<void>(
//           page: EmptyRouterPage,
//           name: 'BaseProfileRoute',
//           // transitionsBuilder: TransitionsBuilders.slideTop,
//           children: [
//             AutoRoute<void>(page: ProfilePage, initial: true),
//             AutoRoute<void>(page: EditprofilePage),
//             AutoRoute<void>(page: CreditCardPage),
//             AutoRoute<void>(page: EditAddresPage),
//           ],
//         ),
//         // AutoRoute<void>(
//         //   page: ProfilePage,
//         //   initial: true,
//         //   children: [
//         //     AutoRoute<void>(page: EditprofilePage),
//         //   ],
//         // ),
//       ],
//     ),

//     // auth pages
//     AutoRoute<void>(page: AuthPage),
//     AutoRoute<void>(page: LoginPage),
//     AutoRoute<void>(page: PincodePage),
//     AutoRoute<void>(page: CreatePinCodePage),
//     AutoRoute<void>(page: SetBiometricsPage),
//     AutoRoute<void>(page: RegistrationPage),
//     AutoRoute<void>(page: PhoneInputPage),
//     AutoRoute<void>(page: CreatePasswordPage),
//     AutoRoute<void>(page: ForgotPassordPage),
//     AutoRoute<void>(page: EgovBusinessPage),
//     AutoRoute<void>(page: AituPassportPage),

//     /// profile pages
//     AutoRoute<void>(page: ChangePinCodePage),
//     AutoRoute<void>(page: ConfirmPinCodePage),
//     AutoRoute<void>(page: PasswordChangePage),
//     AutoRoute<void>(page: AddNewCardPage),

//     /// main pages
//     AutoRoute<void>(page: NotificationPage),
//     AutoRoute<void>(page: DetailNotificationPage),
//   ],
// )

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: LauncherRoute.page,
      initial: true,
      children: [
        AutoRoute(page: MainRoute.page),
        AutoRoute(page: TaskRoute.page),
        AutoRoute(page: NotificationRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: CreateOrderRoute.page),
    AutoRoute(page: EditOrderRoute.page),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.material();
}

@RoutePage(name: 'BaseProfileTab')
class BaseProfilePage extends AutoRouter {
  const BaseProfilePage({super.key});
}
