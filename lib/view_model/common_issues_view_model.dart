import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_management/model/issue.dart';
import 'package:mess_management/services/db_service.dart';
import 'package:stacked/stacked.dart';

class CommonIssuesViewModel extends BaseViewModel {
  late List<Issue> issues = [];
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

    isLoading = false;
    notifyListeners();
    // Use the list of issues as needed
    // print(issues); // Example: Print all issues
  }

  void upVoteHandle(String issueId) async
  {
    try{
      final issue=await DBService.issues.doc(issueId);
      await issue.update({
        'upvotes':FieldValue.increment(1),
      });
      
    }catch(error)
    {
      print("failed to upvotes $error");
    }
  }
  void downVoteHandle(String issueId) async
  {
    try{
      final issue=await DBService.issues.doc(issueId);
      await issue.update({
        'upvotes':FieldValue.increment(-1),
      });

    }catch(error)
    {
      print("failed to upvotes $error");
    }
  }

}