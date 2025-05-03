import 'package:app/widgets/drawer.dart';
import 'package:app/home.dart';
import 'package:app/lines.dart';
import 'package:app/schedule.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const Lines(),
    const SchedulePage(), // Schedule screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF09122C),
      elevation: 0,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: const Color(0xFF0000FF), // Active color
      unselectedItemColor: Colors.white70,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.tram), label: 'Lines'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Schedule',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer:
          _selectedIndex == 0
              ? const CustomDrawer()
              : null, // Show drawer only on Home page
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(_getPageTitle()),
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  String _getPageTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Lines';
      case 2:
        return 'Schedule';
      default:
        return '';
    }
  }
}
