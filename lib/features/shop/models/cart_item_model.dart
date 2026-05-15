class CartItemModel {
  String itemId;
  String name;
  double price;
  String? image;
  int quantity;
  String description;
  Map<String, dynamic>? includes;
  final String categoryId;
  final String variantKey;

  Map<String, dynamic>? customizationData;
  static const double customizationPrice = 7.99;

  double get customizationCost => customizationData != null ? customizationPrice : 0.0;
  double get totalPrice => (price * quantity) + customizationCost;
  CartItemModel({
    required this.itemId,
    required this.quantity,
    this.image,
    this.price = 0.0,
    this.name = '',
    this.description = '',
    this.includes,
    required this.categoryId,
    required this.variantKey,
    this.customizationData,

  });
  static CartItemModel empty() => CartItemModel(itemId: '', quantity: 0, categoryId: '',variantKey: '',) ;

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'description': description,
      'includes': includes,
      'categoryId': categoryId,
      'customizationData': customizationData,
      "variantKey": variantKey,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json){
    return CartItemModel(
        itemId: json['itemId'],
        name: json['name'],
        price: json['price']?.toDouble(),
        image: json['image'],
        quantity: json['quantity'],
        description: json['description'],
        includes : json['includes'] != null? Map<String,dynamic>.from(json['includes']): null,
        categoryId: json['categoryId'],
      variantKey: json["variantKey"] ?? "",
      customizationData: json['customizationData'] != null
          ? Map<String, dynamic>.from(json['customizationData'])
          : null,

    );
  }
}