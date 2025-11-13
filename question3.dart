// Question 3: Classes & Objects (Difficulty: 3/5) ⭐⭐⭐
// Create a BankAccount class with the following specifications:

class BankAccount {
  // 1. Properties:
  String accountNumber;
  String accountHolder;
  double balance;
  String accountType; 
  
  // 2. Constructor: Initialize all properties and set balance to 0.0
  BankAccount(this.accountNumber, this.accountHolder, this.accountType)
      : balance = 0.0;
  
  // 3. Methods:
  // deposit(double amount): Add money to account
  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
    } else {
      print("Invalid deposit amount.");
    }
  }
  
  // withdraw(double amount): Remove money from account (check for sufficient funds)
  void withdraw(double amount) {
    if (amount <= balance) {
      balance -= amount;
    } else {
      print("Insufficient funds for withdrawal of $amount from account $accountNumber");
    }
  }
  
  // getBalance(): Return current balance
  double getBalance() {
    return balance;
  }
  
  // displayAccountInfo(): Show account details
  void displayAccountInfo() {
    print("Account: $accountNumber, Holder: $accountHolder, Type: $accountType, Balance: $balance");
  }
}

void main() {
  // 4. Create 3 bank accounts
  BankAccount account1 = BankAccount("12345", "Shanto", "Savings");
  BankAccount account2 = BankAccount("67890", "Polok", "Checking");
  BankAccount account3 = BankAccount("11111", "Illin", "Savings");
  
  // Demonstrate depositing money
  account1.deposit(1500.0);
  account2.deposit(900.0);
  account3.deposit(2000.0);
  
  // Demonstrate withdrawing money
  account1.withdraw(0.0);  // Alice keeps her full balance
  account2.withdraw(100.0); // Bob withdraws some
  account3.withdraw(0.0);   // Charlie keeps his balance
  
  // Display account information
  account1.displayAccountInfo();
  account2.displayAccountInfo();
  account3.displayAccountInfo();
  
  // Demonstrate insufficient funds scenario
  account2.withdraw(1000.0); // Should show insufficient funds message
}
