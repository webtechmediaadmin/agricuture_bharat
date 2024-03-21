import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/fetch_adress_model.dart';
import '../services/address_services.dart';

class AddDeliveryAddress extends StatefulWidget {
  final bool? isEditing;
  final String? id;
  FetchAddressData? fetchAddressData;
  AddDeliveryAddress(
      {super.key, this.isEditing, this.id, this.fetchAddressData});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddressController addressController = Get.find();
  bool _isError = false;
  bool _showAlternateNumberField = false;
  bool _showLandMarkField = false;

  @override
  void initState() {
    // Change the status bar color when the widget initializes
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(255, 14, 78, 239), // Set the status bar color here
    ));

      if (widget.isEditing == true) {
    editAddress();
  } else {
    resetFormFields();
  }
    super.initState();
  }

  void resetFormFields() {
  addressController.nameController.clear();
  addressController.phoneController.clear();
  addressController.pincodeController.clear();
  addressController.buildingNameController.clear();
  addressController.areaController.clear();
  addressController.landmarkController.clear();
}

  editAddress() {
    addressController.nameController.text = widget.fetchAddressData!.name ?? "";
    addressController.phoneController.text =
        widget.fetchAddressData!.phoneNumber ?? "";
    
    addressController.pincodeController.text =
        widget.fetchAddressData!.pincode ?? "";
     addressController.stateName =
                      addressController.userData["stateName"] ?? "";
                  addressController.cityName =
                      addressController.userData["cityName"] ?? "";    
    addressController.buildingNameController.text =
        widget.fetchAddressData!.buildingName ?? "";
    addressController.areaController.text = widget.fetchAddressData!.area ?? "";
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 14, 78, 239),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            print(";;;;;;");
            Navigator.pop(context); // Handles navigation to previous route
          },
        ),
        title: Text(
          widget.isEditing ?? false ? "Edit Address" : "Add delivery address",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  controller: addressController.nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name(Required)*',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        _isError = true;
                      });
                      return 'Please provide the necessary details';
                    }
                    setState(() {
                      _isError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: addressController.phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone number (Required)*',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        _isError = true;
                      });
                      return 'Please provide the necessary details';
                    }
                    setState(() {
                      _isError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _showAlternateNumberField = true;
                      });
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: _showAlternateNumberField
                          ? Container() // Empty container to occupy space
                          : const Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 14,
                                  color: Color.fromARGB(255, 14, 78, 239),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Add Alternate Phone Number",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 14, 78, 239),
                                      fontSize: 12),
                                )
                              ],
                            ),
                    )),
                if (_showAlternateNumberField)
                  TextFormField(
                    controller: addressController.alternatePhoneController,
                    decoration: InputDecoration(
                      labelText: '+ Add Alternate Phone Number',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _isError ? Colors.red : Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _isError ? Colors.red : Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _isError ? Colors.red : Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          _isError = true;
                        });
                        return 'Please provide the necessary details';
                      }
                      setState(() {
                        _isError = false;
                      });
                      return null;
                    },
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressController.pincodeController,
                  decoration: InputDecoration(
                    labelText: 'Pincode (Required)*',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        _isError = true;
                      });
                      return 'Please provide the necessary details';
                    }
                    setState(() {
                      _isError = false;
                    });
                    return null;
                  },
                  onChanged: (pincode) async {
                    if (pincode.isEmpty) {
                      // Clear city and state names
                      addressController.userData.assignAll({
                        "cityName": null,
                        "stateName": null,
                      });
                    } else {
                      bool success =
                          await addressController.fetchDataByPincode(pincode);
                      if (success) {
                        addressController.cityName =
                            addressController.userData["cityName"];
                        addressController.stateName =
                            addressController.userData["stateName"];
                        print(
                            'City Name: ${addressController.cityName}, State Name: ${addressController.stateName}');
                      } else {
                        // Handle error case
                        print('Failed to fetch city data');
                      }
                    }
                  },
                ),
                const SizedBox(height: 15),
                Obx(() {
                  addressController.stateName =
                      addressController.userData["stateName"];
                  addressController.cityName =
                      addressController.userData["cityName"];
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          //  controller: addressController.stateName.text ?? "",
                          decoration: InputDecoration(
                            labelText: addressController
                                    .pincodeController.text.isNotEmpty
                                ? addressController.userData["stateName"] ??
                                    'State (Required)*'
                                : 'State (Required)*',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isError ? Colors.red : Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isError ? Colors.red : Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isError ? Colors.red : Colors.grey),
                            ),
                          ),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     setState(() {
                          //       _isError = true;
                          //     });
                          //     return 'Please provide the necessary details';
                          //   }
                          //   setState(() {
                          //     _isError = false;
                          //   });
                          //   return null;
                          // },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: addressController
                                    .pincodeController.text.isNotEmpty
                                ? addressController.userData["cityName"] ??
                                    'City (Required)*'
                                : 'City (Required)*',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isError ? Colors.red : Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isError ? Colors.red : Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isError ? Colors.red : Colors.grey),
                            ),
                          ),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     setState(() {
                          //       _isError = true;
                          //     });
                          //     return 'Please provide the necessary details';
                          //   }
                          //   setState(() {
                          //     _isError = false;
                          //   });
                          //   return null;
                          // },
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 15),
                TextFormField(
                  controller: addressController.buildingNameController,
                  decoration: InputDecoration(
                    labelText: 'House No. Building Name (Required)*',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        _isError = true;
                      });
                      return 'Please provide the necessary details';
                    }
                    setState(() {
                      _isError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: addressController.areaController,
                  decoration: InputDecoration(
                    labelText: 'Road name, Area, Colony (Required)*',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isError ? Colors.red : Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        _isError = true;
                      });
                      return 'Please provide the necessary details';
                    }
                    setState(() {
                      _isError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _showLandMarkField = true;
                      });
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: _showLandMarkField
                          ? Container() // Empty container to occupy space
                          : const Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 14,
                                  color: Color.fromARGB(255, 14, 78, 239),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Add Nearby Famous Shop/Mall/Landmark",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 14, 78, 239),
                                      fontSize: 12),
                                )
                              ],
                            ),
                    )),
                if (_showLandMarkField)
                  TextFormField(
                    controller: addressController.landmarkController,
                    decoration: InputDecoration(
                      labelText: '+ Add Nearby Famous Shop/Mall/Landmark',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _isError ? Colors.red : Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _isError ? Colors.red : Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _isError ? Colors.red : Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          _isError = true;
                        });
                        return 'Please provide the necessary details';
                      }
                      setState(() {
                        _isError = false;
                      });
                      return null;
                    },
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (widget.isEditing == true) {
                          Map<String, dynamic> body = {
                            "countryID": "65eaea840c03aecb86469807",
                            "stateID": addressController.userData["stateId"],
                            "cityID": addressController.userData["cityId"],
                            "pincode": addressController.pincodeController.text,
                            "name": addressController.nameController.text,
                            "phoneNumber":
                                addressController.phoneController.text,
                            "type": "Home",
                            "buildingName":
                                addressController.buildingNameController.text,
                            "area": addressController.areaController.text
                          };
                          print("BODY $body");
                          await addressController
                              .editAddress(body, widget.id!)
                              .then((value) {print("Edit profile screen");
                               Navigator.pop(context);
                                addressController.fetchAddresses();
                              }
                              );
                        } else {
                          Map<String, dynamic> body = {
                            "countryID": "65eaea840c03aecb86469807",
                            "stateID": addressController.userData["stateId"],
                            "cityID": addressController.userData["cityId"],
                            "pincode": addressController.pincodeController.text,
                            "name": addressController.nameController.text,
                            "phoneNumber":
                                addressController.phoneController.text,
                            "type": "Home",
                            "buildingName":
                                addressController.buildingNameController.text,
                            "area": addressController.areaController.text
                          };
                          print("BODY $body");
                          await addressController
                              .addressFetch(body)
                              .then((value) {
                            print("Add Add Successfully!..");
                            addressController.pincodeController.clear();
                            addressController.phoneController.clear();
                            addressController.nameController.clear();
                            addressController.buildingNameController.clear();
                            addressController.areaController.clear();
                            addressController.fetchAddresses();
                            Navigator.pop(context);
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.green, // Change the text color here
                      padding: const EdgeInsets.all(
                          16.0), // Adjust padding as needed
                      minimumSize: const Size(
                          double.infinity, 40), // Set button width to full size
                    ),
                    child: Text(
                      widget.isEditing ?? false ? "Update Address" : "Save Address",
                      style: const TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
