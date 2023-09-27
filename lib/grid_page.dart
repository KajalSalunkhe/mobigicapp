import 'package:flutter/material.dart';
import 'package:mobigicapp/messenger.dart';
import 'package:mobigicapp/mobigic_Textfield.dart';
import 'package:mobigicapp/themes/colors.dart';

class GridDisplayPage extends StatefulWidget {
  const GridDisplayPage({Key? key, required this.grid}) : super(key: key);
  final List<List<String>> grid;

  @override
  State<GridDisplayPage> createState() => _GridDisplayPageState();
}

class _GridDisplayPageState extends State<GridDisplayPage> {
  TextEditingController searchController = TextEditingController();

  String searchText = '';
  bool hasSearched = false;

  @override
  void initState() {
    super.initState();
  }

  bool wordMatchesSearch(String word) {
    return word.toLowerCase() == searchText.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display GridView"),
        elevation: 1,
        backgroundColor: AppColors.yellow,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MobigicTextfield(
              controller: searchController,
              hinttext: "Search Alphabet or Word",
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: AppColors.yellow),
            onPressed: () {
              searchText = searchController.text.toLowerCase();
              setState(() {
                hasSearched = true;
              });
              if (searchText.isEmpty) {
                ToastMessenger.errorMessageShow(context, "Please enter text");
                return;
              }

              bool found = false;

              for (int row = 0; row < widget.grid.length; row++) {
                for (int col = 0; col < widget.grid[row].length; col++) {
                  final cellText = widget.grid[row][col].toLowerCase();
                  if (cellText.contains(searchText)) {
                    found = true;
                    break;
                  }
                }
                if (found) {
                  break;
                }
              }

              if (!found) {
                ToastMessenger.errorMessageShow(context, "Not Found");
              }
            },
            child: Text(
              'Search',
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    widget.grid.isNotEmpty ? widget.grid[0].length : 1,
              ),
              itemBuilder: (context, index) {
                final rows = widget.grid.length;
                final cols = widget.grid.isNotEmpty ? widget.grid[0].length : 0;
                if (index < rows * cols) {
                  final row = index ~/ cols;
                  final col = index % cols;
                  final cellText = widget.grid[row][col];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cellText,
                        style: TextStyle(
                          fontWeight: wordMatchesSearch(cellText)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 20,
                          color: wordMatchesSearch(cellText)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
