import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mess_management/model/issue.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/view_model/common_issues_view_model.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter/material.dart';
import 'package:mess_management/model/issue.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/view_model/common_issues_view_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class CommonIssues extends StackedView<CommonIssuesViewModel> {
  @override
  CommonIssuesViewModel viewModelBuilder(BuildContext context) =>
      CommonIssuesViewModel();

  @override
  Widget builder(
      BuildContext context, CommonIssuesViewModel viewModel, Widget? child) {
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
                  padding: EdgeInsets.fromLTRB(0, 36, 16, 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: ThemeService.secondaryColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trending issues',
                            style: TextStyle(
                              color: ThemeService.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              text: 'Upvote ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: 'for Immediate resolution',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          viewModel.isLoading
              ? _buildShimmerList()
              : SliverList.builder(
                  itemCount: viewModel.issues.length,
                  itemBuilder: (context, index) {
                    final trend = viewModel.issues[index];
                    return IssueTile(
                      issueItem: trend,
                      viewModel: viewModel,
                    );
                  },
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          viewModel.floatingAction(context);
        },
        child: Icon(
          Icons.add,
          size: 40,
          color: ThemeService.secondaryBackgroundColor,
        ),
        backgroundColor: ThemeService.primaryColor,
        splashColor: ThemeService.primaryAccent,
        shape: CircleBorder(),
      ),
    );
  }

  Widget _buildShimmerList() {
    return SliverToBoxAdapter(
      child: Column(
        children: List.generate(10, (index) => IssueTileShimmer()),
      ),
    );
  }

  Widget _buildShimmerTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 10,
                      width: 150,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IssueTileShimmer extends StatelessWidget {
  const IssueTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 150,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 250,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Icon(Icons.thumb_up_alt_outlined,
                            size: 25, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 30,
                          height: 12,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Icon(Icons.thumb_down_alt_outlined,
                            size: 25, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 30,
                          height: 12,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class IssueTile extends StatefulWidget {
  const IssueTile(
      {super.key, required this.issueItem, required this.viewModel});

  final CommonIssuesViewModel viewModel;
  final Issue issueItem;

  @override
  State<IssueTile> createState() => _IssueTileState();
}

class _IssueTileState extends State<IssueTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Raised by ${widget.issueItem.name}',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                width: 250,
                child: Text(
                  widget.issueItem.title,
                  // softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 1,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          if (widget.viewModel.upvotesSet
                              .contains(widget.issueItem.uid)) {
                            widget.viewModel.removeUpvote(widget.issueItem.uid);
                          } else {
                            widget.viewModel.addUpvote(widget.issueItem.uid);
                          }
                        },
                        icon: Icon(
                          widget.viewModel.upvotesSet
                                  .contains(widget.issueItem.uid)
                              ? Icons.thumb_up_alt
                              : Icons.thumb_up_alt_outlined,
                          color: ThemeService.primaryColor,
                          size: 25,
                        ),
                      ),
                      Text(
                        // '${widget.issueItem.upvotes}K',
                        formatNumber(widget.issueItem.upvotes),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          if (widget.viewModel.downvotesSet
                              .contains(widget.issueItem.uid)) {
                            widget.viewModel
                                .removeDownvote(widget.issueItem.uid);
                          } else {
                            widget.viewModel.addDownvote(widget.issueItem.uid);
                          }
                        },
                        icon: Icon(
                          widget.viewModel.downvotesSet
                                  .contains(widget.issueItem.uid)
                              ? Icons.thumb_down_alt
                              : Icons.thumb_down_alt_outlined,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                      Text(
                        formatNumber(widget.issueItem.downvotes),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                  // Icon(
                  //   Icons.thumb_up_off_alt,
                  //   color: ThemeService.primaryColor,
                  //   size: 25,
                  // ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Icon(
                  //   Icons.thumb_down_off_alt_rounded,
                  //   color: Colors.red,
                  //   size: 25,
                  // )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return '$number';
    }
  }
}
