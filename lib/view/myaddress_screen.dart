import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/color_extension.dart';
import 'add_delivery_address.dart';

class MyAddresses extends StatefulWidget {
  const MyAddresses({super.key});

  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  @override
  void initState() {
    super.initState();
    // Change the status bar color when the widget initializes
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(255, 14, 78, 239), // Set the status bar color here
    ));
  }

  @override
  void dispose() {
    // Reset the status bar color when the widget is disposed
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Reset the status bar color
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 222, 222),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 14, 78, 239),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            print(";;;;;;");
            Navigator.pop(context); // Handles navigation to previous route
          },
        ),
        title: Text(
          "My Addresses",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddDeliveryAddress()));
              },
              child: Container(
                decoration: BoxDecoration(color: TColor.bg, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset
                  ),
                ]),
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 16,
                          color: Color.fromARGB(255, 14, 78, 239),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add a new address",
                          style: TextStyle(
                              color: Color.fromARGB(255, 14, 78, 239),
                              fontSize: 16),
                        )
                      ],
                    )),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "5 SAVED ADDRESSES",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    color: TColor.bg,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, size: 15),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'edit',
                                  child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'remove',
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Remove'),
                                  ),
                                ),
                              ],
                              onSelected: (String value) {
                                if (value == 'edit') {
                                  // Perform edit action
                                  print('Edit action');
                                } else if (value == 'remove') {
                                  // Perform remove action
                                  print('Remove action');
                                }
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Kiran Gupta",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 50, top: 10, bottom: 10),
                          child: Text(
                            "fnlsnlnldnlfnlsnlfnlsnlfnslfnlsnflnslfnlsnflsnl flnf nlnld sjl jsjl nflsnlflsnlfs",
                            maxLines: 3,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("9471053788"),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
