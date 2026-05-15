import 'package:flory/features/shop/controllers/cart_controller.dart';
import 'package:flory/features/shop/models/cart_item_model.dart';
import 'package:flory/screens/navigation_items/profile_items/newdeliveryaddress.dart';
import 'package:flory/screens/navigation_items/shopping_items/checkout.dart';
import 'package:flory/utils/loader/loaders.dart';
import 'package:flory/utils/validators/validation.dart';
import 'package:flory/widgets/animation_loader_widget.dart';
import 'package:flory/widgets/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flory/widgets/item_qantity_with_add_remove_button.dart';
import '../../features/shop/models/address_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/helpers/pricing_calculator.dart';
import '../../utils/theme/custom_themes/text_theme.dart';


class ShoppingBag extends StatelessWidget {
  const ShoppingBag({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        body:SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Shopping Bag",
                      style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
                        fontFamily: 'LibreBaskerville',
                        fontSize: 24.sp,
                        color: dark ? TColors.light : TColors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0).w,
                    child: Text(
                      "Check out now & keep the beauty.",
                      style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),
                  Obx(() {
                    final emptyWidget = AnimationLoaderWidget(
                      text: 'Woops! cart is empty',
                      animation: TImages.loaderAsset,
                      showAction: true,
                      actionText: 'Let\'s fill it',
                      onActionPressed: () => Get.off(() => const NavigationMenu()),

                    );
                    if(controller.cartItems.isEmpty){
                      return emptyWidget;
                    }else{
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = controller.cartItems[index];

                          if (item.variantKey == "customization") {
                            return ProductCardWithCustomization(
                              title: item.name,
                              imagePath: item.image ?? '',
                              price: (item.price * item.quantity).toStringAsFixed(1),
                              item: item,
                            );
                          } else {
                            return ProductCardSimple(
                                title: item.name,
                                imagePath: item.image ?? '',
                                price: (item.price * item.quantity).toStringAsFixed(1),
                                item: item
                            );

                          }
                        },
                      );
                    }

                  }),

                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity.w,
                    height: 55.h,
                    padding: EdgeInsets.fromLTRB(35.w, 5.h, 35.w, 5.h),
                    child: Stack(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "promo code",
                            hintStyle: TextStyle(
                              color: TColors.primary70,
                              fontSize: 16.sp,
                            ),
                            filled: true,
                            fillColor: dark ? TColors.primary40 : TColors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 6.w,
                          top: 6.h,
                          width: 97.w,
                          height: 32.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primary,
                              //color : ,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                color: TColors.white,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SubTotal",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Obx(() => Text(
                              '\$${controller.totalCartPrice.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            ),
                          ],
                        ),
                        Divider(thickness: 2, color: TColors.white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Obx(() {
                              final subTotal = controller.totalCartPrice.value;
                              return Text(
                                "\$${TPricingCalculator.calculateShippingCost(subTotal, 'Us')}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            })


                          ],
                        ),
                        Divider(thickness: 2, color: TColors.white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tax Fee",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Obx(() {
                              final subTotal = controller.totalCartPrice.value;
                              return  Text(
                                "\$${TPricingCalculator.calculateTax(subTotal, 'US')}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            })

                          ],
                        ),
                        Divider(thickness: 2, color: TColors.white),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bag Total (${controller.cartItems.length}Items)",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Obx(() {
                              final subTotal = controller.totalCartPrice.value;
                              return Text(
                                '\$${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            })

                          ],
                        ),
                        SizedBox(height: 25.h),
                        SizedBox(
                          width: 260.w,
                          height: 38.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if(controller.cartItems.isEmpty){
                                Loaders.warningSnackBar(title: 'Your cart is empty', message: "Lets explore and fill it");
                              } else {
                                Get.to(() =>Checkout());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: TColors.white,
                              foregroundColor: TColors.primary,
                              elevation: 5,
                              shadowColor: TColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            child: Text("Checkout"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),

            ),
          ),
        )
    );

  }
}
class ProductCardWithCustomization extends StatefulWidget {
  final String title;
  final String imagePath;
  final String price;
  final bool showAddRemoveButtons;
  final CartItemModel item;

