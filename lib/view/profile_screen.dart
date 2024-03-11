import 'package:flutter/material.dart';

import '../common/color_extension.dart';
import 'myaddress_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 222, 222),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            color: TColor.bg,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account Settings",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline_outlined,
                            color: Color.fromARGB(255, 28, 36, 182),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.wallet_outlined,
                              color: Color.fromARGB(255, 28, 36, 182),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Saved Cards & Wallet",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyAddresses() ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color.fromARGB(255, 28, 36, 182),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Saved Addresses",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.language_outlined,
                            color: Color.fromARGB(255, 28, 36, 182),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "Select Language",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.notifications_outlined,
                            color: Color.fromARGB(255, 28, 36, 182),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "Notification Settings",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      )
                    ],
                  ),
                
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
