import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/model/issue.dart';
import 'package:mess_management/model/user_model.dart';
import 'package:mess_management/services/db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:mess_management/services/user_service.dart';

class CommonIssuesViewModel extends BaseViewModel {
  UserService userService = locator<UserService>();
  late List<Issue> issues = [];
  late HashSet<String> upvotesSet;
  late HashSet<String> downvotesSet;
  late UserModel user;
  bool isLoading = false;

  CommonIssuesViewModel() {
    initialise();
  }
  void initialise() async {
    isLoading = true;
    notifyListeners();
    final QuerySnapshot ref = await DBService.issues.get();

    issues = ref.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>; // Cast the data to Map
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
    // if (downvotesSet.contains(issueId)) {
    //   await removeDownvote(issueId);
    // }
    if (!upvotesSet.contains(issueId)) {
      try {
        final issue = DBService.issues.doc(issueId);
        await issue.update({
          'upvotes': FieldValue.increment(1)
        });
        final userDoc = DBService.users.doc(userService.getUser!.uid);
        await userDoc.update({
          'upvotes': FieldValue.arrayUnion([issueId])
        });
        upvotesSet.add(issueId);
        notifyListeners();
      } catch (error) {
        print("Failed to add upvote: $error");
      }
    }
  }

  void removeUpvote(String issueId) async {
    if (upvotesSet.contains(issueId)) {
      try {
        final issue = DBService.issues.doc(issueId);
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
        final issue = DBService.issues.doc(issueId);
        await issue.update({
          'downvotes': FieldValue.increment(1)
        });
        final userDoc = DBService.users.doc(userService.getUser!.uid);
        await userDoc.update({
          'downvotes': FieldValue.arrayUnion([issueId])
        });
        downvotesSet.add(issueId);
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
}
