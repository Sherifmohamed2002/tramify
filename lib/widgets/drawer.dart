import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          // Your drawer content
          Container(
            color: Colors.black,
            padding: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '127***1564',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/editprofile');
                        },
                        color: Colors.white10,
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white10,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),

          // Blue Section
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF003092),
                borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.white),
                    title: const Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(
                      Icons.headset_mic_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Help & Support',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Feedback',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/feedback');
                    },
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'About Us',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/aboutus');
                    },
                  ),

                  const Spacer(),

                  // Sign Out Button
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        // Sign out logic
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.logout, color: Colors.white),
                        ],
                      ),
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
