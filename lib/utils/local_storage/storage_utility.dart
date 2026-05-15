import 'package:get_storage/get_storage.dart';

class TLocalStorage {

  late final GetStorage _storage;
  static TLocalStorage? _instance;

  TLocalStorage._internal(this._storage);


  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage._internal(GetStorage(bucketName));
  }

  static TLocalStorage instance() {
    if (_instance == null) {
      throw Exception("TLocalStorage not initialized. Call TLocalStorage.init('cartBox') in main.dart first.");
    }
    return _instance!;
  }
  // factory TLocalStorage.instance() {
  //   _instance ??= TLocalStorage._internal();
  //   return _instance!;
  // }

// static Future<void> init(String bucketName) async {
//   await GetStorage.init(bucketName);
//   _instance = TLocalStorage._internal();
//   _instance!._storage = GetStorage(bucketName);
// }

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  /// Read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Remove specific key
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }
  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}