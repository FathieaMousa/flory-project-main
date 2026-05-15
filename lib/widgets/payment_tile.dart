import 'package:flory/features/shop/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../features/shop/models/PaymentMethodModel.dart';
import '../utils/constants/colors.dart';

class TPaymentTile extends StatelessWidget{
  const TPaymentTile({super.key , required this.paymentMethod});

  final PaymentMethodModel paymentMethod;


  @override
  Widget build(BuildContext context) {
   final controller = CheckoutController.instance;
   return  InkWell(
     onTap: (){
       controller.selectedPaymentMethod.value = paymentMethod;
       Get.back();
     },
     child: Container(
       width: 300.w,
       height: 47.h,
       decoration: BoxDecoration(
           color: Colors.transparent,
           borderRadius: BorderRadius.circular(6.r)
       ),
       child: Row(
         children: [
          // SizedBox(width: 5.w,),
           Container(
             width: 70,
             height: 70,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(20.r)
             ),
               child: Image.asset(paymentMethod.image,width: 20.w,height: 20.h,)),
           SizedBox(width: 25.w,),
           Text(paymentMethod.name,style: TextStyle(fontFamily: "Inter",fontSize: 16.sp,color: Colors.black),),
           SizedBox(width: 45.w,),

         ],
       ),
     ),
   );
  }


}