import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth.dart';
import 'package:myapp/page-1/calories.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/posts_component.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final db = FirebaseFirestore.instance;
  final User? user = Auth().currentUser;
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Center(
            child: Text(
              "FitApp",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                
              ),
              ),
          ),
          backgroundColor: const Color(0xff796988),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                      stream: db
                          .collection("usersPosts")
                          .orderBy(
                            "TimeStamp",
                            descending: false,
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data!.docs[index];
                              return UserPost(
                                message: post['Message'],
                                user: post['UserEmail'],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }))
            ],
          ),
        ),
        bottomNavigationBar: GNav(
          backgroundColor: const Color.fromRGBO(9, 9, 9, 1),
          color: Colors.white70,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromRGBO(66, 66, 66, 1),
          iconSize: 30,
          textSize: 30,
          gap: 20,
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
              print(_selectedIndex);
              if (_selectedIndex == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CaloriesActivity()));
              } else if (_selectedIndex == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              } else if (_selectedIndex == 1) {
                print("Same Page");
              }
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
            GButton(
              icon: Icons.calculate,
              text: 'Calories',
            ),
          ],
        ),
      ),
    );
  }
}
