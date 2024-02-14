import 'package:flutter/material.dart';

import 'circular-imageview.dart';

class ServiceDescription extends StatelessWidget {
  final String name;
  final String description;
  final CircularImageView circleImageView;

  ServiceDescription(
      {required this.name,
      required this.description,
      required this.circleImageView});

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
                child: circleImageView,
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
              child: Text('Learn More'),
            ),
          ),
        ],
      ),
    );
  }
}
