import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_scout/Controller/search_user_controller.dart';

class UserSearchScreen extends StatefulWidget {
  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final UserSearchController userSearchController =
      Get.put(UserSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Search'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userSearchController.searchController,
              decoration: InputDecoration(
                hintText: "Search by user name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    fillColor: Colors.green.shade100,
                    filled: true,
                
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.teal,
                  onPressed: () {
                    userSearchController.searchWithBuffer();
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Obx(() {
              if (userSearchController.searching.value) {
                return CircularProgressIndicator();
              } else if (userSearchController.searchResults.isNotEmpty) {
                final topResults =
                    userSearchController.searchResults.take(5).toList();
                final remainingResults =
                    userSearchController.searchResults.skip(0).toList();

                return Column(
                  children: [
                    Column(
                      children: topResults.map((userSnapshot) {
                        // Display the top 5 search results
                        return Card(
                          color: Colors.teal,
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              '${userSnapshot['firstName']} ${userSnapshot['lastName']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Profession: ${userSnapshot['profession']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (remainingResults.isNotEmpty)
                      ElevatedButton(
                      
                        onPressed: () {
                          // Show all remaining search results when button is clicked
                          userSearchController.showAllResults();
                        },
                        
                        child: Text('Show All Results'),
                      ),
                  ],
                );
              } else if (userSearchController
                  .searchController.text.isNotEmpty) {
                return Text('No users found');
              } else {
                // Provide a message or hint when no search query
                return Text('Enter a search query');
              }
            }),
          ],
        ),
      ),
    );
  }
}
