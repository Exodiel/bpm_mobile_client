import 'package:flutter/widgets.dart';
import 'package:google_maps/app/ui/pages/cart/cart_page.dart';
import 'package:google_maps/app/ui/pages/checkout/checkout_page.dart';
import 'package:google_maps/app/ui/pages/home/home_page.dart';
import 'package:google_maps/app/ui/pages/login/login_page.dart';
import 'package:google_maps/app/ui/pages/orders/orders_page.dart';
import 'package:google_maps/app/ui/pages/products/products_page.dart';
import 'package:google_maps/app/ui/pages/register/register_page.dart';
import 'package:google_maps/app/ui/pages/request_permission/request_permission_page.dart';
import 'package:google_maps/app/ui/pages/splash/splash_page.dart';
import 'package:google_maps/app/ui/pages/start/start_page.dart';
import 'package:google_maps/app/ui/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.SPLASH: (_) => const SplashPage(),
    Routes.PERMISSIONS: (_) => const RequestPermissionPage(),
    Routes.HOME: (_) => const HomePage(),
    Routes.LOGIN: (_) => const LoginPage(),
    Routes.REGISTER: (_) => const RegisterPage(),
    Routes.START: (_) => const StartPage(),
    Routes.PRODUCTS: (_) => const ProductsPage(),
    Routes.CART: (_) => const CartPage(),
    Routes.CHECKOUT: (_) => const CheckoutPage(),
    Routes.ORDERS: (_) => const OrdersPage(),
  };
}
