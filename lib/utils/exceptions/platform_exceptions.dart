class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
    // Platform Specific Errors
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'internal-error':
        return 'Internal error. Please try again later.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';

    // iOS Specific Errors
      case 'app-not-installed':
        return 'The required app is not installed on your device.';
      case 'invalid-client':
        return 'The authentication server configuration is invalid.';
      case 'invalid-request':
        return 'The authentication request is invalid.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check your device settings.';

    // Android Specific Errors
      case 'invalid-json':
        return 'Invalid JSON response from the server.';
      case 'no-such-algorithm':
        return 'The required cryptographic algorithm is not available.';
      case 'signature-verification-failed':
        return 'Signature verification failed.';

    // Web Specific Errors
      case 'popup-blocked':
        return 'The authentication popup was blocked. Please allow popups for this site.';
      case 'popup-closed-by-user':
        return 'The authentication popup was closed before completing the operation.';
      case 'redirect-cancelled-by-user':
        return 'The redirect operation was cancelled by the user.';
      case 'redirect-operation-pending':
        return 'A redirect operation is already in progress.';

      default:
        return 'An unexpected platform error occurred. Please try again.';
    }
  }
}