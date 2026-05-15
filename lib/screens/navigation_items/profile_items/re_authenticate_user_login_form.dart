import 'package:flory/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/authentication/controllers/login_controller/user_controller.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/validators/validation.dart';
import '../../../widgets/login_text_fields.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance ;
    return Scaffold(
      appBar: AppBar(title:
      const Text('Delete account', style: TextStyle(
        fontFamily: 'Inter'
      ),)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Email
                LoginTextFields(
                  validator: (value)=>TValidator.validateEmail(value),
                  controller: controller.verifyEmail,
                  hintText: 'Email',
                  icon: CupertinoIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox (height: TSizes.spaceBtwInputFields),
                // Password Field
                Obx(
                      ()=> LoginTextFields(
                    validator: (value)=>TValidator.validatePassword(value),
                    controller: controller.verifyPassword,
                    hintText: 'Password',
                    icon: CupertinoIcons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.hidePassword.value,
                    suffixIcon: IconButton(
                      icon: Icon( controller.hidePassword.value ?Iconsax.eye_slash : Iconsax.eye),
                      onPressed: ()=> controller.hidePassword.value= !controller.hidePassword.value,
                    ),
                  ),
                ),
                const SizedBox (height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: TColors.primary,
                       foregroundColor: TColors.white,
                     ),
                       onPressed: ()=> controller.reAuthenticateEmailAndPasswordUser(),
                       child: const Text("verify")),
                ),


              ],
            ),

          ),
        ),
      ),
    );
  } }