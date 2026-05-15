class TFirebaseAuthException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  TFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
    // Common Authentication Errors
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';

    // Phone Authentication Errors
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';
      case 'missing-phone-number':
        return 'Please provide a phone number.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';

    // Multi-factor Authentication Errors
      case 'multi-factor-auth-required':
        return 'Multi-factor authentication is required for this operation.';
      case 'multi-factor-enrollment-not-found':
        return 'Multi-factor authentication enrollment not found.';
      case 'second-factor-already-in-use':
        return 'The second factor is already enrolled.';

    // Provider Linking Errors
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'no-such-provider':
        return 'The specified provider does not exist.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';

    // Token and Session Errors
      case 'invalid-user-token':
        return 'The user\'s credential is no longer valid. Please sign in again.';
      case 'user-token-expired':
        return 'The user\'s credential has expired. Please sign in again.';
      case 'invalid-auth-event':
        return 'An internal authentication error occurred.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect.';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';

    // Network and Operation Errors
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'web-storage-unsupported':
        return 'Web storage is not supported or is disabled.';

    // App and Project Configuration Errors
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication.';
      case 'invalid-api-key':
        return 'Invalid API key. Please check your configuration.';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'invalid-message-payload':
        return 'The email template validation failed.';
      case 'invalid-sender':
        return 'The email template has an invalid sender.';
      case 'invalid-recipient-email':
        return 'The email template has an invalid recipient.';

    // Other Common Errors
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid code.';
      case 'missing-android-pkg-name':
        return 'An Android package name must be provided.';
      case 'missing-continue-uri':
        return 'A continue URL must be provided.';
      case 'missing-ios-bundle-id':
        return 'An iOS Bundle ID must be provided.';

    // Default case for unknown errors
      default:
        return 'An unexpected authentication error occurred. Please try again.';
    }
  }
}