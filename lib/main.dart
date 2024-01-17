import 'package:flutter/material.dart';
import 'package:flutter_emc/screens/chat_list/chat_list.dart';
import 'package:flutter_emc/screens/chat_list/provider/chat_list_provider.dart';
import 'package:flutter_emc/screens/chat_screen/provider/chat_screen_provider.dart';
import 'package:flutter_emc/screens/login/provider/login_provider.dart';
import 'package:flutter_emc/screens/login/screen_login.dart';
import 'package:flutter_emc/screens/verify/provider/verify_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) {
        return ChatListProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return LoginProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return VerifyProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return ChatScreenProvider();
      },
    ),
  ], child: const MyApp()));
}

var url =
    'https://i.pinimg.com/736x/fd/6e/04/fd6e04548095d7f767917f344a904ff1.jpg';
var urlTwo =
    'https://sguru.org/wp-content/uploads/2017/03/cute-n-stylish-boys-fb-dp-2016.jpg';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    Future.microtask(() {
      VerifyProvider verifyProvider =
          Provider.of<VerifyProvider>(context, listen: false);
      verifyProvider.getAuthKey();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer<VerifyProvider>(builder: (context, verifyProvider, _) {
        return verifyProvider.accessKey == null ||
                verifyProvider.accessKey == ''
            ? const PhoneLoginPage()
            : const ChatListScreen();
      }),
    );
  }
}
