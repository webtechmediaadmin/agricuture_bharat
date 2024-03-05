import 'package:agriculter_bharat/common/color_extension.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key(""),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Color(0xFFFFE6E6),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [Spacer(), Icon(Icons.delete)],
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            
                          });
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
                                    'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=Q9VRph8N8d9d7sfb2eB7uf-DQgGGFbZPJu5Zdwm3fzg=',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Wireless Controller for PS4",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text.rich(TextSpan(
                                    text: "\$${444.50}",
                                    style: TextStyle(color: Colors.red),
                                    children: [
                                      TextSpan(
                                          text: " x${2}",
                                          style: TextStyle(color: Colors.grey))
                                    ]))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
      ),
      bottomNavigationBar: Container(
        //height: 174,
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: TColor.bg.withOpacity(0.15)
            )
          ]
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
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.receipt_long),
                  ),
                  const Spacer(),
                  const Text("Add Voucher code"),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black,)
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\$337.15",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          )
                        )
                      ]
                    ),
                  ),
                  // SizedBox(
                  //   width: 190,
                  //   child: DefaultB,
                  // )
                ],
              )
        
            ],
          ),
        ),
      ),
    );
  }
}
