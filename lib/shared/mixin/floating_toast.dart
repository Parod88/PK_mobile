import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

mixin FloatingToast {
  final Map<String, Color> toastType = {
    'error': Colors.red.withOpacity(0.9),
    'info': Colors.blue.withOpacity(0.9),
    'success': Colors.green.withOpacity(0.9)
  };

  final Map<String, Icon> toastIcon = {
    'error': const Icon(Icons.error, color: Colors.black87),
    'info': const Icon(Icons.info, color: Colors.black87),
    'success': const Icon(Icons.check, color: Colors.black87),
  };

  final Map<String, String> errorTitle = {
    'error': "Error",
    'info': "Info",
    'success': "Success",
  };

  void showFloatingToast(BuildContext context, String toastText, String type) {
    DelightToastBar(
      builder: (context) {
        return ToastCard(
          leading: toastIcon[type],
          shadowColor: Colors.blue,
          title: Text(
            errorTitle[type]!,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          subtitle: Text(
            toastText,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.black87),
          ),
          color: toastType[type],
        );
      },
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      snackbarDuration: const Duration(seconds: 2),
    ).show(context);
  }
}
