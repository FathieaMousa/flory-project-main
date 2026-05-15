import 'package:flory/features/shop/controllers/order_controller.dart';
import 'package:flory/utils/constants/colors.dart';
import 'package:flory/utils/helpers/cloud_helper_functions.dart';
import 'package:flory/widgets/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'ordertracking.dart';

class TOrdersList extends StatelessWidget {
  const TOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        // nothing found
        final emptyWidget = Center(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.box_remove,
                  size: 60,
                  color: dark ? TColors.darkGrey : TColors.grey,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  'No orders yet',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                Text(
                  'Start shopping and saving your memories!',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() =>  NavigationController().goToHome());
                  },
                  child: const Text('Explore'),
                ),
              ],
            ),
          ),
        );
        final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
        if(response != null) return response;

        // record found
        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __)=>const SizedBox(height: TSizes.spaceBtwItems,),
          itemBuilder: (_, index) {
            final order = orders[index];
           return Container(
             decoration: BoxDecoration(
               color: TColors.textFieldsColor ,
               borderRadius: BorderRadius.circular(30)
             ),
              padding: const EdgeInsets.all(TSizes.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      // Icon
                      const Icon(Iconsax.ship),
                      const SizedBox(width: TSizes.spaceBtwItems/2,),
                      // status and date
                      Expanded(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           order.orderStatusText,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(color:TColors.primary, fontWeightDelta: 1),
                          ),
                          Text(order.formattedDeliveryDate , style: Theme.of(context).textTheme.headlineSmall,)
                        ],
                      )),
                      IconButton(
                          onPressed: (){
                            Get.to(() => Ordertracking(order: order));
                          },
                          icon: const Icon(Iconsax.arrow_right_34 ,
                            size: TSizes.iconSm,
                          )),
                    ],
                  ) , const SizedBox(height: TSizes.spaceBtwItems,) ,
                  Row(
                    children: [
                      // Order No
                      Expanded(
                          child: Row(
                        children: [
                          const Icon(Iconsax.tag),
                          const SizedBox(width: TSizes.spaceBtwItems/2,),
                          // Order
                          Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order', style: Theme.of(context).textTheme.labelMedium,maxLines: 1,),
                                  Text(order.id ,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleMedium,)
                                ],
                              )
                          )
                        ],
                      )
                      ) ,
                      /// Delivery Date
                      Expanded(
                          child:Row(
                            children: [
                              const Icon(Iconsax.calendar),
                              const SizedBox(width: TSizes.spaceBtwItems/2,),
                              // status and date
                              Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Shipping Date',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ) ,
                                      Text(
                                        order.formattedDeliveryDate,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      )
                                    ],
                                  )
                              )
                            ],
                          ) )
                    ],
                  )
                ],
              ),
            );
          },
        
        );
      }
    );
  }
}
