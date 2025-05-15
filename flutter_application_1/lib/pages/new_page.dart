import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

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

  void _showPopup(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Line ${index + 1}'),
        content: Text('You double tapped: "${lines[index]}"'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

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
      theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: NewPage(),
    );
  }
}
