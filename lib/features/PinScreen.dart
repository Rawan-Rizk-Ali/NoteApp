import 'package:flutter/material.dart';
import '../core/constant/app_color.dart';
import '../data/services/pin_service.dart';
import '../model/pin_mode.dart';


class PinScreen extends StatefulWidget {
  final PinMode mode;

  const PinScreen({
    super.key,
    required this.mode,
  });

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String enteredPin = "";
  String firstPin = "";
  bool isConfirming = false;
  bool isLoading = false;

  bool get isDark =>
      Theme.of(context).brightness == Brightness.dark;

  String get title {
    switch (widget.mode) {
      case PinMode.create:
        return isConfirming ? "Confirm PIN" : "Create PIN";

      case PinMode.enter:
        return "Enter PIN";

      case PinMode.change:
        return isConfirming ? "New PIN" : "Current PIN";

      case PinMode.delete:
        return "Delete PIN";
    }
  }

  String get subtitle {
    switch (widget.mode) {
      case PinMode.create:
        return isConfirming
            ? "Confirm your 4-digit PIN"
            : "Create a new 4-digit PIN";

      case PinMode.enter:
        return "Enter your 4-digit PIN to continue";

      case PinMode.change:
        return isConfirming
            ? "Enter your new PIN"
            : "Enter your current PIN";

      case PinMode.delete:
        return "Enter your PIN to delete it";
    }
  }

  Widget _buildPinIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
            (index) {
          final filled = index < enteredPin.length;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled
                  ? AppColors.primary
                  : Colors.transparent,
              border: Border.all(
                width: 2,
                color: filled
                    ? AppColors.primary
                    : (isDark
                    ? AppColors.dr
                    : AppColors.border),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: isLoading ? null : () => _onNumberPressed(number),
      child: SizedBox(
        width: 75,
        height: 75,
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.dr
                  : AppColors.title,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: isLoading ? null : _deleteLastDigit,
      child: SizedBox(
        width: 75,
        height: 75,
        child: Center(
          child: Icon(
            Icons.backspace_outlined,
            size: 28,
            color: isDark
                ? AppColors.dr
                : AppColors.title,
          ),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton("1"),
            _buildNumberButton("2"),
            _buildNumberButton("3"),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton("4"),
            _buildNumberButton("5"),
            _buildNumberButton("6"),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton("7"),
            _buildNumberButton("8"),
            _buildNumberButton("9"),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 75),
            _buildNumberButton("0"),
            _buildDeleteButton(),
          ],
        ),
      ],
    );
  }

  void _onNumberPressed(String number) {
    if (enteredPin.length >= 4) return;

    setState(() {
      enteredPin += number;
    });

    if (enteredPin.length == 4) {
      _handleCompletedPin();
    }
  }

  void _deleteLastDigit() {
    if (enteredPin.isEmpty) return;

    setState(() {
      enteredPin =
          enteredPin.substring(0, enteredPin.length - 1);
    });
  }
  Future<void> _handleCompletedPin() async {
    setState(() {
      isLoading = true;
    });

    switch (widget.mode) {
      case PinMode.create:
        if (!isConfirming) {
          firstPin = enteredPin;

          setState(() {
            enteredPin = "";
            isConfirming = true;
            isLoading = false;
          });

          return;
        }

        if (enteredPin == firstPin) {
          await PinService.savePin(enteredPin);

          if (!mounted) return;

          Navigator.pop(context, true);
        } else {
          _showError("PIN doesn't match");
        }

        break;

      case PinMode.enter:
        final correct = await PinService.verifyPin(enteredPin);

        if (correct) {
          if (!mounted) return;

          Navigator.pop(context, true);
        } else {
          _showError("Wrong PIN");
        }

        break;

      case PinMode.change:
        if (!isConfirming) {
          final correct =
          await PinService.verifyPin(enteredPin);

          if (correct) {
            setState(() {
              enteredPin = "";
              isConfirming = true;
              isLoading = false;
            });

            return;
          } else {
            _showError("Wrong PIN");
          }
        } else {
          await PinService.changePin(enteredPin);

          if (!mounted) return;

          Navigator.pop(context, true);
        }

        break;

      case PinMode.delete:
        final correct =
        await PinService.verifyPin(enteredPin);

        if (correct) {
          await PinService.deletePin();

          if (!mounted) return;

          Navigator.pop(context, true);
        } else {
          _showError("Wrong PIN");
        }

        break;
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );

    setState(() {
      enteredPin = "";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 70),

              Text(
                title,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.dr
                      : AppColors.title,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark
                      ? AppColors.dr
                      : AppColors.subtitle,
                ),
              ),

              const SizedBox(height: 45),

              _buildPinIndicator(),

              const Spacer(),

              _buildKeyboard(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}