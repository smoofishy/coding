import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'java_functions.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

// Page display including top widget bar, coding part and a selection pop-up.
class _NewPageState extends State<NewPage> {
  List<String> lines = ['Line 1'];
  int? selectedLine;

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _addLine() {
    setState(() {
      lines.add('Line ${lines.length + 1}');
    });
  }
  //Shows the selection page when the line is double clicked and replace line's content with the selected text
  //TODO: add selections to change each component of the function, line etc.
  void _showPopup(int index) {
  String? selectedFunction;

  showDialog(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (context, setDialogState) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Java Functions for Line ${index + 1}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: javaFunctions.length,
                    itemBuilder: (context, i) {
                      final function = javaFunctions[i];
                      final isSelected = function == selectedFunction;

                      return ListTile(
                        title: Text(function),
                        tileColor: isSelected ? Colors.blue.shade100 : null,
                        onTap: () {
                          setDialogState(() {
                            selectedFunction = function;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: selectedFunction == null
                          ? null
                          : () {
                              // Call the outer setState to update the line
                              setState(() {
                                lines[index] = selectedFunction!;
                              });
                              Navigator.pop(context);
                            },
                      child: Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}


  //Builds line and defines line style
  //TODO: add horizontal divider inbetween each line
  Widget _buildLine(int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedLine = index),
      onDoubleTap: () => _showPopup(index),
      child: Container(
        color: selectedLine == index ? Colors.yellow.shade100 : Colors.white,
        child: TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed: () => setState(() => selectedLine = index),
          child: Text(
            lines[index],
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }

  //Top widger bar config
  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          _addLine();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Text('New Page'),
          actions: [
            IconButton(icon: Icon(Icons.play_arrow), onPressed: () {}),
            IconButton(icon: Icon(Icons.stop), onPressed: () {}),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: lines.length,
                itemBuilder: (context, index) => _buildLine(index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                onPressed: _addLine,
                child: Text('Add Line'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: NewPage(),
    );
  }
}
