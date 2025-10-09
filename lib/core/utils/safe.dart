class Safe {
  // Sync safecall
  static Future<T?> call<T>(Future<T> Function() computation, {Function(dynamic error)? onError}) async {
    try {
      return await computation();
    } catch (error) {
      print('safeCall: $error');
      return null;
    }
  }
}