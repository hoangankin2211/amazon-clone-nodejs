import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/admin/screens/admin_screen.dart';
import 'package:amazon/features/auth/binding/auth_binding.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/features/dashboard/binding/dashboard_binding.dart';
import 'package:amazon/features/dashboard/screens/dashboard_screen.dart';
import 'package:amazon/features/home/binding/home_binding.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: RouteName.authScreen,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.dashboardScreen,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RouteName.adminScreen,
      page: () => const AdminScreen(),
    ),
  ];
}
