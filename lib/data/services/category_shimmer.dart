import 'package:flutter/cupertino.dart';

class TCategoryShimmer extends StatelessWidget{
   const TCategoryShimmer({
     super.key,
     this.itemCount = 6,
});

   final int itemCount;

   @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
    );
  }
}