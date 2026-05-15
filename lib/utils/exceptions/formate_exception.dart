class TFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const TFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  /// Create a format exception from a specific error message.
  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const TFormatException('The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const TFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const TFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const TFormatException('The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const TFormatException('The input should be a valid numeric format.');
      case 'invalid-name-format':
        return const TFormatException('The name format is invalid. Please use only letters and spaces.');
      case 'invalid-username-format':
        return const TFormatException('Username can only contain letters, numbers, and underscores.');
      case 'invalid-password-format':
        return const TFormatException('Password must meet the required security criteria.');
      case 'invalid-postal-code-format':
        return const TFormatException('The postal code format is invalid for your region.');
      case 'invalid-currency-format':
        return const TFormatException('The currency format is invalid.');
      case 'invalid-time-format':
        return const TFormatException('The time format is invalid. Please use HH:MM format.');
      case 'invalid-json-format':
        return const TFormatException('The JSON format is invalid. Please check your input.');
      case 'invalid-xml-format':
        return const TFormatException('The XML format is invalid. Please check your input.');
      case 'invalid-base64-format':
        return const TFormatException('The Base64 format is invalid.');
      case 'invalid-hex-format':
        return const TFormatException('The hexadecimal format is invalid.');
      case 'invalid-uuid-format':
        return const TFormatException('The UUID format is invalid.');
      case 'invalid-ip-format':
        return const TFormatException('The IP address format is invalid.');
      case 'invalid-mac-format':
        return const TFormatException('The MAC address format is invalid.');

      default:
        return const TFormatException('An invalid format was provided. Please check your input.');
    }
  }
}