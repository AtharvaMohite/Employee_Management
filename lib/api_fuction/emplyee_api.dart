import "dart:convert";
import "package:http/http.dart" as http;
import "../models/employee_model.dart";

//base url
const String baseUrl ='https://669b3f09276e45187d34eb4e.mockapi.io/api/v1/employee';

// function to get employee list from the API
Future<List<Employee>> getEmployees() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Parse the response body as a List
      List<dynamic> data = json.decode(response.body);

      return data.map((e) => Employee.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load employees: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error fetching employees: $error');
  }
}
