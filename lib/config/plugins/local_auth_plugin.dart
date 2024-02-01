import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static avilableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {

    try {
      final bool didAuthenticate = await auth.authenticate(
    localizedReason: 'Por favor autentiquese para continuar',
    options: const AuthenticationOptions(
      biometricOnly: true
      // biometricOnly: true // false podemos colocar el pin 
      ));
      return (didAuthenticate, didAuthenticate ? 'Hecho': 'Cancelado por usuario');
    } on PlatformException catch (e) {
      print('e');
      if (e.code == auth_error.notAvailable)  return (false, 'Biometricos enrolados');
      if (e.code == auth_error.lockedOut) return (false, 'Muchos intentos fallidos');
      if (e.code == auth_error.notAvailable) return (false, 'No hay biometricos disponibles');
      if (e.code == auth_error.passcodeNotSet) return (false, 'No un pin configurado');
      if (e.code == auth_error.permanentlyLockedOut) return (false, 'Se requiere desbloquear el telefono');

      return (false, e.toString());
    }
  }
}
