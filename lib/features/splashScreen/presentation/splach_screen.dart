import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noteapp/core/constant/app_images.dart';
import 'package:noteapp/core/routes/appRoutes.dart';
import 'package:noteapp/data/services/pin_service.dart';
import 'package:noteapp/features/pinscreen/presentation/PinScreen.dart';
import 'package:noteapp/model/pin_mode.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    final hasPin = await PinService.hasPin();

    if (!mounted) return;

    if (!hasPin) {
      Navigator.pushReplacementNamed(
        context,
        Approutes.home,
      );
      return;
    }

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const PinScreen(
          mode: PinMode.enter,
        ),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      Navigator.pushReplacementNamed(
        context,
        Approutes.home,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          AppImages.splachScreen,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}