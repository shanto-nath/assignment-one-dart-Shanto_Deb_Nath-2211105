// Question 5: Advanced Features & Mixins

mixin Payable {
  double calculateSalary(double baseSalary, double bonus) {
    if (baseSalary < 0 || bonus < 0) {
      throw ArgumentError("Salaries and bonuses must be non-negative.");
    }
    return baseSalary + bonus;
  }

  void processPayment(double amount) {
    if (amount <= 0) {
      print("Payment amount must be positive.");
      return;
    }
    print("Payment processed: ${amount.toStringAsFixed(1)}");
  }
}

mixin Reportable {
  String generateReport(String employeeName, String department) {
    return "Monthly report for $employeeName in $department department";
  }
}

abstract class Employee {
  String name;
  String id;
  String department;

  Employee(this.name, this.id, this.department);

  String getJobTitle();
  double getBaseSalary();

  void displayInfo() {
    print("$name (ID: $id, Department: $department)");
    print("Job Title: ${getJobTitle()}");
    print("Base Salary: ${getBaseSalary().toStringAsFixed(1)}");
  }
}

class Manager extends Employee with Payable, Reportable {
  int teamSize;

  Manager(String name, String id, String department, this.teamSize)
      : super(name, id, department);

  @override
  String getJobTitle() => "Manager";

  @override
  double getBaseSalary() => 8000.0;

  @override
  void displayInfo() {
    print("Manager: $name (ID: $id, Department: $department, Team Size: $teamSize)");
    print("Job Title: ${getJobTitle()}");
    print("Base Salary: ${getBaseSalary().toStringAsFixed(1)}");
  }
}

class Developer extends Employee with Payable {
  String programmingLanguage;

  Developer(String name, String id, String department, this.programmingLanguage)
      : super(name, id, department);

  @override
  String getJobTitle() => "Senior Developer";

  @override
  double getBaseSalary() => 6000.0;

  @override
  void displayInfo() {
    print("Developer: $name (ID: $id, Department: $department, Language: $programmingLanguage)");
    print("Job Title: ${getJobTitle()}");
    print("Base Salary: ${getBaseSalary().toStringAsFixed(1)}");
  }
}

void main() {
  final mgr = Manager("Shanto", "M001", "IT", 5);
  final dev = Developer("Polok", "D001", "IT", "Dart");

  // Manager demo
  mgr.displayInfo();
  final mgrCalculated = mgr.calculateSalary(mgr.getBaseSalary(), 1000.0);
  print("Calculated Salary: ${mgrCalculated.toStringAsFixed(1)}");
  mgr.processPayment(mgrCalculated);
  print("Report: ${mgr.generateReport(mgr.name, mgr.department)}\n");

  // Developer demo
  dev.displayInfo();
  final devCalculated = dev.calculateSalary(dev.getBaseSalary(), 500.0);
  print("Calculated Salary: ${devCalculated.toStringAsFixed(1)}");
  dev.processPayment(devCalculated);
}