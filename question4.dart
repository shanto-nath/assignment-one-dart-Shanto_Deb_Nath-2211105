// Question 4: Inheritance & Polymorphism (Difficulty: 4/5) ⭐⭐⭐⭐
// Create a vehicle management system using inheritance and polymorphism.


// 1. Abstract Class Vehicle
abstract class Vehicle {
  String brand;
  String model;
  int year;
  
  Vehicle(this.brand, this.model, this.year);
  
  // Abstract methods
  void start();
  void stop();
  
  // Concrete method
  void displayInfo() {
    print("Vehicle Info: $year $brand $model");
  }
  
  // Method to calculate vehicle age
  int calculateAge() {
    return DateTime.now().year - year;
  }
}


// 2. Concrete Class: Car
class Car extends Vehicle {
  int numberOfDoors;
  
  Car(String brand, String model, int year, this.numberOfDoors)
      : super(brand, model, year);
  
  @override
  void start() {
    print("Starting the car engine...");
  }
  
  @override
  void stop() {
    print("Stopping the car engine...");
  }
  
  @override
  void displayInfo() {
    print("Vehicle Info: $year $brand $model ($numberOfDoors doors)");
  }
}


// 3. Concrete Class: Motorcycle
class Motorcycle extends Vehicle {
  bool hasWindshield;
  
  Motorcycle(String brand, String model, int year, this.hasWindshield)
      : super(brand, model, year);
  
  @override
  void start() {
    print("Starting the motorcycle engine...");
  }
  
  @override
  void stop() {
    print("Stopping the motorcycle engine...");
  }
  
  @override
  void displayInfo() {
    print("Vehicle Info: $year $brand $model (Has windshield: $hasWindshield)");
  }
}


// 4. Demonstrate Polymorphism in main()
void main() {
  // Create a list of vehicles
  List<Vehicle> vehicles = [
    Car("Toyota", "Camry", 2021, 4),
    Motorcycle("Honda", "CBR", 2022, true),
  ];
  
  // Demonstrate polymorphism
  for (Vehicle vehicle in vehicles) {
    vehicle.displayInfo();
    vehicle.start();
    vehicle.stop();
    print(""); // Blank line for spacing
  }

  // Print ages separately
  print("Car age: ${vehicles[0].calculateAge()} years");
  print("Motorcycle age: ${vehicles[1].calculateAge()} years");
}
