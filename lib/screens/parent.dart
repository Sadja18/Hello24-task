import 'package:flutter/material.dart';
import 'package:hmail_settings_general_clone/widgets/language_widget.dart';
import 'package:hmail_settings_general_clone/widgets/phone_number_widget.dart';
import 'package:hmail_settings_general_clone/widgets/text_style_widget.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  Color colorOfButtonOnHover = Colors.blue.shade800;
  Color colorOfButtonNormal = Colors.black;
  Color colorOfButton = Colors.black;

  List<Widget> generateTabs() {
    List<Widget> widgets = [];

    List<String> names = [
      "General",
      "Labels",
      "Inbox",
      "Accounts and Import",
      "Filters and Blocked Addresses",
      "Forwarding and POP/IMAP",
      "Add-ons",
      "Chat and Meet",
      "Advanced",
      "Offline",
      "Themes"
    ];

    for (var name in names) {
      widgets.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: SizedBox(
              child: Text(
                name,
                style: TextStyle(
                  color: names.indexOf(name) == 0 ? colorOfButtonOnHover : colorOfButtonNormal,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  void initState() {
    setState(() {
      colorOfButton = colorOfButtonNormal;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xf6f8fcff),
          backgroundBlendMode: BlendMode.color,
        ),
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.only(
          top: 18.0,
          left: 18.0,
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // decoration: BoxDecoration(color: Colors.red),
                height: MediaQuery.of(context).size.height * 0.03,
                margin: const EdgeInsets.only(top: 1),
                child: const Text(
                  'Settings',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                ),
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.90,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: generateTabs(),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: const Text(
                        "Stars widget",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: const Text(
                        "signature widget",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2.0,
                    ),
                  ],
                ),
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FractionColumnWidth(0.20),
                  1: FractionColumnWidth(0.80),
                },
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            left: 18.0,
                          ),
                          child: SizedBox(
                            child: Text(
                              "Language:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      LanguageWidget(),
                    ],
                  ),
                  const TableRow(children: [
                    TableCell(
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                    ),
                    TableCell(
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                  const TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            left: 18.0,
                          ),
                          child: SizedBox(
                            child: Text(
                              "Phone numbers:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      PhoneNumberWidget(),
                    ],
                  ),
                  const TableRow(
                    children: [
                      TableCell(
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.black,
                        ),
                      ),
                      TableCell(
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FractionColumnWidth(0.20),
                  1: FractionColumnWidth(0.22),
                },
                children: const [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            left: 18.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  "Default text style:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  "(Use the 'Remove formatting' button on the toolbar to reset the default text style)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  maxLines: 3,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DefaultTextStyleWidget(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
