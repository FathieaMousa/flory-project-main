import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flory/utils/formatters/formatters.dart';


class UserModel {

// Keep those values final which you do not want to update
  final String id;
  String fullName;
  final String email;
  String phoneNumber;
  String profilePicture;
  String gender ;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.gender,


  });

  /// Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);


  /// Static function to create an empty user model.
  static UserModel empty() =>
      UserModel(id: '',
          fullName: '',
          email: '',
          phoneNumber: '',
          profilePicture: '',
          gender: '');

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FullName' : fullName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Gender':gender
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot (DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        fullName: data['FullName'] ?? '',
        gender: data['Gender'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    }else {
      return UserModel.empty();
    }
  }
}