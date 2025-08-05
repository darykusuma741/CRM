import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomConnectionStatusController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  final Rxn<String?> status = Rxn();
  final Rx<bool> connected = Rx(false);
  final Rxn<ConnectivityResult?> connectivityResult = Rxn();

  void startInternetCheckLoop() {
    Timer.periodic(Duration(seconds: 3), (timer) async {
      if (connectivityResult.value == ConnectivityResult.none) return;
      bool hasInternet = await checkInternet();
      if (hasInternet) {
        hideStatus();
      } else {
        showStatus("Not connected to server");
      }
    });
  }

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('dns.google');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Mulai dari bawah
      end: const Offset(0, 0), // Muncul ke posisi normal
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    checkConnection();
    startInternetCheckLoop();
    super.onInit();
  }

  void showStatus(String message) {
    connected.value = false;
    status.value = message;
    animationController.forward(); // Slide masuk
  }

  void hideStatus() {
    connected.value = true;
    animationController.reverse().then((_) {
      status.value = null; // Kosongkan status setelah animasi keluar
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  checkConnection() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.isEmpty) return;
      final ConnectivityResult? none = result.firstWhereOrNull((e) => e == ConnectivityResult.none);
      if (none != null) {
        connectivityResult.value = ConnectivityResult.none;
        showStatus("No internet connection");
      } else {
        connectivityResult.value = null;
        hideStatus();
      }
    });
  }
}
