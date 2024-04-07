import 'package:diplome/features/my_event/presentation/ui/auth_screen.dart';
import 'package:flutter/material.dart';

import 'package:diplome/core/connection_to_db.dart';
import 'package:diplome/di/my_observer.dart';

void main() async {
  // await init();
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addObserver(MyAppObserver());
  ConnectionToDB().close();

  runApp(
    MaterialApp(
      home: FutureBuilder(
        future: ConnectionToDB().connection(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator.adaptive());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: SingleChildScrollView(
                    child: Text("$snapshot - error"),
                  ),
                );
              } else {
                return const AuthScreen();
              }
            default:
              return const Center(child: Text("🤡"));
          }
        },
      ),
    ),
  );
}
