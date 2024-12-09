import 'package:flutter/material.dart';

class ProfilePageViewModel extends ChangeNotifier
{
   TextEditingController Timeliness =TextEditingController();
   TextEditingController Cleanliness =TextEditingController();
   TextEditingController Quality =TextEditingController();
   TextEditingController Taste =TextEditingController();
   TextEditingController Snacks =TextEditingController();
   TextEditingController Quantity =TextEditingController();
   TextEditingController Courtesy =TextEditingController();
   TextEditingController Attire =TextEditingController();
   TextEditingController Serving =TextEditingController();
   TextEditingController Washarea =TextEditingController();
   TextEditingController startDateController = TextEditingController(text: "10-10-2024");
   TextEditingController endDateController = TextEditingController(text: "11-11-2024");

   final formKey=GlobalKey<FormState>();

   void submit()
   {
      print(Timeliness.text);
      print(Cleanliness.text);
      notifyListeners();
   }

}