import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserDetailScreen extends StatelessWidget{

  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;

   const UserDetailScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.email,
  });
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       leading: IconButton(onPressed: context.pop, icon: Icon(Icons.arrow_back_ios,)),
       title: Text('LeadDetail'),
     ),
     body: Column(
       children: [
         SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
     Center(
     child: Container(
       width: MediaQuery.of(context).size.width * 0.9,
     height: MediaQuery.of(context).size.height * 0.3,
     padding: const EdgeInsets.all(16),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(16),
       border: Border.all(color: Colors.greenAccent),
       gradient: const LinearGradient(
         colors: [Color(0xFFF8F9FA), Color(0xFFE8F5E9)],
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
       ),
     ),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Stack(
           children: [
             CircleAvatar(
               radius: 50,
               backgroundImage: NetworkImage(imageUrl),
             ),
           ],
         ),
         const SizedBox(height: 12),
         Text(
           "$firstName $lastName",
           style: const TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.w600,
           ),
         ),
         SizedBox(height: 10,),
         Text(
           email,
           style: const TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.w500,
           ),
         ),
       ],
     ),
   ),
     )
       ],
     ),
   );
  }

}