  const ProductCardWithCustomization({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
    this.showAddRemoveButtons = true,required this.item,
  });

  @override
  State<ProductCardWithCustomization> createState() =>
      _ProductCardWithCustomizationState();
}

class _ProductCardWithCustomizationState extends State<ProductCardWithCustomization> {
  _ProductCardWithCustomizationState();

  final nameCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final msgCtrl = TextEditingController();
  final deliveryCtrl = TextEditingController();
    GlobalKey<FormState> customizeFormKey =GlobalKey<FormState>();
  String? selectedOption;
  void _loadStoredCustomizationData() {
    final cartController = CartController.instance;
    final hasCustomization = cartController.hasCustomization(widget.item.itemId);

    if (hasCustomization) {
      final customizationData = cartController.getCustomizationData(widget.item.itemId);
      if (customizationData != null) {
        nameCtrl.text = customizationData['name'] ?? '';
        dateCtrl.text = customizationData['date'] ?? '';
        msgCtrl.text = customizationData['message'] ?? '';
        deliveryCtrl.text = customizationData['deliveryAddress'] ?? '';
        selectedOption = customizationData['flowerOption'];
      }
    }
  }
  void _saveCustomizationData(bool isCustomFlower) {
    if (customizeFormKey.currentState!.validate()) {
      CartController.instance.updateItemCustomization(
        itemId: widget.item.itemId,
        name: nameCtrl.text.trim(),
        date: dateCtrl.text.trim(),
        message: msgCtrl.text.trim(),
        deliveryAddress: isCustomFlower ? deliveryCtrl.text.trim() : null,
        flowerOption: selectedOption,
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    dateCtrl.dispose();
    msgCtrl.dispose();
    deliveryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    final item = widget.item;
    return Stack(
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(side: BorderSide.none),
          color: dark ? TColors.blackF : TColors.primaryBackground,
          margin: EdgeInsets.symmetric(vertical: 2.h),
          child: Padding(
            padding: EdgeInsets.all(5.w.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Card(
                      shadowColor: TColors.primary,
                      color: TColors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: TColors.primary),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.w.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            item.image ?? '',
                            width: 102.w,
                            height: 113.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: TColors.primary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            (item.price * item.quantity)
                                .toStringAsFixed(
                                1),
                            // item.price.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 33.h,
                        //width: 40.w,
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: ItemQantityWithAddRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () =>
                              cartController.removeOneFromCart(item),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(0),
                      width: 160.w,
                      height: 32.h,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                              EdgeInsets.zero),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                          side: WidgetStateProperty.all(
                            BorderSide(color: TColors.primary),
                          ),
                        ),
                        onPressed: () {
                          final RenderBox renderBox = context
                              .findRenderObject() as RenderBox;
                          final position = renderBox.localToGlobal(
                              Offset.zero);
                          _customizationOrderDialog(context, position);
                        },
                        child: Text(
                          'Customize Your Order',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: dark ? TColors.white : TColors
                                .blackF,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),
                    Container(
                        width: 160.w,
                        height: 32.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: TColors.primary),
                          borderRadius: BorderRadius.circular(8.r),
                          color:
                          dark ? TColors.blackF : TColors
                              .primaryBackground,
                        ),
                        child: PopupMenuButton<String>(
                          borderRadius: BorderRadius.circular(20),
                          color: dark ? TColors.black : TColors
                              .primaryBackground,
                          position: PopupMenuPosition.under,
                          onSelected: (value) {
                            setState(() => selectedOption = value);
                            if (value == 'Use your own') {
                              final RenderBox renderBox = context
                                  .findRenderObject() as RenderBox;
                              final position = renderBox.localToGlobal(
                                  Offset.zero);
                              _cutomFlowerDialog(context, position);
                            }
                          },
                          itemBuilder: (context) =>
                          [
                            PopupMenuItem(
                              value: 'Use your own',
                              child: Text('Use your own',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: dark ? Colors.white : Colors
                                        .black
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Use Flory',
                              child: Text('Use Flory', style: TextStyle(
                                  fontSize: 16,
                                  color: dark ? Colors.white : Colors
                                      .black

                              ),),
                            ),
                          ],
                          child: Row(
                            children: [
                              Text(selectedOption ?? "The Flowers",
                                style: TextStyle(
                                    fontSize: 14.sp
                                ),),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );

  }

  void _customizationOrderDialog(BuildContext context , Offset position) {
    final dark = THelperFunctions.isDarkMode(context);
    _loadStoredCustomizationData();

    showDialog(
      barrierColor: dark ? TColors.black.withOpacity(0.7) :TColors.primaryBackground.withOpacity(0.8),
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: position.dy +130 .h,
              left: position.dx +20.w,
              child: Material(
                color: Colors.transparent,
                shadowColor: TColors.primary,
                elevation: 10,
                child: Container(
                  width: 352.w,
                  height: 365.h,
                  decoration: BoxDecoration(
                    color: dark ? TColors.black : TColors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r)
                    ),
                  ),
                  padding: EdgeInsets.all(10.w),
                  child: Form(
                    key: customizeFormKey ,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDialogField(context,
                            "Name or Initials",
                            "Add a name, or just initials.",
                            nameCtrl
                        ) ,
                        _buildDialogField(context,
                            "Special Date",
                            "Wedding date, proposal day, or any moment.",
                            dateCtrl
                        ) ,
                        _buildDialogField(context,
                            "Short Message",
                            "A few words you want to keep forever",
                            msgCtrl
                        ) ,
                        Divider(
                          thickness: 1,
                          color: TColors.primary70,
                        ) ,
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Customize Your Order",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: dark ? TColors.white :Colors.black,
                              ),
                            ),
                            Text(
                              "\$7.99 USD",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: dark ? TColors.white :Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        // Confirm Button
                        Center(
                          child: SizedBox(
                            width: 281.w,
                            height:40.h ,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:TColors.primary,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              onPressed: () {
                                _saveCustomizationData(false);                              },
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  color: TColors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _cutomFlowerDialog(BuildContext context , Offset position) {
    final dark = THelperFunctions.isDarkMode(context);
    _loadStoredCustomizationData();

    showDialog(
      barrierColor: dark ? TColors.black.withOpacity(0.7) :TColors.primaryBackground.withOpacity(0.8),
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: position.dy +130 .h,
              left: position.dx +20.w,
              child: Material(
                color: Colors.transparent,
                shadowColor: TColors.primary,
                elevation: 10,
                child: Container(
                  width: 352.w,
                  height: 477.h,
                  decoration: BoxDecoration(
                    color: dark ?TColors.black :TColors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r)
                    ),
                  ),
                  padding: EdgeInsets.all(10.w),
                  child: Form(
                    key: customizeFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDialogField(context,
                            "Name or Initials",
                            "Add a name, or just initials.",
                            nameCtrl
                        ) ,
                        _buildDialogField(context,
                            "Special Date",
                            "Wedding date, proposal day, or any moment.",
                            dateCtrl
                        ) ,

                        _buildDialogField(context,
                            "Short Message",
                            "A few words you want to keep forever",
                            msgCtrl
                        ) ,
                        _buildAddressDropdown( context, CartController.instance),
                        Divider(
                          thickness: 1,
                          color: TColors.primary70,
                        ) ,
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Frame Base Price", style: TextStyle(
                              fontSize: 16.sp,
                              color: dark ? Colors.white : Colors.black,
                            ),), Text(
                              "\$7.99 USD",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: dark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Customize Your Order",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: dark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              "\$7.99 USD",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: dark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        // Confirm Button
                        Center(
                          child: SizedBox(
                            width: 281.w,
                            height:40.h ,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:TColors.primary,
                                padding: EdgeInsets.zero.r,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              onPressed: () {
                                _saveCustomizationData(true);                            },
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  color: TColors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _buildDialogField(BuildContext context ,String tittle, String hint , TextEditingController controller){
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // tittle
        Text(
          tittle,
          style: TextStyle(
            fontSize: 16.sp,
            color: dark ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 330.w,
          height: 35.h,
          child: TextFormField(
            validator:(value)=>TValidator.validateEmptyText(tittle, value),
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5.w.h),
              hintText: hint,
              hintStyle: TextStyle(
                  color: TColors.primary
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                    width: 1.w,
                    color: TColors.primary70
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                    width: 1.w,
                    color: TColors.primary70
                ),
              ),
              focusedBorder:
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                    width: 1.w,
                    color: TColors.primary70
                ),
              ),
            ),

          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );

  }
  Widget _buildAddressDropdown(BuildContext context, CartController cartController) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Address",
          style: TextStyle(fontSize: 16.sp, color: dark ? Colors.white : Colors.black),
        ),
        SizedBox(height: 8.h),

        Obx(() {
          cartController.addressController.refreshData.value;

          return FutureBuilder<List<AddressModel>>(
            future: cartController.addressController.getAllUserAddresses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: 330.w, height: 45.h,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: TColors.primary),
                );
              }

              final addresses = snapshot.data ?? [];
              final addressStrings = addresses.map((addr) => '${addr.street}, ${addr.city}').toList();

              return Column(
                children: [
                  Container(
                    width: 330.w, height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: TColors.primary70, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: cartController.selectedAddress.value.isEmpty ? null : cartController.selectedAddress.value,
                        isExpanded: true,
                        hint: Text(
                          cartController.selectedAddress.value.isNotEmpty
                              ? cartController.selectedAddress.value
                              : 'Select Address',
                          style: TextStyle(color: TColors.primary, fontSize: 14.sp),
                        ),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'add_new',
                            child: Row(
                              children: [
                                Icon(Icons.add, size: 18, color: TColors.primary),
                                SizedBox(width: 8.w),
                                Text('Add New Address', style: TextStyle(color: TColors.primary, fontSize: 14.sp)),
                              ],
                            ),
                          ),
                          // فصل
                          DropdownMenuItem<String>(
                            value: 'divider',
                            enabled: false,
                            child: Container(
                              height: 1.h,
                              color: TColors.primary70,
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                            ),
                          ),
                          // العناوين
                          ...addressStrings.map((address) =>
                              DropdownMenuItem(
                                value: address,
                                child: Text(address, style: TextStyle(fontSize: 14.sp)),
                              )
                          ).toList(),
                        ],
                        onChanged: (newValue) {
                          if (newValue == 'add_new') {
                            Get.to(() => Newdeliveryaddress());
                          } else if (newValue != null && newValue != 'divider') {
                            cartController.selectedAddress.value = newValue;
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),


                ],
              );
            },
          );
        }),
      ],
    );
  }
}

class ProductCardSimple extends StatelessWidget {
  final String title;
  final String imagePath;
  final String price;
  final bool showAddRemoveButtons;
  final CartItemModel item;


  const ProductCardSimple({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
    this.showAddRemoveButtons = true, required this.item
  });


  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return SizedBox(
        width: double.infinity.w,
        height: 140.h,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(side: BorderSide.none),
          color: dark ? TColors.blackF : TColors.primaryBackground,
          margin: EdgeInsets.symmetric(vertical: 0),
          child: Padding(
            padding: EdgeInsets.all(5.w.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Card(
                      shadowColor: TColors.primary,
                      color: TColors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: TColors.primary),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.w.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            item.image ?? '',
                            width: 102.w,
                            height: 113.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: TColors.primary,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text((item.price * item.quantity)  .toStringAsFixed(
                              1),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 33.h,
                        //width: 40.w,
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: ItemQantityWithAddRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () =>
                              cartController.removeOneFromCart(item),
                        )
                    ),

                  ],
                ),
              ],
            ),
          ),
        )

    );


  }
}