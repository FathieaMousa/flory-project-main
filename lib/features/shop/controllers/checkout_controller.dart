import 'package:flory/utils/constants/image_strings.dart';
import 'package:flory/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../widgets/payment_tile.dart';
import '../models/PaymentMethodModel.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(image: TImages.paypal , name: 'Paypal');
   super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
        context: context,
        backgroundColor: TColors.primaryBackground,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Payment Method",style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: "Inter",fontWeight: FontWeight.w500),),
                SizedBox(height: TSizes.spaceBtwSections,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: TImages.paypal, name: 'PayPal')),
                SizedBox(height: TSizes.spaceBtwSections/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: TImages.googlePay, name: 'Google Pay')),
                SizedBox(height: TSizes.spaceBtwSections/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: TImages.applePay, name: 'Apple Pay')),
                SizedBox(height: TSizes.spaceBtwSections/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: TImages.visa, name: 'VISA')),
                SizedBox(height: TSizes.spaceBtwSections/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: TImages.masterCard, name: 'Master Card')),
                SizedBox(height: TSizes.spaceBtwSections/2,),

                TPaymentTile(paymentMethod: PaymentMethodModel(image: TImages.creditCard, name: 'Credit Card')),
                SizedBox(height: TSizes.spaceBtwSections/2,),

                SizedBox(height: TSizes.spaceBtwSections,),

              ],
            ),
          ),
        ));
  }

}