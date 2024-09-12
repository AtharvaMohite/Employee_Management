import 'package:flutter/material.dart';
import '../models/employee_model.dart'; // Make sure your Employee model is imported
import 'package:cached_network_image/cached_network_image.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final Employee employee;

  EmployeeDetailsScreen({required this.employee});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme:
            const IconThemeData(color: Colors.white), // Professional color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Employee Avatar
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor:
                    Colors.grey[200], // Subtle background for avatar
                child: CachedNetworkImage(
                  imageUrl: widget.employee.avatar ??
                      '', // Avatar image from employee object
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, size: 60),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 55,
                    backgroundImage: imageProvider,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Employee Name
            Center(
              child: Text(
                widget.employee.name ?? 'Unknown Name',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple, // Professional color
                ),
              ),
            ),
            SizedBox(height: 20),

            // Employee Details using ListTiles
            _buildDetailTile(Icons.email, 'Email', widget.employee.email),
            Divider(),
            _buildDetailTile(Icons.phone, 'Mobile', widget.employee.mobile),
            Divider(),
            _buildDetailTile(
                Icons.location_city, 'State', widget.employee.state),
            Divider(),
            _buildDetailTile(
                Icons.location_on, 'District', widget.employee.district),
            Divider(),
            _buildDetailTile(Icons.public, 'Country', widget.employee.country),

            // Spacer and Edit Button
            Spacer(),
            // Center(
            //   child: ElevatedButton.icon(
            //     icon: Icon(Icons.edit),
            //     label: Text('Edit Employee'),
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.deepPurple, // Button color
            //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            //     ),
            //     onPressed: () {
            //       // Navigate to edit employee screen
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => EditEmployeeScreen(employee: employee), // Assuming this screen exists
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Reusable function to build detail tiles
  ListTile _buildDetailTile(IconData icon, String title, String? subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
      subtitle: Text(
        subtitle ?? 'Not available',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
