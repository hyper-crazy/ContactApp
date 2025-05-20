import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',

      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class Contact {
  final String name;
  final String number;

  Contact({required this.name, required this.number});
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final List<Contact> _contacts = [];

  void _addContact() {
    final name = _nameController.text.trim();
    final number = _numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        _contacts.add(Contact(name: name, number: number));
        _nameController.clear();
        _numberController.clear();
      });
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text("Are you sure for Delete?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.close, color: Colors.blue),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Icon(Icons.delete, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // full width
              height: 40, // button height
              child: ElevatedButton(
                onPressed: _addContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text("Add"),
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return GestureDetector(
                    onLongPress: () => _confirmDelete(index),
                    child: Card(
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          contact.name,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(contact.number),
                        trailing: Icon(Icons.phone, color: Colors.blue),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
