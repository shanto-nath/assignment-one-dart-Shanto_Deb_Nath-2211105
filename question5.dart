// Question 5: Advanced Features & Mixins (Difficulty: 5/5) ⭐⭐⭐⭐⭐
mixin Payable {
  double calculateSalary(double baseSalary, double bonus) => baseSalary + bonus;

  void processPayment(double amount) {
    print('Payment processed: \$${amount.toStringAsFixed(2)}');
  }
}

mixin Reportable {
  String generateReport(String employeeName, String department) => "Report: Monthly report for $employeeName in $department department";
}

abstract class Employee {

  Employee(this.name, this.id, this.department);
  String name;
  String id;
  String department;

  String getJobTitle();
  double getBaseSalary();

  void displayInfo() {
    print('$name (ID: $id, Department: $department)');
    print('Job Title: ${getJobTitle()}');
    print('Base Salary: \$${getBaseSalary().toStringAsFixed(2)}');
  }
}

// Manager: uses both Payable and Reportable
class Manager extends Employee with Payable, Reportable {

  Manager(String name, String id, String department, this.teamSize)
      : super(name, id, department);
  int teamSize;

  @override
  String getJobTitle() => 'Manager';

  @override
  double getBaseSalary() => 8000;

  @override
  void displayInfo() {
    super.displayInfo(); // Reuse base info
    print('Team Size: $teamSize');
  }
}

// Developer: uses only Payable
class Developer extends Employee with Payable {

  Developer(String name, String id, String department, this.programmingLanguage)
      : super(name, id, department);
  String programmingLanguage;

  @override
  String getJobTitle() => 'Senior Developer';

  @override
  double getBaseSalary() => 6000;

  @override
  void displayInfo() {
    super.displayInfo(); // Reuse base info
    print('Programming Language: $programmingLanguage');
  }
}

void main() {
  // Create employees
  var manager = Manager('John Smith', 'M001', 'IT', 5);
  var developer = Developer('Alice Johnson', 'D001', 'IT', 'Dart');

  // Demonstrate salary calculation with bonus
  var managerSalary =
      manager.calculateSalary(manager.getBaseSalary(), 1000);
  var developerSalary =
      developer.calculateSalary(developer.getBaseSalary(), 500);

  // === Manager Demo ===
  manager.displayInfo();
  print('Calculated Salary: \$${managerSalary.toStringAsFixed(2)}');
  manager.processPayment(managerSalary);
  print(manager.generateReport(manager.name, manager.department));
  print('');

  // === Developer Demo ===
  developer.displayInfo();
  print('Calculated Salary: \$${developerSalary.toStringAsFixed(2)}');
  developer.processPayment(developerSalary);

  // Note: developer.generateReport() would cause error — correctly not called!
}
