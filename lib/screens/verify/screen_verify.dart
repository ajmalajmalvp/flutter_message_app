import 'package:flutter/material.dart';
import 'package:flutter_emc/screens/login/provider/login_provider.dart';
import 'package:flutter_emc/screens/verify/provider/verify_provider.dart';
import 'package:flutter_emc/utils/snackbar.dart';
import 'package:provider/provider.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({
    super.key,
  });

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  TextEditingController _otpController = TextEditingController();
  int _otpLength = 6;
  int _timerSeconds = 60;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    if (!_isTimerRunning) {
      _isTimerRunning = true;
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          if (_timerSeconds > 0) {
            _timerSeconds--;
          } else {
            _isTimerRunning = false;
            _timerSeconds = 60; // Reset the timer
          }
        });
        startTimer();
      });
    }
  }

  void verifyOTP() {
    // Implement your OTP verification logic here
    print('Verifying OTP: ${_otpController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the OTP sent to your phone',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Consumer<VerifyProvider>(builder: (context, verifyProvider, _) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textFiledOtp(
                        controller: verifyProvider.text1, context: context),
                    textFiledOtp(
                        controller: verifyProvider.text2, context: context),
                    textFiledOtp(
                        controller: verifyProvider.text3, context: context),
                    textFiledOtp(
                        controller: verifyProvider.text4, context: context),
                    textFiledOtp(
                        controller: verifyProvider.text5, context: context),
                    textFiledOtp(
                        controller: verifyProvider.text6, context: context),
                  ]);
            }),
            const SizedBox(height: 20),
            _timerSeconds > 0
                ? Text('Resend OTP in $_timerSeconds seconds')
                : TextButton(
                    onPressed: () {
                      // Implement your resend OTP logic here
                      print('Resend OTP button pressed');
                      startTimer();
                    },
                    child: const Text('Resend OTP'),
                  ),
            const SizedBox(height: 20),
            Consumer2<VerifyProvider, LoginProvider>(
                builder: (context, verifyProvider, loginProvider, _) {
              return ElevatedButton(
                onPressed: () {
                  if (verifyProvider.text1.text.isNotEmpty &&
                      verifyProvider.text2.text.isNotEmpty &&
                      verifyProvider.text3.text.isNotEmpty &&
                      verifyProvider.text4.text.isNotEmpty &&
                      verifyProvider.text5.text.isNotEmpty &&
                      verifyProvider.text6.text.isNotEmpty) {
                    verifyProvider.verifyFunction(
                      context: context,
                      loginModel: loginProvider.loginModel!,
                    );
                  } else {
                    showSnackBar(context: context, message: "please enter otp");
                  }
                },
                child: const Text('Verify OTP'),
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget textFiledOtp(
    {required TextEditingController controller,
    required BuildContext context}) {
  return SizedBox(
    width: 50,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      onChanged: (value) {
        FocusScope.of(context).nextFocus();
      },
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
