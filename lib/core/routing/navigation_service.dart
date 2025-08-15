import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_router.dart';

class NavigationService {
  static void pushNamed(String routeName, {Object? extra}) {
    navigationKey.currentContext?.pushNamed(routeName, extra: extra);
  }

  static void pushNamedReplacement(String routeName, {Object? extra}) {
    navigationKey.currentContext?.pushReplacementNamed(routeName, extra: extra);
  }

  static void pop() {
    navigationKey.currentContext?.pop();
  }
}
