import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../common/color_extension.dart';
import '../models/fetch_adress_model.dart';
import '../services/address_services.dart';
import 'add_delivery_address.dart';

class MyAddresses extends StatefulWidget {
  final void Function(FetchAddressData)? onAddressSelected;
  const MyAddresses({super.key, this.onAddressSelected});

  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  final AddressController addressController = Get.find();

  @override
  void initState() {
    super.initState();
    // Change the status bar color when the widget initializes
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: const Color(0xff67A768), // Set the status bar color here
    ));
    addressController.fetchAddresses();
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            "My Addresses",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: TColor.bg),
            onPressed: () {
              Navigator.pop(context); // Handles navigation to previous route
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff4B844D),
                  Color(0xff111E12),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/png.png', // Replace with your SVG image path
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddDeliveryAddress()));
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 16,
                                color: Color(0xff67A768),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Add a new address",
                                style: TextStyle(
                                    color: Color(0xff67A768), fontSize: 16),
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
                  addressController.addressDataList.isNotEmpty &&
                          addressController.addressDataList != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: addressController.addressDataList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                final selectedAddress =
                                    addressController.addressDataList[index];
                                if (widget.onAddressSelected != null) {
                                  widget.onAddressSelected!(selectedAddress);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Address selected: ${selectedAddress.name}'),
                                    ),
                                  );
                                }
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: TColor.bg,
                                      border:
                                          Border.all(color: Color(0xff5DA35F)),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          PopupMenuButton<String>(
                                            icon: const Icon(Icons.more_vert,
                                                size: 15),
                                            itemBuilder:
                                                (BuildContext context) =>
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
                                                Get.to(() => AddDeliveryAddress(
                                                      isEditing: true,
                                                      id: addressController
                                                          .addressDataList[
                                                              index]
                                                          .id,
                                                      fetchAddressData:
                                                          addressController
                                                                  .addressDataList[
                                                              index],
                                                    ));
                                              } else if (value == 'remove') {
                                                // Perform remove action
                                                print('Remove action');
                                                addressController
                                                    .deleteAddress(
                                                        addressController
                                                            .addressDataList[
                                                                index]
                                                            .id
                                                            .toString())
                                                    .then((value) =>
                                                        addressController
                                                            .fetchAddresses());
                                              } else if (value == 'select') {
                                                // Pass the selected address back to the previous page
                                                if (widget.onAddressSelected !=
                                                    null) {
                                                  final selectedAddress =
                                                      addressController
                                                              .addressDataList[
                                                          index];
                                                  print(
                                                      'Selected Address: $selectedAddress'); // Print selected address
                                                  widget.onAddressSelected!(
                                                      selectedAddress);
                                                }
                                                Navigator.pop(
                                                    context); // Close the MyAddresses page
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          addressController
                                                  .addressDataList[index]
                                                  .name ??
                                              "",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 50,
                                            top: 10,
                                            bottom: 10),
                                        child: Text(
                                          ("${addressController.addressDataList[index].buildingName}, ${addressController.addressDataList[index].area}, ${addressController.addressDataList[index].cityId?.name}, ${addressController.addressDataList[index].stateId?.name}, ${addressController.addressDataList[index].countryId?.name} ,${addressController.addressDataList[index].pincode}"),
                                          maxLines: 3,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(addressController
                                                .addressDataList[index]
                                                .phoneNumber ??
                                            ""),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : const Center(
                          child: Text(
                            'Add Address',
                            style: TextStyle(
                                color: Color(0xff67A768), fontSize: 20),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
