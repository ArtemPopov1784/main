import 'package:diplome/core/connect.dart';
import 'package:diplome/di/service.dart';
import 'package:diplome/features/my_event/presentation/ui/auth_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  await init();
  WidgetsFlutterBinding.ensureInitialized();
  connect();
  runApp(const MaterialApp(home: AuthScreen()));
}
