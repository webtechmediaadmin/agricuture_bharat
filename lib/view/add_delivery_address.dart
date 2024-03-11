import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../services/address_services.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({super.key});

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
    addressController.pincodeController.clear();
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
          "Add delivery address",
          style: TextStyle(color: Colors.white),
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
                      
                      print("PINCOD DATA ${addressController.pincodeController.text}");
                      print("pincode data $pincode");
                    if(addressController.pincodeController.text.isNotEmpty){
                      bool success = await addressController.fetchDataByPincode(pincode);
                      if(success){
                           addressController.cityName = addressController.userData["cityName"];
                        addressController.stateName = addressController.userData["stateName"];
                        // countryName = cityController.userData["countryName"];

                         print(
                            'City Name: ${addressController.cityName}, State Name: ${addressController.stateName}');
                      } 
                      else {
                        // Handle error case
                        print('Failed to fetch city data');
                      }
                    }
                  },
                ),
                const SizedBox(height: 15),
                Obx(
                  () { 
                    addressController.stateName = addressController.userData["stateName"];
                    addressController.cityName = addressController.userData["cityName"];
                    return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                        //  controller: addressController.stateName.text ?? "",
                          decoration: InputDecoration(
                            labelText: addressController.stateName ?? 'State (Required)*',
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
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText:  addressController.cityName ?? 'City (Required)*',
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
                      ),
                    ],
                  );
                  }
                ),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> body = {
                          "countryID": "65eaea840c03aecb86469807",
                          "stateID": "65eaecff69a39077bf56a866",
                          "cityID": "65eaeda4b6fc56d0cf2c402c",
                          "pincode": addressController.pincodeController.text,
                          "name": addressController.nameController.text,
                          "phoneNumber": addressController.phoneController.text,
                          "type": "Home",
                          "buildingName":
                              addressController.buildingNameController.text,
                          "area": addressController.areaController.text
                        };
                        addressController
                            .addressFetch(body)
                            .then((value) => print("Add Add Successfully!.."));
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
                    child: const Text(
                      "Save Address",
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
