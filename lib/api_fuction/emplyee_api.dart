import "dart:convert";
import "package:http/http.dart" as http;
import "../models/employee_model.dart";

const String baseUrl =
    'https://669b3f09276e45187d34eb4e.mockapi.io/api/v1/employee';

Future<List<Employee>> getEmployees() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Parse the response body as a List
      List<dynamic> data = json.decode(response.body);

      // Map the JSON list to Employee objects
      print("api response ${response.body}");
      return data.map((e) => Employee.fromJson(e)).toList();
    } else {
      // Handle non-200 responses
      throw Exception('Failed to load employees: ${response.statusCode}');
    }
  } catch (error) {
    // Catch any exception and throw a more detailed error
    throw Exception('Error fetching employees: $error');
  }
}

// Future<Employee> getEmployeeById(String id) async {
//   final response = await http.get(Uri.parse('$baseUrl/$id'));
//   if (response.statusCode == 200) {
//     return Employee.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to load employee');
//   }
// }

Future<void> createEmployee(Employee employee) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(employee.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create employee: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error creating employee: $e');
  }
}

// Update Employee with exception handling
Future<void> updateEmployee(Employee employee) async {
  try {
    final response = await http.put(
      Uri.parse('$baseUrl/${employee.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(employee.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update employee: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error updating employee: $e');
  }
}

// Delete Employee with exception handling
Future<void> deleteEmployee(String id) async {
  try {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete employee: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error deleting employee: $e');
  }
}

// Get Countries with exception handling
Future<List<String>> getCountries() async {
  try {
    final response = await http.get(Uri.parse('https://example.com/countries'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return List<String>.from(data.map((item) => item['name']));
    } else {
      throw Exception('Failed to load countries: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error loading countries: $e');
  }
}
