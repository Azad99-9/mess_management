import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/view_model/complaints_page_view_model.dart';
import 'package:stacked/stacked.dart';

class SubmitComplaintPage extends StackedView<ComplaintsPageViewModel> {
  const SubmitComplaintPage({super.key});

  @override
  ComplaintsPageViewModel viewModelBuilder(context) =>
      ComplaintsPageViewModel();

  @override
  Widget builder(
      BuildContext context, ComplaintsPageViewModel _viewModel, Widget? child) {
    _viewModel.context = context;
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
                  key: _viewModel.formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _viewModel.titleController,
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
                          controller: _viewModel.descriptionController,
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

                          value: _viewModel.selectedMess,
                          items: _viewModel.messes
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
                                //       color: category == _viewModel.selectedCategory
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
                            labelText: 'Mess',
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
                              borderRadius: BorderRadius.circular(8),
                              // Set dropdown canvas border radius
                              color: Colors
                                  .white, // Optional: Set dropdown background color
                            ),
                          ),
                          onChanged: (value) {
                            _viewModel.updateSelectedMess(value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField2<String>(
                          // selectedItemBuilder:,

                          value: _viewModel.selectedCategory,
                          items: _viewModel.categories
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
                                        //       color: category == _viewModel.selectedCategory
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
                            _viewModel.updateSelected(value);
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
                          subtitle: Text(_viewModel.attachmentPath ??
                              'No attachment selected'),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.attach_file,
                              color: ThemeService.primaryColor,
                            ),
                            onPressed: _viewModel.pickAttachment,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _viewModel.submitComplaint,
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
