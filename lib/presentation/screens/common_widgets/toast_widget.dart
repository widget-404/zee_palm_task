import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/presentation/res/res.dart';

void showToast(String msg, bool isError) {
  Get.showSnackbar(
    GetSnackBar(
        messageText: Text(
          msg,
          textAlign: TextAlign.center,
          style: textStyles.bodySmall,
        ),
        margin: const EdgeInsets.all(20),
        borderRadius: 50,
        duration: const Duration(seconds: 2),
        backgroundColor: isError ? Colors.redAccent : Colors.green),
  );
}
