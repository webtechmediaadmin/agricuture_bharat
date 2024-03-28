import 'package:agriculter_bharat/view/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_routes/api_routes.dart';
import '../common/color_extension.dart';
import '../services/cart_services.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final CartController addToCartController = Get.find();

  @override
  void initState() {
    addToCartController.fetchCartData();
    super.initState();
  }

 // int _quantity = 1;

  // void _incrementQuantity() {
  //   setState(() {
  //     _quantity++;
  //   });

  // }

  // void _decrementQuantity() {
  //   if (_quantity > 1) {
  //     setState(() {
  //       _quantity--;
  //     });
  //   }
  // }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    for (var cartItem in addToCartController.fetchCartDataList) {
      totalAmount += (cartItem.totalAmount ?? 0.0) * (cartItem.quantity);
      print("data type amount ${totalAmount.runtimeType}");
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
              'assets/images/png.png', // Replace with your SVG image path
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          SingleChildScrollView(
            child: Padding( padding: const EdgeInsets.only(bottom: 500),
             
              child: Column(
                children: [
                  Obx(
                    () {
                      if (addToCartController.fetchCartDataList == null ||
                          addToCartController.fetchCartDataList.isEmpty) {
                        return const Center(child: Text('Cart is empty'));
                      } else {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                             shrinkWrap: true,
                             physics: const NeverScrollableScrollPhysics(),
                              itemCount: addToCartController.fetchCartDataList.length,
                              itemBuilder: (context, index) {
                                final cartItem = addToCartController.fetchCartDataList[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(vertical: 0),
                                  decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Color(0xff508B51))
                                  ),
                                  child: Dismissible(
                                    key: Key(cartItem.productId!.id.toString()),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFE6E6),
                                        borderRadius: BorderRadius.circular(15),
                                       
                                      ),
                                      child: Row(
                                        children: [Spacer(), Icon(Icons.delete)],
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      setState(() {
                                        addToCartController.fetchCartDataList
                                            .removeAt(index);
                                      });
                                      addToCartController
                                          .deleteAddToCartData(cartItem.id.toString());
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: AspectRatio(
                                            aspectRatio: 0.88,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF5F6F9),
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Image.network(
                                                cartItem.productId!.logo != null
                                                    ? (ApiRoutes.baseUrl +
                                                        cartItem.productId!.logo!)
                                                    : "No Banner Available",
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${cartItem.productId!.title}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text:
                                                        "\u20B9 ${cartItem.totalAmount}",
                                                    style: const TextStyle(
                                                        color: Colors.red, fontSize: 16),
                                                    children: [
                                                      TextSpan(
                                                        text: " x${cartItem.quantity}",
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 25),
                                                Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(10)),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: const Icon(Icons.remove,
                                                            size: 15,
                                                            color: Colors.white),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (cartItem.quantity > 1) {
                                                              cartItem.quantity =
                                                                  cartItem.quantity - 1;
                                                            }
                                                          });
                                                          print(
                                                              "Decreased ${cartItem.quantity.toString()}");
                                                          print(
                                                              "CART ID ${cartItem.id!}");
                                                          print(
                                                              "data type quantityyy ${cartItem.quantity.runtimeType}");
                                                          addToCartController
                                                              .editAddToCartData(
                                                                  cartItem.id!,
                                                                  cartItem.quantity);
                                                        },
                                                      ),
                                                      Text(
                                                        cartItem.quantity.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            cartItem.quantity =
                                                                cartItem.quantity + 1;
                                                          });
                                                          print(
                                                              "Increased ${cartItem.quantity}");
                                                          print(
                                                              "CART ID ${cartItem.id!}");
                                        
                                                          addToCartController
                                                              .editAddToCartData(
                                                                  cartItem.id!,
                                                                  cartItem.quantity)
                                                              .then((value) => print(
                                                                  "increased value"));
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top:  MediaQuery.of(context).size.height * 0.65,
            left: 0,
            right: 0,
            child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: TColor.bg.withOpacity(0.15),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.receipt_long),
                  ),
                  const Spacer(),
                  const Text("Add Voucher code"),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text.rich(
                      TextSpan(text: "Total:\n", children: [
                        TextSpan(
                          text:
                              "\u20B9 ${calculateTotalAmount().toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (calculateTotalAmount() > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OrderSummary(
                                totalAmount: calculateTotalAmount(),
                              )),
                        );
                      }
                    },
                    child: SizedBox(
                      width: 190,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff67A768),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Text(
                            "Check Out",
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
       )
        ],
      ),
      
    );
  }
}
