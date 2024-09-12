import 'package:employee_management/models/employee_model.dart';
import 'package:employee_management/screens/employee_detail_screen.dart';
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

    // Fetch employees when screen is initialized
    employeeProvider.fetchEmployees().then((_) {
      // Shows a Snackbar when employees are fetched successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Employee list loaded successfully!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Management',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: employeeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: TextFormField(
                      controller: searchController,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.deepPurple.withOpacity(0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          size: 25,
                          color: Colors.deepPurple,
                        ),
                        hintText: "Search by ID . . .",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (value) {
                        employeeProvider.filterEmployees(value);

                        //Shows a Snackbar, if id not found
                        if (employeeProvider.filteredEmployees.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No employees found!',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: employeeProvider.filteredEmployees.length,
                      itemBuilder: (context, index) {
                        final employee =
                            employeeProvider.filteredEmployees[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return EmployeeDetailsScreen(
                                      employee: employee);
                                }),
                              );
                            },
                            leading: CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.deepPurple[100],
                              //cached_network_image used
                              child: CachedNetworkImage(
                                imageUrl: employee.avatar ?? '',
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundImage: imageProvider,
                                  radius: 23,
                                ),
                              ),
                            ),
                            title: Text(
                              employee.name ?? "Unnamed Employee",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "Employee ID: ${employee.id}",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            trailing: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "View Details",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: Colors.deepPurple,
                                ),
                              ],
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
