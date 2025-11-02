import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_app/Screens/map.dart';
import 'package:health_app/Screens/home2.dart';
import 'package:health_app/Database/lists.dart';
import 'package:health_app/Screens/booked.dart';
import 'package:health_app/Screens/settings.dart';
import 'package:health_app/Screens/emergency.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 2;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Function to navigate to the various pages
    void navigateBottomNav(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    List<Map<String, dynamic>> bookingList = 
        Provider.of<DataBank1>(context, listen: false).bookedAppointments;

    final List _pages = [
      Map1(),
      Emergency(),
      Home2(),
      MyBookingsPage(bookedServices: bookingList),
      Settings(),
    ];

    final items = <Widget>[
      const Icon(Icons.map, size: 30, color: Colors.blueAccent),
      const Icon(Icons.location_pin, size: 30, color: Colors.blueAccent),
      const Icon(Icons.home, size: 30, color: Colors.blueAccent),
      const Icon(Icons.list_alt_outlined, size: 30, color: Colors.blueAccent),
      const Icon(Icons.settings, size: 30, color: Colors.blueAccent),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _pages[selectedIndex],

      //Bottom navigation bar
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        height: 55,
        index: selectedIndex,
        color: Colors.white,
        backgroundColor: Colors.grey.shade300,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          navigateBottomNav(index);
        },
      ),
    );
  }
}
