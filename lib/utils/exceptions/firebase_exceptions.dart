class TFirebaseException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  TFirebaseException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
    // Firebase Common Errors
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token.';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';

    // Firestore Errors
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'deadline-exceeded':
        return 'The operation timed out. Please try again.';
      case 'not-found':
        return 'The requested document was not found.';
      case 'already-exists':
        return 'A document with this ID already exists.';
      case 'permission-denied':
        return 'You do not have permission to perform this operation.';
      case 'resource-exhausted':
        return 'Resource has been exhausted. Please try again later.';
      case 'failed-precondition':
        return 'Operation was rejected because the system is not in a required state.';
      case 'aborted':
        return 'The operation was aborted.';
      case 'out-of-range':
        return 'Operation was attempted past the valid range.';
      case 'unimplemented':
        return 'Operation is not implemented or not supported.';
      case 'internal':
        return 'Internal system error. Please try again later.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'data-loss':
        return 'Unrecoverable data loss or corruption occurred.';
      case 'unauthenticated':
        return 'The user is not authenticated. Please sign in.';

    // Storage Errors
      case 'object-not-found':
        return 'No object exists at the desired reference.';
      case 'bucket-not-found':
        return 'No bucket is configured for Cloud Storage.';
      case 'project-not-found':
        return 'No project is configured for Cloud Storage.';
      case 'quota-exceeded':
        return 'Quota on your Cloud Storage bucket has been exceeded.';
      case 'unauthenticated':
        return 'User is unauthenticated. Please authenticate and try again.';
      case 'unauthorized':
        return 'User is not authorized to perform the desired action.';
      case 'retry-limit-exceeded':
        return 'The maximum time limit on an operation has been exceeded.';
      case 'invalid-checksum':
        return 'File on the client does not match the checksum of the received file.';
      case 'canceled':
        return 'User canceled the operation.';
      case 'invalid-event-name':
        return 'Invalid event name provided.';
      case 'invalid-url':
        return 'Invalid URL provided.';

    // Realtime Database Errors
      case 'data-stale':
        return 'The data is stale and needs to be refreshed.';
      case 'operation-failed':
        return 'The server indicated that the operation failed.';
      case 'permission-denied':
        return 'Client doesn\'t have permission to access the desired data.';
      case 'disconnected':
        return 'The operation had to be aborted due to a network disconnect.';
      case 'preempted':
        return 'The active or pending auth token was preempted.';
      case 'expired-token':
        return 'The supplied auth token has expired.';
      case 'invalid-token':
        return 'The supplied auth token was invalid.';
      case 'max-retries':
        return 'The transaction had too many retries.';
      case 'overridden-by-set':
        return 'The transaction was overridden by a subsequent set.';

      default:
        return 'An unexpected Firebase error occurred. Please try again.';
    }
  }
}