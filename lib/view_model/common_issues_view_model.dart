import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/model/issue.dart';
import 'package:mess_management/model/user_model.dart';
import 'package:mess_management/services/db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:mess_management/services/user_service.dart';
import 'package:flutter/material.dart';

import '../services/theme_service.dart';
class CommonIssuesViewModel extends BaseViewModel {
  UserService userService = locator<UserService>();
  late List<Issue> issues = [];
  late HashSet<String> upvotesSet;
  late HashSet<String> downvotesSet;
  late UserModel user;
  late TextEditingController titleController=TextEditingController();
  bool isLoading = false;

  CommonIssuesViewModel() {
    initialise();
  }
  void initialise() async {
    isLoading = true;
    notifyListeners();
    final QuerySnapshot ref = await DBService.issues.get();

    issues = ref.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Issue.fromJson(data);
    }).toList();

    final userDoc = await DBService.users.doc(userService.getUser!.uid).get();
    final userData = userDoc.data() as Map<String, dynamic>;

    user = UserModel.fromJson(userData);
    upvotesSet = HashSet.from(user.upvotes ?? []);
    downvotesSet = HashSet.from(user.downvotes ?? []);
    isLoading = false;
    notifyListeners();
  }

  void addUpvote(String issueId) async {
    if (!upvotesSet.contains(issueId)) {
      print(issueId);
      try {
        final issue = DBService.issues.doc(issueId);
        await issue.update({
          'upvotes': FieldValue.increment(1)
        });
        final userDoc = DBService.users.doc(userService.getUser!.uid);
        await userDoc.update({
          'upvotes': FieldValue.arrayUnion([issueId])
        });
        upvotesSet.add(issueId as String);
        notifyListeners();
      } catch (error) {
        print("Failed to add upvote: $error");
      }
    }
  }

  void removeUpvote(String issueId) async {
    if (upvotesSet.contains(issueId)) {
      try {
        final issue = DBService.issues.doc(issueId );
        await issue.update({
          'upvotes': FieldValue.increment(-1)
        });
        final userDoc = DBService.users.doc(userService.getUser!.uid);
        await userDoc.update({
          'upvotes': FieldValue.arrayRemove([issueId])
        });
        upvotesSet.remove(issueId);
        notifyListeners();
      } catch (error) {
        print("Failed to remove upvote: $error");
      }
    }
  }

  void addDownvote(String issueId) async {
    if (!downvotesSet.contains(issueId)) {
      try {
        final issue = DBService.issues.doc(issueId );
        await issue.update({
          'downvotes': FieldValue.increment(1)
        });
        final userDoc = DBService.users.doc(userService.getUser!.uid);
        await userDoc.update({
          'downvotes': FieldValue.arrayUnion([issueId])
        });
        downvotesSet.add(issueId as String);
        notifyListeners();
      } catch (error) {
        print("Failed to add downvote: $error");
      }
    }
  }

  void removeDownvote(String issueId) async {
    if (downvotesSet.contains(issueId)) {
      try {
        final issue = DBService.issues.doc(issueId);
        await issue.update({
          'downvotes': FieldValue.increment(-1)
        });
        final userDoc = DBService.users.doc(userService.getUser!.uid);
        await userDoc.update({
          'downvotes': FieldValue.arrayRemove([issueId])
        });
        downvotesSet.remove(issueId);
        notifyListeners();
      } catch (error) {
        print("Failed to remove downvote: $error");
      }
    }
  }
  Future<String?> getUserName(String id) async {
    final userDoc = await DBService.users.doc(id).get();
    final userData =  userDoc.data() as Map<String, dynamic>;
    return  UserModel.fromJson(userData).name;
  }
  void floatingAction(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    focusColor: ThemeService.primaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: ThemeService.primaryColor,
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: ThemeService.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () async{
                        final title = titleController.text;
                        try {
                          final user=UserService.currentUser;
                          DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
                          DocumentReference issueRef = await DBService.issues.add({
                            'raisedBy': user!.uid,
                            'name':user.displayName,
                            'title': title,
                            'uid': '', // Temporarily leave it empty, will update it later
                            'upvotes': 0,
                            'downvotes': 0,
                          });
                          await issueRef.update({
                            'uid': issueRef.id,
                          });
                          notifyListeners();
                          Navigator.pop(context);
                          // Show a success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Issue "$title" added successfully!')),
                          );

                          titleController.clear();
                          notifyListeners();
                        } catch (e) {
                          // Handle any errors that occur
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error adding issue: $e')),
                          );
                          notifyListeners();
                        }
                        // Handle your action when icon is clicked
                      },
                      icon: Icon(Icons.send, color: ThemeService.primaryColor), // Your desired icon
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title for your issue';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
