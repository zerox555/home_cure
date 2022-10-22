// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'package:window_size/window_size.dart';
//
// //guess the word app
// Future main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter layout demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch().copyWith(
//           secondary: Colors.red,
//         ),
//         textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
//       ),
//       home: const PostContainer(),
//     );
//   }
// }
//
// class PostContainer extends StatefulWidget {
//   const PostContainer({Key? key}) : super(key: key);
//
//   @override
//   State<PostContainer> createState() => _PostContainerState();
// }
//
// class _PostContainerState extends State<PostContainer> {
//   final ForumPosts = ForumPost.fetchAll();
//   void changeLiked(index){
//     setState(() {
//       ForumPosts[index].liked = !ForumPosts[index].liked;
//       print(ForumPosts[index].liked);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     //all forum post fetched here
//
//     final containerColor = Theme.of(context).colorScheme.secondary;
//
//
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Flutter layout demo"),
//         ),
//         body: ListView.builder(
//             itemCount: ForumPosts.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                   padding: const EdgeInsets.only(
//                     left: 10,
//                     top: 20,
//                     right: 10,
//                     bottom: 20,
//                   ),
//                   child: Container(
//                       color: containerColor,
//                       width: MediaQuery.of(context).size.width,
//                       child: Row(
//                         children: <Widget>[
//                           //LEFT SIDE
//                           Expanded(
//                             flex: 2,
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Column(
//                                   children: <Widget>[
//                                     Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       height: 30,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               width: 2.0,
//                                               color: const Color(0xFFFFFFFF))),
//                                       child: Text(ForumPosts[index].postId),
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               width: 2.0,
//                                               color: const Color(0xFFFFFFFF))),
//                                       child: Text(ForumPosts[index].postText),
//                                     ),
//                                     Row(children: [
//                                       IconButton(
//                                           icon: ForumPosts[index].liked ? const Icon(Icons.favorite): const Icon(Icons.favorite_border),
//                                           color: ForumPosts[index].liked
//                                               ? Colors.red
//                                               : Colors.blue,
//                                           iconSize: 24,
//                                           onPressed: () {
//                                             changeLiked(index);
//                                           }),
//                                       Icon(Icons.comment,
//                                           color: Colors.white, size: 24.0),
//                                     ]),
//                                   ],
//                                 )),
//                           ),
//                           //RIGHT SIDE
//                           const Expanded(
//                             flex: 1,
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Image(
//                                   image: NetworkImage(
//                                       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
//                                 )),
//                           )
//                           //right side
//                         ],
//                       )));
//             }));
//   }
// }
//
// class ForumPost {
//   final String postId;
//   final String postText;
//   final int postLike;
//   bool liked;
//   //not working
//   final String imagePath;
//
//   ForumPost(
//       this.postId, this.postText, this.postLike, this.imagePath, this.liked);
//
//   //stimulate endpoint
//
//   static List<ForumPost> fetchAll() {
//     return [
//       ForumPost("P001", "This is my first post on APP", 34,
//           "./Resources/pic1.jpg1", false),
//       ForumPost("P002", "This is my second post on APP", 12,
//           "./Resources/pic1.jpg2", false)
//     ];
//   }

import 'package:flutter/material.dart';
import 'package:home_cure/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../services/auth.dart';
import '../services/resources.dart';

Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //initialize event list
  Resources.initializeCommunityEvents();
  Resources.initializeDiscussionPosts();
  Resources.initializeVehiclePlates();
  Resources.initializeEmergencyContacts();
  Resources.initializeRegisteredVehicles();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().getUserStream,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
