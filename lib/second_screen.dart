import 'package:flutter/material.dart';
import 'package:mobigicapp/grid_page.dart';
import 'package:mobigicapp/themes/colors.dart';

class SecondScreen extends StatefulWidget {
  final int m;
  final int n;

  SecondScreen({required this.m, required this.n});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<List<TextEditingController>> controllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize the grid with empty controllers
    controllers = List.generate(
      widget.m,
      (row) => List.generate(widget.n, (col) => TextEditingController()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text("Enter Alphabets"),
            elevation: 1.0,
            backgroundColor: AppColors.yellow),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 30),
                for (int row = 0; row < widget.m; row++)
                  Row(
                    children: [
                      for (int col = 0; col < widget.n; col++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controllers[row][col],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: 16),
                SizedBox(
                  height: 60,
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: AppColors.yellow),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GridDisplayPage(
                            grid: controllers
                                .map((row) => row
                                    .map((controller) => controller.text)
                                    .toList())
                                .toList(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
