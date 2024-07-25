import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/controllers/notification_service.dart';
import 'package:flutter/material.dart';

import 'controllers/auth_service.dart';
import 'firebase_options.dart';
import 'views/homepage.dart';
import 'views/login.dart';
import 'views/messages.dart';
import 'views/signup.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to listen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received in background...");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //intialize firbase Notification
  await PushNotifications.init();

  //intialize Local Notification
  await PushNotifications.localNotiInit();

  // to listen Background notification
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  //on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Backgorund message is tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
      // if (kIsWeb) {
      //   showNotification(
      //       title: message.notification!.title!,
      //       body: message.notification!.body!);
      // } else {
      //   PushNotifications.showSimpleNotification(
      //       title: message.notification!.title!,
      //       body: message.notification!.body!,
      //       payload: payloadData);
      // }
    }
  });
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => CheckUser(),
        "/signup": (context) => SignupPage(),
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/message": (context) => Messages(),
      },
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    AuthService.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// class Product360ImageView extends StatefulWidget {
//   const Product360ImageView({super.key});

//   @override
//   _Product360ImageViewState createState() => _Product360ImageViewState();
// }

// class _Product360ImageViewState extends State<Product360ImageView> {
//   List<ImageProvider> imageList = [];

//   @override
//   void initState() {
//     super.initState();
//     loadImages();
//   }

//   void loadImages() {
//     List<String> urls = [
//       "https://mcstaging.bottlestore.com/media/catalog/product/cache/be2ac50930ab3282958370053db2bc19/5/5/55220042-1.jpg",
//       "https://mcstaging.bottlestore.com/media/catalog/product/cache/be2ac50930ab3282958370053db2bc19/5/5/55220042-2.jpg",
//       "https://mcstaging.bottlestore.com/media/catalog/product/cache/be2ac50930ab3282958370053db2bc19/5/5/55220042-3.jpg",
//       "https://mcstaging.bottlestore.com/media/catalog/product/cache/be2ac50930ab3282958370053db2bc19/5/5/55220042-4.jpg",
//     ];

//     for (String url in urls) {
//       imageList.add(NetworkImage(url));
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('360° Product View'),
//       ),
//       body: Center(
//         child: imageList.isEmpty
//             ? const CircularProgressIndicator()
//             : ImageView360(
//                 key: UniqueKey(),
//                 imageList: imageList,
//                 autoRotate: true,
//                 rotationCount: 2,
//                 rotationDirection: RotationDirection.anticlockwise, //Optional
//                 frameChangeDuration:
//                     const Duration(milliseconds: 10), //Optional
//                 swipeSensitivity: 2,
//                 allowSwipeToRotate: true,
//                 onImageIndexChanged: (currentImageIndex) {
//                   print("currentImageIndex: $currentImageIndex");
//                 },
//               ),
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:webview_flutter/webview_flutter.dart';

// // class PanoramaViewer extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Panorama Viewer'),
// //       ),
// //       body: WebView(
// //         initialUrl:
// //             'https://orbitvu.co/share/sAzrZW2De6qjzh3zVScW2S/3062865/360/view',
// //         javascriptMode: JavascriptMode.unrestricted,
        
// //         onPageStarted: (String url) {
// //           print('Page started loading: $url');
// //         },
// //         onPageFinished: (String url) {
// //           print('Page finished loading: $url');
// //         },
// //         onWebResourceError: (WebResourceError error) {
// //           print('Error: ${error.description}');
// //         },
// //       ),
// //     );
// //   }
// // }

// // void main() {
// //   runApp(MaterialApp(
// //     home: PanoramaViewer(),
// //     debugShowCheckedModeBanner: false,
// //   ));
// // }
