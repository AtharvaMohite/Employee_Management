import 'package:employee_management/models/employee_model.dart';
import 'package:flutter/material.dart';
import '../api_fuction/emplyee_api.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> employeeslist = [];
  List<Employee> filteredEmployees = [];
  bool isLoading = true;

  Future<void> fetchEmployees() async {
    isLoading = true;
    notifyListeners();
    try {
      employeeslist = await getEmployees(); // Fetch employees from API
      filteredEmployees = employeeslist; // Initially, both lists are the same
    } catch (e) {
      employeeslist = [];
      filteredEmployees = [];
    }
    isLoading = false;
    notifyListeners();
  }

  // Function to filter employees based on the search query
  void filterEmployees(String searchTerm) {
    if (searchTerm.isEmpty) {
      filteredEmployees =
          employeeslist; // If the search term is empty, reset the list
    } else {
      filteredEmployees = employeeslist.where((employee) {
        return employee.id
            .toString()
            .contains(searchTerm); // Search by name or id
      }).toList();
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  Future<void> addEmployee(Employee employee) async {
    await createEmployee(employee);
    fetchEmployees();
  }

  Future<void> updateEmployeee(Employee employee) async {
    await updateEmployee(employee);
    fetchEmployees();
  }

  Future<void> deleteEmployee(String id) async {
    await deleteEmployee(id);
    fetchEmployees();
  }
}
