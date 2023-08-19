import 'package:flutter/material.dart';
import 'package:hmail_settings_general_clone/extra/common_data.dart';

class StarsWrapper extends StatefulWidget {
  const StarsWrapper({super.key});

  @override
  State<StarsWrapper> createState() => _StarsWrapperState();
}

class _StarsWrapperState extends State<StarsWrapper> {
  late List<String> inUseWidgets;
  late List<String> notInUseWidgets;

  void initialize() async {
    setState(() {
      inUseWidgets = [
        "Yellow Star",
      ];
      notInUseWidgets = [
        'Amber Star',
        'Orange Star',
        'Purple Star',
        'Blue Star',
        'Green Star',
        'Red Exclamation',
        'Orange Shift',
        'Yellow Exclamation',
        'Blue Checkbox',
        'Blue Info',
        'Purple Question',
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.08,
      width: MediaQuery.of(context).size.width * 0.80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                // padding: const EdgeInsets.all(8.0),
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  child: Text(
                    "Drag the stars between the lists.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Text(
                    "  The stars will rotate in the order shown below when you click successively. To learn the name of a star for search, hover your mouse over the image.",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  child: Text(
                    "Presets:	",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "1 star",
                      style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "4 stars",
                      style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "all stars",
                      style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Text(
                      "In use:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ] +
                inUseWidgets
                    .map((e) => Draggable(
                          data: e,
                          onDragEnd: (details) {
                            // Rebuild the not in use section and add the widget at the
                            // beginning of the list.
                            setState(() {
                              notInUseWidgets.insert(0, e);
                              inUseWidgets.remove(e);
                            });
                          },
                          feedback: const Text(
                            "",
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            child: widgetMap[e]!,
                          ),
                        ))
                    .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Text(
                      "Not in use:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ] +
                notInUseWidgets
                    .map((e) => Draggable(
                          data: e,
                          onDragEnd: (details) {
                            // Rebuild the in use section and add the widget at the
                            // position defined by its own position value.
                            setState(() {
                              int position = notInUseWidgets.indexOf(e);
                              inUseWidgets.insert(position, e);
                              notInUseWidgets.remove(e);
                            });
                          },
                          feedback: const Text(
                            "",
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            child: widgetMap[e]!,
                          ),
                        ))
                    .toList(),
          ),
        ],
      ),
    );
  }
}
