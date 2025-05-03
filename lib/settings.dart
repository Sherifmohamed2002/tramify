import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _pushNotifEnabled = false; // Add this variable to track the switch state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: SingleChildScrollView(
        child: SizedBox(
          height:
              MediaQuery.of(
                context,
              ).size.height, // Makes sure it fills the screen
          child: Stack(
            children: [
              // Purple header
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff6B5CFE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                height: 250,
                padding: const EdgeInsets.all(24),
                child: const Row(
                  children: [
                    Icon(Icons.settings, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Settings',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),

              // Floating Card
              Positioned(
                top: 180,
                left: 16,
                right: 16,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.grey[900],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://example.com/profile.jpg',
                                ),
                                radius: 30,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Yennefer Doe',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: const Text(
                              'Account Settings',
                              style: TextStyle(fontSize: 16, color: Color(0xFFADADAD)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ListTile(
                            title: const Text(
                              'Edit profile',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/editprofile');
                            },
                          ),
                          SwitchListTile(
                            title: const Text(
                              'Push notifications',
                              style: TextStyle(color: Colors.white),
                            ),
                            value: _pushNotifEnabled,
                            onChanged:
                                (val) =>
                                    setState(() => _pushNotifEnabled = val),
                          ),
                          const Divider(color: Colors.white24),
                          ListTile(
                            title: const Text(
                              'About us',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/aboutus');
                            },
                          ),
                          ListTile(
                            title: const Text(
                              'Privacy policy',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
