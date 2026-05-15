import 'dart:ffi';

class TValidator {
  // Empty Text Validation
  static String? validateEmptyText(String? fieldName , String? value){
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
  }
  // validate cvv
  static String ? validateCvv( String? value ){
       if(value == null ||
           value.length !=3){
         return 'Enter a valid card cvv';
       } else {
         return null;
       }

  }
  // Validate Expiration Date (MM/YYYY)
  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter expiry date';
    }

    // MM/YYYY
    final regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{4}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid expiry date';
    }

    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse(parts[1]);
    final now = DateTime.now();

    final expiry = DateTime(year, month + 1, 0);

    if (expiry.isBefore(now)) {
      return 'Card has expired';
    }

    return null;
  }


  //Empty Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w\.-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'username is required.';
    }
    if (value.length < 3) {
      return 'username must be at least 3 characters' ;
    }
    return null;
  }
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'full name is required.';
    }
    if (value.length < 3) {
      return 'full name must be at least 3 characters' ;
    }
    return null;
  }
  static String? validatePassword(String? value){
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // check for minimum password length
    if(value.length <6){
      return 'Password must be at least 6 characters';
    }
    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {

    String cleanedNumber = value!.replaceAll(RegExp(r'[^\d]'), '');

    // Remove international prefixes
    if (cleanedNumber.startsWith('966')) {
      cleanedNumber = cleanedNumber.substring(3);
    } else if (cleanedNumber.startsWith('971')) {
      cleanedNumber = cleanedNumber.substring(3);
    } else if (cleanedNumber.startsWith('973')) {
      cleanedNumber = cleanedNumber.substring(3);
    } else if (cleanedNumber.startsWith('965')) {
      cleanedNumber = cleanedNumber.substring(3);
    } else if (cleanedNumber.startsWith('968')) {
      cleanedNumber = cleanedNumber.substring(3);
    } else if (cleanedNumber.startsWith('974')) {
      cleanedNumber = cleanedNumber.substring(3);
    }

    // Remove leading zero
    if (cleanedNumber.startsWith('0')) {
      cleanedNumber = cleanedNumber.substring(1);
    }
    // validate each country
    if (cleanedNumber.length == 9 && cleanedNumber.startsWith('5')) {
      return null; // SA
    } else if (cleanedNumber.length == 8 && cleanedNumber.startsWith('5')) {
      return null; // UAE
    } else if (cleanedNumber.length == 8 && cleanedNumber.startsWith('3')) {
      return null; // BH
    } else if (cleanedNumber.length == 7 &&
        RegExp(r'^[569]').hasMatch(cleanedNumber)) {
      return null; // KW
    } else if (cleanedNumber.length == 8 && cleanedNumber.startsWith('9')) {
      return null; // OM
    }
    if (cleanedNumber.length == 7 && RegExp(r'^[37]').hasMatch(cleanedNumber)) {
      return null; // QA
    }

    return 'Please enter a valid phone number';
  }
  // validate gender
  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select gender";
    }
    return null;
  }

}
