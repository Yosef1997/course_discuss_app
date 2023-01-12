import 'package:course_discuss_app/config/session.dart';
import 'package:course_discuss_app/page/error_page.dart';
import 'package:course_discuss_app/page/home_page.dart';
import 'package:course_discuss_app/page/login_page.dart';
import 'package:go_router/go_router.dart';

import '../model/user.dart';
import '../page/register_page.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';

  static GoRouter routerConfig = GoRouter(
    errorBuilder: (context, state) => ErrorPage(
      title: 'Something Error',
      description: state.error.toString(),
    ),
    redirect: (context, state) async {
      User? user = await Session.getUser();
      if (user == null) {
        if (state.location == login || state.location == register) {
          return null;
        }
        return login;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const RegisterPage(),
      )
    ],
  );
}
