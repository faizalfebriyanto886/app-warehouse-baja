import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:get/get.dart';

class SupervisorSignaturePadController extends GetxController {
  static SupervisorSignaturePadController get controller =>
      Get.find<SupervisorSignaturePadController>();
  final signatureKey = GlobalKey<SignatureState>();
  ByteData signatureImage = ByteData(0);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  saveFromSignaturePadToImage() async {
    final sign = signatureKey.currentState;
    if (sign!.hasPoints) {
      final image = await sign.getData();
      var data = await image.toByteData(format: ImageByteFormat.png);
      final encoded = base64.encode(data!.buffer.asUint8List());
      Get.back(result: {"signature_image_encoded": encoded});
    } else {
      Get.snackbar(
        "Oops!",
        "Buat TTD dahulu",
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        isDismissible: true,
        margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      );
    }
  }

  resetSignaturePad() {
    signatureKey.currentState?.clear();
    update();
  }
}
