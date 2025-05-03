import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/phone_number_provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool isPhoneValid = false;
  

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    setState(() {
      isPhoneValid = _phoneController.text.trim().length == 11;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF071A3C);
    const buttonColor = Color(0xFF6B5CFE);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "OTP Verification",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28, // Increased font size
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40), // Increased spacing
                const Text(
                  "Enter Mobile Number",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ), // Slightly larger font
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12), // Increased spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        style: const TextStyle(
                          fontSize: 18,
                        ), // Larger input text
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          counterText: "",
                          hintText: "Mobile Number",
                          hintStyle: const TextStyle(
                            fontSize: 16,
                          ), // Larger hint text
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Slightly larger border radius
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, // Increased horizontal padding
                            vertical: 18, // Increased vertical padding
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50), // Increased spacing
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        isPhoneValid
                            ? () {
                              Provider.of<PhoneNumberProvider>(
                                context,
                                listen: false,
                              ).setPhoneNumber(_phoneController.text);
                              Navigator.pushNamed(
                                context,
                                '/confirmotp',
                              );
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPhoneValid ? buttonColor : buttonColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ), // Larger button height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Larger border radius
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "GET OTP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Larger button text
                        color:
                            isPhoneValid
                                ? Colors.white
                                : Colors.white.withAlpha(255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
