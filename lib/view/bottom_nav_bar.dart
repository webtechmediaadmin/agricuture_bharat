import 'package:agriculter_bharat/widget/custom_drawer.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';
import '../constant/app_preferences.dart';
import '../constant/constant.dart';
import 'home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text('Products Page'),
    Text('Search Page'),
    Text('Profile Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }

  getValues() async {
    var token = await PreferenceApp().getAccessToken();
    MyConstant.access_token = token ?? "";
    print(
        "first time user access ${MyConstant.access_token = token ?? "empty token"}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
         appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.black,),
            onPressed: () {
              print("drawer...");
               _scaffoldKey.currentState?.openDrawer();
              
            }
,
          ),
          
          backgroundColor: TColor.bg,
            centerTitle: true,
            title: Text(
              "Agriculture Bharat",
              style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 25,
                  color: TColor.primaryText,
                ),
              )
            ],
          ),
        drawer: const CustomDrawer(), 
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Theme(
               data: Theme.of(context).copyWith(
            canvasColor: Colors.green.withOpacity(0.5), // Set the background color here
          ),
              child: BottomNavigationBar(
                backgroundColor: const Color(0xff0D4F80),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Products',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,
                onTap: _onItemTapped,
                elevation: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
