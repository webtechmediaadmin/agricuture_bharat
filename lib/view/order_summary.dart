import 'package:agriculter_bharat/common/color_extension.dart';
import 'package:agriculter_bharat/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_routes/api_routes.dart';
import '../services/address_services.dart';
import '../services/cart_services.dart';
import '../services/place_order_service.dart';
import 'bottom_nav_bar.dart';
import 'myaddress_screen.dart';

class OrderSummary extends StatefulWidget {
 final double  totalAmount;
  const OrderSummary({super.key, required this.totalAmount});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  final AddressController addressController = Get.find();
  final CartController cartController = Get.find();
  final PlaceOrderController placeOrderController = Get.find();

  @override
  void initState() {
    super.initState();

   fetchData();
   cartController.fetchCartData();
  
  }


  void fetchData() async {
    try {
      // Fetch addresses
      await addressController.fetchAddresses();

      // Update the UI after data is fetched
      setState(() {});
    } catch (error) {
      // Handle errors here
      print("Error fetching addresses: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 222, 222),
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Container(
                color: TColor.bg,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Deliver to: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final selectedAddress = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MyAddresses(
                                    onAddressSelected: (address) {
                                      setState(() {
                                        addressController.addressDataList
                                            .assignAll([address]);
                                      });
                                    },
                                  ),
                                ),
                              );
                              if (selectedAddress != null) {
                                setState(() {
                                  addressController.addressDataList
                                      .assignAll([selectedAddress]);
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.35)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Change",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 8, 65, 93)),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (addressController.addressDataList.isNotEmpty)
                        Text(
                          addressController.addressDataList[0].name ?? "",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      if (addressController.addressDataList.isNotEmpty)
                        const SizedBox(height: 10),
                      if (addressController.addressDataList.isNotEmpty)
                        Text(
                          addressController.addressDataList[0].area ?? "",
                          maxLines: 3,
                          style: TextStyle(fontSize: 15),
                        ),
                      if (addressController.addressDataList.isNotEmpty)
                        const SizedBox(height: 10),
                      if (addressController.addressDataList.isNotEmpty)
                        Text(
                          addressController.addressDataList[0].phoneNumber ?? "",
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
             ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartController.fetchCartDataList.length,
                    itemBuilder: (context, index) {
                       final cartItem = cartController.fetchCartDataList[index];
                      return Column(
                        children: [
                          Container(
                            color: TColor.bg,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Image.network(
                                                  cartItem.productId!.logo != null
                                            ? (ApiRoutes.baseUrl +
                                                cartItem.productId!.logo!)
                                            : "",
                                              height: 80,
                                              width: 80,
                                            ),
                                            const SizedBox(height: 10),
                                            Text.rich(
                                              TextSpan(
                                                text: "Quantity",
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                                children: [
                                                  TextSpan(
                                                    text: " ${cartItem.quantity}",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${cartItem.productId!.title}"),
                                            Text("${cartItem.productId!.discountedPrice}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text("Deliver by Tue Mar 12"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
            
              const SizedBox(height: 10),
              Container(
                color: TColor.bg,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price Details",
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price (${cartController.fetchCartModel!.count} items)",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          Text(
                            "\u20B9 ${widget.totalAmount.toStringAsFixed(2)}" ,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          Text(
                            "- \u20B9 0.0",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Charges",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          Text(
                            "\u20B9 FREE Delivery",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            "\u20B9${widget.totalAmount.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(text: "Total:\n", children: [
                      TextSpan(
                        text: "\u20B9 ${widget.totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      placeOrderController.placeOrder(addressController.addressDataList[0].id!).then((value) => 
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BottomNavBar()))
                      );
                    


                    },
                    child: SizedBox(
                      width: 190,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Proceed to Pay",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
