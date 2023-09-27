import 'package:flutter/material.dart';
import 'package:mobigicapp/mobigic_Textfield.dart';
import 'package:mobigicapp/second_screen.dart';
import 'package:mobigicapp/themes/colors.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final mController = TextEditingController();
  final nController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  int m = 0;
  int n = 0;
  List<List<String>> grid = [];

  void createGrid() {
    grid.clear();
    for (int i = 0; i < m; i++) {
      grid.add(List<String>.filled(n, '', growable: false));
    }
  }

  @override
  void dispose() {
    mController.dispose();
    nController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text("Create Grid"),
            elevation: 1.0,
            backgroundColor: AppColors.yellow),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Enter Rows (m): ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                MobigicTextfield(
                  controller: mController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid value';
                    }
                    final intValue = int.tryParse(value);
                    if (intValue == null || intValue <= 0) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      m = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Enter column (n): ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                MobigicTextfield(
                  controller: nController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid value';
                    }
                    final intValue = int.tryParse(value);
                    if (intValue == null || intValue <= 0) {
                      return 'Please enter a positive number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      n = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: AppColors.yellow),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        createGrid();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondScreen(m: m, n: n)),
                        );
                      }
                    },
                    child: Text(
                      'Create Grid',
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
