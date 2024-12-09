import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mess_management/services/theme_service.dart';

class CommonIssues extends StatefulWidget {
  const CommonIssues({super.key});

  @override
  State<CommonIssues> createState() => _CommonIssuesState();
}

class _CommonIssuesState extends State<CommonIssues> {
  // Sample data to simulate trends
  final List<Map<String, dynamic>> trends = [
    {'rank': 1, 'title': '#FlutterDev', 'subtitle': '150K upvotes'},
    {'rank': 2, 'title': '#OpenAI', 'subtitle': '90K upvotes'},
    {'rank': 3, 'title': 'AI Revolution', 'subtitle': '75K upvotes'},
    {'rank': 4, 'title': '#TechTrends', 'subtitle': '60K upvotes'},
    {'rank': 5, 'title': 'Startup Growth', 'subtitle': '45K upvotes'},
  ];

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
                            'Trending issues',
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
                                    text: 'Upvote ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    children: [
                                  TextSpan(
                                      text: ' for Immediate resolution',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                          fontSize: 12)),
                                ])),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            SliverList.builder(
              itemCount: trends.length,
              itemBuilder: (context, index) {
                final trend = trends[index];
                return IssueTile(issueItem: trends[index]);
              },
            ),
          ],
        ));
  }
}

class IssueTile extends StatefulWidget {
  const IssueTile({super.key, required this.issueItem});

  final Map<String, dynamic> issueItem;

  @override
  State<IssueTile> createState() => _IssueTileState();
}

class _IssueTileState extends State<IssueTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Raised by Azad',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                widget.issueItem['title'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                widget.issueItem['subtitle'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.thumb_up_off_alt,
                    color: ThemeService.primaryColor,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.thumb_down_off_alt_rounded,
                    color: Colors.red,
                    size: 25,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
