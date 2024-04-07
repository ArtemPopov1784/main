import 'package:diplome/core/connection_to_db.dart';
import 'package:flutter/material.dart';

class MyAppObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      ConnectionToDB().close();
    } else {
      ConnectionToDB().connection();
    }
  }
}
