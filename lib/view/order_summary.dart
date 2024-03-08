import 'package:agriculter_bharat/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
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
        child: Column(
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
                        Container(
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
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Kiran Gupta",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "fnlsnlnldnlfnlsnlfnlsnlfnslfnlsnflnslfnlsnflsnl flnf nlnld sjl jsjl nflsnlflsnlfs",
                      maxLines: 3,
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Text("9471053788")
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
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
                                          'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
                                          height: 80,
                                          width: 80,
                                        ),
                                        const SizedBox(height: 10),
                                        Text.rich(
                                          TextSpan(
                                            text:
                                                "Quantity",
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 15),
                                            children: [
                                              TextSpan(
                                                text: " 2",
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("PUMA Rebound Layup Wide High... ...."),
                                        Text("Price"),

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
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                    const SizedBox(height: 20,),    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          "Price (2 items)",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey),
                        ),
                         Text(
                          "\u20B920,149",
                           style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
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
                              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey),
                        ),
                         Text(
                          "- \u20B91,149",
                           style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.green),
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
                              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey),
                        ),
                         Text(
                          "\u20B940 FREE Delivery",
                           style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
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
                              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
                        ),
                         Text(
                          "\u20B90",
                           style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
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
                          text:
                              "\u20B9 ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                    ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OrderSummary()));
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
