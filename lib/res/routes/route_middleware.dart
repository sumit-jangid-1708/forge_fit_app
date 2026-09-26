import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/local/hive_boxes.dart';
import 'routes_name.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Agar user logged in nahi hai aur wo dashboard ya kisi restricted screen par ja raha hai
    if (!HiveBoxes.isLoggedIn) {
      return const RouteSettings(name: RouteName.loginScreen);
    }
    return null;
  }
}
