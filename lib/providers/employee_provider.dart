import 'package:employee_management/models/employee_model.dart';
import 'package:flutter/material.dart';
import '../api_fuction/emplyee_api.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> employeeslist = [];
  List<Employee> filteredEmployees = [];
  bool isLoading = true;

  //funtion to get employee list from API and update the UI
  Future<void> fetchEmployees() async {
    isLoading = true;
    notifyListeners();
    try {
      employeeslist = await getEmployees(); // Fetch employees from API
      filteredEmployees = employeeslist;
    } catch (e) {
      employeeslist = [];
      filteredEmployees = [];
    }
    isLoading = false;
    notifyListeners();
  }

  // Function to searcg employees based on the search query
  void filterEmployees(String empId) {
    if (empId.isEmpty) {
      filteredEmployees =
          employeeslist; // If the search term is empty, reset the list
    } else {
      filteredEmployees = employeeslist.where((employee) {
        return employee.id.toString().contains(empId); // Search by  id
      }).toList();
    }
    notifyListeners(); // Notify listeners to update the UI
  }
}
