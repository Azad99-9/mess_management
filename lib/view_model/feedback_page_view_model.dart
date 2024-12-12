import 'package:flutter/material.dart';
import 'package:mess_management/model/response_model.dart';
import 'package:mess_management/services/db_service.dart';
import 'package:mess_management/services/user_service.dart';

class FeedbackPageViewModel extends ChangeNotifier {
  TextEditingController timeliness = TextEditingController();
  TextEditingController cleanliness = TextEditingController();
  TextEditingController quality = TextEditingController();
  TextEditingController taste = TextEditingController();
  TextEditingController snacks = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController courtesy = TextEditingController();
  TextEditingController attire = TextEditingController();
  TextEditingController serving = TextEditingController();
  TextEditingController washArea = TextEditingController();
  TextEditingController startDateController =
      TextEditingController(text: "10-10-2024");
  TextEditingController endDateController =
      TextEditingController(text: "11-11-2024");

  final formKey = GlobalKey<FormState>();

  void submit() async {
    final exists = await DBService.feedbackResponses
        .where('uid', isEqualTo: UserService.currentUser!.uid)
        .where('startDate', isEqualTo: startDateController.text)
        .where('endDate', isEqualTo: endDateController.text)
        .get();
    if (exists.docs.isEmpty) {
      await DBService.feedbackResponses.add(
        ResponseModel(
          startDate: startDateController.text,
          endDate: endDateController.text,
          timeliness: double.parse(timeliness.text ?? '0'),
          cleanliness: double.parse(cleanliness.text ?? '0'),
          quality: double.parse(quality.text ?? '0'),
          taste: double.parse(taste.text ?? '0'),
          snacks: double.parse(snacks.text ?? '0'),
          quantity: double.parse(quantity.text ?? '0'),
          courtesy: double.parse(courtesy.text ?? '0'),
          attire: double.parse(attire.text ?? '0'),
          serving: double.parse(serving.text ?? '0'),
          washArea: double.parse(washArea.text ?? '0'),
          uid: UserService.currentUser!.uid,
        ).toJson(),
      );
    } else {
      print('already exists');
    }
  }
}
