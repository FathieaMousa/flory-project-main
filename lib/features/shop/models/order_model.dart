import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flory/features/shop/models/address_model.dart';
import 'package:flory/features/shop/models/cart_item_model.dart';
import 'package:flory/utils/constants/enums.dart';
import 'package:flory/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final Map<String, dynamic>? customizationData;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'PayPal',
    this.address,
    this.deliveryDate,
    this.customizationData
});

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate!= null ? THelperFunctions.getFormattedDate(deliveryDate!):'';

  String get orderStatusText => status == OrderStatus.delivered ?'Delivered'
      : status == OrderStatus.shipped ? 'Shipping on the way'
      : 'Processing';


  Map<String , dynamic > toJson(){
    return{
      'id':id ,
      'userId': userId,
      'status':status.toString(),
      'totalAmount':totalAmount,
      'orderDate': orderDate,
      'paymentMethod':paymentMethod,
      'address': address?.toJson(),
      'deliveryDate':deliveryDate,
      'items':items.map((item)=> item.toJson()).toList(),
      'customizationData': customizationData,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String , dynamic>;
    return OrderModel( 
        id: data['id'] as String,
        userId: data['userId']as String,
        status: OrderStatus.values.firstWhere((e)=> e.toString() == data['status']),
        totalAmount: data['totalAmount'] as double,
        orderDate: (data['orderDate'] as Timestamp).toDate(),
        paymentMethod: data['paymentMethod'] as String,
        address: AddressModel.fromMap(data['address'] as Map<String , dynamic>),
        deliveryDate: data['deliveryDate'] == null ? null :(data['deliveryDate'] as Timestamp).toDate(),
        items: (data['items'] as List<dynamic>).map((itemData)=> CartItemModel.fromJson(itemData as Map<String , dynamic>)).toList(),
      customizationData: data['customizationData'] != null
          ? Map<String, dynamic>.from(data['customizationData'])
          : null,
    );
  }
}