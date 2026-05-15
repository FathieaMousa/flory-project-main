import 'package:flory/screens/navigation_items/favourite_icon.dart';
import 'package:flory/widgets/button_add_to_cart.dart';
import 'package:flory/widgets/item_quantity_with_add_remove_button_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../features/shop/controllers/favourites_controller.dart';
import '../../features/shop/models/item_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class Artificialdetailspage extends StatefulWidget {
  const Artificialdetailspage({super.key, required this.item});

  final ItemModel item;


  @override
  State<Artificialdetailspage> createState() => _ArtificialdetailspageState();
}

class _ArtificialdetailspageState extends State<Artificialdetailspage> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
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
              child:  TFavouriteIcon(itemId: widget.item.id,)
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

                  Row(
                    children: [
                      if (widget.item.includes != null) ...[
                         _buildIncludeItem(
                           widget.item.includes?['flower name'] ?? '',
                         )
                      ]
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: SizedBox(
                      width: 281.w,
                      height: 40.h,
                      child: ButtonAddToCart(item: widget.item)
                    ),
                  ) ,

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildIncludeItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width:70.w ,
            height: 70.h,
            decoration: BoxDecoration(
              color: TColors.primary,
              borderRadius: BorderRadius.all(
                Radius.circular(17.r),
              ),
              border: Border.all(
                color: TColors.primary,
                width: 2.w,
              ),
            ),
            child:ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                widget.item.includes?['flower image'] ?? '',
                fit: BoxFit.cover,
              ),
            )


          ),

          const SizedBox(width: 10),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
              child: Text(
                text,
                style: const TextStyle(fontSize: 14,fontFamily: "Inter"),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,

              ),
            ),

        ],
      ),
    );
  }
}