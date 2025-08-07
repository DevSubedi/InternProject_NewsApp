import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_router.dart';

class NavigationService {
  static void pushNamed(String routeName, {Object? extra}) {
    navigationKey.currentContext?.pushNamed(routeName);
  }

  static void pushNamedReplacement(String routeName, {Object? extra}) {
    navigationKey.currentContext?.pushReplacementNamed(routeName);
  }

  static void pop() {
    navigationKey.currentContext?.pop();
  }
}
