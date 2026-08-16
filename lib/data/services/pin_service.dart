import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinService {
  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  static const String _pinKey = "user_pin";

  // Save PIN
  static Future<void> savePin(String pin) async {
    await _storage.write(
      key: _pinKey,
      value: pin,
    );
  }

  // Get PIN
  static Future<String?> getPin() async {
    return await _storage.read(
      key: _pinKey,
    );
  }

  // Check if PIN exists
  static Future<bool> hasPin() async {
    final pin = await getPin();
    return pin != null && pin.isNotEmpty;
  }

  // Verify PIN
  static Future<bool> verifyPin(String pin) async {
    final savedPin = await getPin();
    return savedPin == pin;
  }

  // Delete PIN
  static Future<void> deletePin() async {
    await _storage.delete(
      key: _pinKey,
    );
  }

  // Change PIN
  static Future<void> changePin(String newPin) async {
    await savePin(newPin);
  }
}