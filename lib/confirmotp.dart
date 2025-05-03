import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/phone_number_provider.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Confirmotp extends StatefulWidget {
  const Confirmotp({super.key});

  @override
  State<Confirmotp> createState() => _ConfirmotpState();
}

class _ConfirmotpState extends State<Confirmotp> {
  late String phone;
  String otp = '';
  bool isOtpComplete = false;

  @override
  void didChangeDependencies() {
    // Get phone number from provider once the widget is in context
    super.didChangeDependencies();
    phone = Provider.of<PhoneNumberProvider>(context).phoneNumber;
  }

  // Update OTP and check if it's fully filled (4 digits in this case)
  void _onOtpChanged(String code) {
    setState(() {
      otp = code;
      isOtpComplete = code.length == 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define your color palette for consistency
    const backgroundColor = Color(0xFF071A3C);
    const accentColor = Color(0xFF6B5CFE);
    const warningRed = Colors.red;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate back to the OTP request screen
            Navigator.pushNamed(context, '/getotp');
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Page Title
              const Text(
                'Confirm OTP',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // OTP message and number formatting
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  children: [
                    const TextSpan(text: 'We have sent you an '),
                    const TextSpan(
                      text: 'One Time Password\n',
                      style: TextStyle(color: Colors.red),
                    ),
                    const TextSpan(text: 'on this mobile number '),
                    TextSpan(
                      text: '($phone)',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // OTP input field
              OtpTextField(
                numberOfFields: 4, // should be 4 based on the mockup
                borderColor: warningRed,
                focusedBorderColor: accentColor,
                showFieldAsBox: true,
                fieldWidth: 55,
                borderRadius: BorderRadius.circular(8),
                cursorColor: Colors.white,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                onCodeChanged: _onOtpChanged,
                onSubmit: _onOtpChanged, // also trigger validation on submit
              ),
              const SizedBox(height: 10),

              // Resend text aligned to right
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    //  Add resend logic here (API call, reset timer, etc.)
                  },
                  child: const Text(
                    'resend',
                    style: TextStyle(color: warningRed),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Confirm button - enabled only when 4 digits are entered
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isOtpComplete
                      ? () {
                          // Proceed to next screen if OTP is valid
                          Navigator.pushNamed(context, '/createaccount');
                        }
                      : null, // disabled when not ready
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isOtpComplete
                        ? accentColor
                        : accentColor.withOpacity(0.5), 
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
