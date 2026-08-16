import 'dart:async';

import 'package:flutter/material.dart';

import '../core/constant/app_images.dart';
import '../core/routes/appRoutes.dart';
import '../data/services/pin_service.dart';
import '../model/pin_mode.dart';
import 'PinScreen.dart';


class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

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