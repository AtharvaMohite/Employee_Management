import 'package:employee_management/models/employee_model.dart';
import 'package:employee_management/screens/employee_add_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final employeeProvider =
        Provider.of<EmployeeProvider>(context, listen: false);
    employeeProvider
        .fetchEmployees(); // Fetch employees when screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Management',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme:
            const IconThemeData(color: Colors.white), // Professional color
      ),
      body: employeeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 10, right: 7, left: 7),
                    child: TextFormField(
                      controller: searchController,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          decorationThickness: 0),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            size: 25,
                          ),
                          hintText: "Search id or name..."),
                      onChanged: (value) {
                        employeeProvider
                            .filterEmployees(value); // Search in real-time
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeProvider.filteredEmployees.length,
                      itemBuilder: (context, index) {
                        final employee =
                            employeeProvider.filteredEmployees[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return EmployeeDetailsScreen(employee: employee);
                            }));
                          },
                          leading: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: employee.avatar ?? '',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundImage: imageProvider,
                              ),
                            ),
                          ),
                          title: Text(employee.name ?? ""),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text("Employee ID : ${employee.id}")],
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "View Details",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                ),
                                onPressed: () {
                                  // Confirm and delete employee
                                },
                              ),
                            ],
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
