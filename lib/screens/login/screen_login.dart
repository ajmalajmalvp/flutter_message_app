import 'package:flutter/material.dart';
import 'package:flutter_emc/screens/login/provider/login_provider.dart';
import 'package:provider/provider.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Consumer<LoginProvider>(builder: (context, loginProvider, _) {
              return TextField(
                controller: loginProvider.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Consumer<LoginProvider>(builder: (context, loginProvider, _) {
              return ElevatedButton(
                onPressed: () {
                  loginProvider.loginFunction(context: context);
                },
                child: loginProvider.phoneLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Center(
                        child: Text('Login'),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
