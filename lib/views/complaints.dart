import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:image_picker/image_picker.dart';

class SubmitComplaintPage extends StatefulWidget {
  const SubmitComplaintPage({Key? key}) : super(key: key);

  @override
  State<SubmitComplaintPage> createState() => _SubmitComplaintPageState();
}

class _SubmitComplaintPageState extends State<SubmitComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  List<String> _categories = ['Food', 'Hygiene', 'Service', 'Other'];
  String? _attachmentPath;

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final category = _selectedCategory;
      final attachment = _attachmentPath;

      // Handle complaint submission logic (e.g., API call)

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Complaint submitted successfully!')),
      );

      // Clear the form after submission
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedCategory = null;
        _attachmentPath = null;
      });
    }
  }

  Future<void> _pickAttachment() async {
    final ImagePicker picker = ImagePicker();

    try {
      // Pick an image
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _attachmentPath = pickedFile.path; // Store the picked image path
        });
      } else {
        // User canceled the picker
        setState(() {
          _attachmentPath = null;
        });
      }
    } catch (e) {
      // Handle any errors
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeService.primaryAccent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Container(
                color: ThemeService.primaryColor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 36, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Complaint',
                        style: TextStyle(
                          color: ThemeService.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4,
                        ),
                        child: RichText(
                            text: TextSpan(
                                text: 'Submit',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                children: [
                              TextSpan(
                                  text: ' complaint',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                      fontSize: 12)),
                            ])),
                      ),
                    ],
                  ),
                )),
          )),
          SliverList(
            delegate: SliverChildListDelegate([
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            focusColor: ThemeService.primaryColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: ThemeService.primaryColor,
                              ), // Customize the border color
                            ),
                            floatingLabelStyle: TextStyle(
                                color: ThemeService.primaryColor,
                                fontWeight: FontWeight.bold),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title for your complaint';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: ThemeService.primaryColor,
                              ), // Customize the border color
                            ),
                            floatingLabelStyle: TextStyle(
                                color: ThemeService.primaryColor,
                                fontWeight: FontWeight.bold),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey),
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a detailed description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField2<String>(
                          // selectedItemBuilder:,

                          value: _selectedCategory,
                          items: _categories
                              .map((category) => DropdownMenuItem<String>(
                                    value: category,
                                    child: IntrinsicWidth(
                                      child: Container(
                                        // height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              category,
                                            ),
                                          ],
                                        ),
                                        //   decoration: BoxDecoration(
                                        //       color: category == _selectedCategory
                                        //           ? ThemeService.primaryColor
                                        //               .withOpacity(0.05)
                                        //           : Colors.white),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: ThemeService.primaryColor,
                              ),
                            ),
                            floatingLabelStyle: TextStyle(
                                color: ThemeService.primaryColor,
                                fontWeight: FontWeight.bold),
                            labelText: 'Category',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // Set dropdown canvas border radius
                              color: Colors
                                  .white, // Optional: Set dropdown background color
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: Text(
                            'Attachment',
                            style: TextStyle(
                                color: ThemeService.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text(_attachmentPath ?? 'No attachment selected'),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.attach_file,
                              color: ThemeService.primaryColor,
                            ),
                            onPressed: _pickAttachment,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _submitComplaint,
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                  ThemeService.primaryColor)),
                          child: const Text(
                            'Submit Complaint',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]),
          ),
        ],
      ),
    );
  }
}
