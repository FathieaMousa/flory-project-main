import 'package:flory/features/shop/models/item_model.dart';
import 'package:flory/screens/navigation_items/favourite_icon.dart';
import 'package:flory/widgets/button_add_to_cart.dart';
import 'package:flory/widgets/item_quantity_with_add_remove_button_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../features/shop/controllers/cart_controller.dart';
import '../../features/shop/controllers/favourites_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/custom_themes/text_theme.dart';
class Detailspage extends StatefulWidget {
  const Detailspage({super.key, required this.item});

  final ItemModel item;

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  final cartController = CartController.instance;

  @override
  void initState() {
    super.initState();
    cartController.updateAlreadyAddedProductCount(widget.item);
  }
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body:
         Stack(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Image.network(
                   widget.item.image,
                    fit: BoxFit.cover,
                    width: 412.w,
                    height: 549.h,

                  ),
                ],
              ),
            ),

            Positioned(
              top: 50.h,
              left: 16.w,
              child: CircleAvatar(
                backgroundColor: dark ? Colors.black : Colors.white,
                child: IconButton(
                  icon: const Icon(Iconsax.arrow_left_2, color: TColors.primary),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            Positioned(
              top: 50.h,
              right: 16.w,
              child: CircleAvatar(
                backgroundColor: dark ? Colors.black : Colors.white,
                child: TFavouriteIcon(itemId: widget.item.id,)
              ),
            ),
            Positioned(
              top:487.h ,
              left: 0.w,
              right: 0.w,
              bottom: 0.h,
              child: Container(
                width: 412.w,
                height: 458.h,
                padding:  EdgeInsets.all(25.r),
                decoration: BoxDecoration(
                  color: dark ? TColors.dark :  TColors.primaryBackground,
                  borderRadius:  BorderRadius.vertical(top: Radius.circular(30.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.item.name,maxLines: 1,
                        style: dark ? TTextTheme.darkTextTheme.labelLarge : TTextTheme.lightTextTheme.labelLarge
                    ),
                    SizedBox(height: 30.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.item.price}',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: TColors.primary,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                         Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              color:TColors.primary ,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding:  EdgeInsets.symmetric(horizontal: 0.w),
                            child: ItemQuantityWithAddRemoveButtonDetails(item: widget.item)
                          ),

                      ],
                    ),
                    SizedBox(height: 10.h),

                    Divider(
                      thickness: 2,
                      color:TColors.primary,
                    ),
                    SizedBox(height: 10.h),

                    Text(
                        'Includes',
                        style: dark ? TTextTheme.darkTextTheme.labelLarge : TTextTheme.lightTextTheme.labelLarge
                    ),
                    SizedBox(height: 8.h),
                    Text(widget.item.description,maxLines: 1,
                      style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontSize: 15.sp
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Center(
                      child: Container(

                        child: ButtonAddToCart(item: widget.item,)
                      ),
                    ) ,

                  ],
                ),
              ),
            ),
          ],
        )

    );
  }
}