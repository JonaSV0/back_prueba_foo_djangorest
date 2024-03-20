import 'package:flutter/material.dart';


class ReadBarCodeView extends StatefulWidget {
  const ReadBarCodeView({super.key});

  @override
  State<ReadBarCodeView> createState() => _ReadBarCodeViewState();
}

class _ReadBarCodeViewState extends State<ReadBarCodeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ReadBarcode")
        ],
      ),
    );
  }
}
