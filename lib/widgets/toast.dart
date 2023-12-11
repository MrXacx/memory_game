import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class GameToast {
  void show(BuildContext context, int seconds) {
    ToastContext().init(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Toast.show(
        "Você venceu!",
        duration: seconds,
        gravity: Toast.center,
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    });
  }
}
