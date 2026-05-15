class TPricingCalculator{
  static double calculateTotalPrice (double subTotal , String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = subTotal + taxAmount + shippingCost;
    return totalPrice;
  }


  static String calculateShippingCost(double subTotal , String location){
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculateTax(double subTotal , String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * taxRate;
    return taxAmount.toStringAsFixed(2);
  }


  static double getTaxRateForLocation(String location){
    return 0.10;
  }

  static double getShippingCost(String location){
    return 4.99;
  }
}