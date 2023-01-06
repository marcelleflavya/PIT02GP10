import 'package:flutter_modular/flutter_modular.dart';
import 'package:gastos_app/src/modules/authentication/authentication_routes.dart';
import 'package:gastos_app/src/modules/authentication/login/login_page.dart';
import 'package:gastos_app/src/modules/authentication/login/login_page_controller.dart';
import 'package:gastos_app/src/modules/authentication/recovery/recovery_password_page.dart';
import 'package:gastos_app/src/modules/authentication/register/register_page.dart';
import 'package:gastos_app/src/modules/authentication/register/register_page_controller.dart';
import 'package:gastos_app/src/modules/authentication/repositories/user_repository_shared_prefs.dart';
import 'package:gastos_app/src/modules/authentication/services/auth_service.dart';
import 'package:gastos_app/src/modules/authentication/splash/controller/splash_page_controller.dart';
import 'package:gastos_app/src/modules/authentication/splash/splash_page.dart';

class AuthenticationModule extends Module {
  final animationDuration = const Duration(milliseconds: 600);
  final transitionType = TransitionType.scale;

  @override
  List<Bind<Object>> get binds => [
        Bind.factory<SplashPageController>(
          (i) => SplashPageController(authService: AuthService()),
        ),
        Bind.factory<LoginPageController>(
          (i) => LoginPageController(authService: AuthService()),
        ),
        Bind.factory<RegisterPageController>(
          (i) => RegisterPageController(
            userRepository: UserRepositorySharedPrefs(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          AuthenticationRoutes.splash,
          child: (context, _) => const SplashPage(),
          duration: animationDuration,
          transition: transitionType,
        ),
        ChildRoute(
          AuthenticationRoutes.login,
          child: (context, _) => const LoginPage(),
          duration: animationDuration,
          transition: transitionType,
        ),
        ChildRoute(
          AuthenticationRoutes.recover,
          child: (context, __) => const RecoveryPasswordPage(),
          duration: animationDuration,
          transition: transitionType,
        ),
        ChildRoute(
          AuthenticationRoutes.register,
          child: (context, _) => const RegisterPage(),
          duration: animationDuration,
          transition: transitionType,
        ),
      ];
}
