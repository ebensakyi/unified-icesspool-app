import 'package:flutter/material.dart';

class ServiceDescription extends StatelessWidget {
  final String name;
  final String description;

  ServiceDescription({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue, // Change the color as needed
                child: Icon(Icons.person),
              ),
              title: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                description.length > 100
                    ? description.substring(0, 100) + '...'
                    : description,
              ),
              trailing: Icon(Icons.arrow_drop_down)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle button press
                print('Button pressed for $name');
              },
              child: Text('Learn more'),
            ),
          ),
        ],
      ),
    );
  }
}
