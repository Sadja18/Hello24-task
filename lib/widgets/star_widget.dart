import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StarsWrapper extends StatefulWidget {
  const StarsWrapper({super.key});

  @override
  State<StarsWrapper> createState() => _StarsWrapperState();
}

class _StarsWrapperState extends State<StarsWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.20,
      child: const Text(
        "dummy",
      ),
    );
  }
}
