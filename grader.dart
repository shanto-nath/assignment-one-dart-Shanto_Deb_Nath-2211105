import 'dart:io';

void main() async {
  print('🎯 Dart Assignment Auto-Grader');
  print('============================\n');
  
  final results = <String, Map<String, dynamic>>{};
  var totalScore = 0;
  var maxScore = 0;
  
  // Grade each question
  for (var i = 1; i <= 5; i++) {
    print('📝 Grading Question $i...');
    final questionResult = await gradeQuestion(i);
    results['question$i'] = questionResult;
    totalScore += questionResult['score'] as int;
    maxScore += questionResult['maxScore'] as int;
    print('   Score: ${questionResult['score']}/${questionResult['maxScore']}');
    if (questionResult['errors'].isNotEmpty) {
      print('   Errors: ${questionResult['errors']}');
    }
    print('');
  }
  
  // Calculate final grade
  final percentage = (totalScore / maxScore * 100).round();
  final letterGrade = getLetterGrade(percentage);
  
  // Write results to files
  await writeTestResults(results);
  await writeGradeSummary(totalScore, maxScore, percentage, letterGrade);
  
  print('🏆 Final Grade: $totalScore/$maxScore ($percentage%) - $letterGrade');
  
  // Exit with appropriate code
  exit(percentage >= 60 ? 0 : 1);
}

Future<Map<String, dynamic>> gradeQuestion(int questionNumber) async {
  final maxScore = getMaxScore(questionNumber);
  var score = 0;
  final errors = <String>[];
  
  try {
    // Check if file exists
    final file = File('question$questionNumber.dart');
    if (!await file.exists()) {
      errors.add('File question$questionNumber.dart not found');
      return {'score': 0, 'maxScore': maxScore, 'errors': errors};
    }
    
    // Check compilation
    final compileResult = await Process.run('dart', ['analyze', 'question$questionNumber.dart']);
    if (compileResult.exitCode != 0) {
      errors.add('Compilation errors: ${compileResult.stderr}');
      score += 1; // Partial credit for attempting
    } else {
      score += 2; // Full credit for compilation
    }
    
    // Run specific tests for each question
    switch (questionNumber) {
      case 1:
        score += await testQuestion1();
        break;
      case 2:
        score += await testQuestion2();
        break;
      case 3:
        score += await testQuestion3();
        break;
      case 4:
        score += await testQuestion4();
        break;
      case 5:
        score += await testQuestion5();
        break;
    }
    
    // Check for specific requirements
    final content = await file.readAsString();
    score += checkSpecificRequirements(questionNumber, content);
    
  } catch (e) {
    errors.add('Exception during grading: $e');
  }
  
  return {
    'score': score.clamp(0, maxScore),
    'maxScore': maxScore,
    'errors': errors,
  };
}

int getMaxScore(int questionNumber) {
  switch (questionNumber) {
    case 1: return 10;
    case 2: return 15;
    case 3: return 20;
    case 4: return 25;
    case 5: return 30;
    default: return 10;
  }
}

Future<int> testQuestion1() async {
  var score = 0;
  
  try {
    // Test BMI calculation
    final result = await Process.run('dart', ['question1.dart']);
    if (result.exitCode == 0) {
      score += 3; // Program runs successfully
      
      final output = result.stdout.toString();
      if (output.contains('BMI:') && output.contains('Grade:')) {
        score += 2; // Output format is correct
      }
    }
  } catch (e) {
    // Error in execution
  }
  
  return score;
}

Future<int> testQuestion2() async {
  var score = 0;
  
  try {
    final result = await Process.run('dart', ['question2.dart']);
    if (result.exitCode == 0) {
      score += 3; // Program runs successfully
      
      final output = result.stdout.toString();
      if (output.contains('Student Scores:') && output.contains('Highest Score:')) {
        score += 2; // Output format is correct
      }
    }
  } catch (e) {
    // Error in execution
  }
  
  return score;
}

Future<int> testQuestion3() async {
  var score = 0;
  
  try {
    final result = await Process.run('dart', ['question3.dart']);
    if (result.exitCode == 0) {
      score += 3; // Program runs successfully
      
      final output = result.stdout.toString();
      if (output.contains('Account:') && output.contains('Balance:')) {
        score += 2; // Output format is correct
      }
    }
  } catch (e) {
    // Error in execution
  }
  
  return score;
}

Future<int> testQuestion4() async {
  var score = 0;
  
  try {
    final result = await Process.run('dart', ['question4.dart']);
    if (result.exitCode == 0) {
      score += 3; // Program runs successfully
      
      final output = result.stdout.toString();
      if (output.contains('Vehicle Info:') && output.contains('Starting the')) {
        score += 2; // Output format is correct
      }
    }
  } catch (e) {
    // Error in execution
  }
  
  return score;
}

Future<int> testQuestion5() async {
  var score = 0;
  
  try {
    final result = await Process.run('dart', ['question5.dart']);
    if (result.exitCode == 0) {
      score += 3; // Program runs successfully
      
      final output = result.stdout.toString();
      if (output.contains('Manager:') && output.contains('Developer:')) {
        score += 2; // Output format is correct
      }
    }
  } catch (e) {
    // Error in execution
  }
  
  return score;
}

int checkSpecificRequirements(int questionNumber, String content) {
  var score = 0;
  
  switch (questionNumber) {
    case 1:
      if (content.contains('calculateBMI') && content.contains('getGrade')) score += 3;
      break;
    case 2:
      if (content.contains('List<String>') && content.contains('Map<String, int>')) score += 3;
      if (content.contains('switch')) score += 2;
      break;
    case 3:
      if (content.contains('class BankAccount')) score += 3;
      if (content.contains('deposit') && content.contains('withdraw')) score += 2;
      break;
    case 4:
      if (content.contains('abstract class Vehicle')) score += 3;
      if (content.contains('extends Vehicle')) score += 2;
      break;
    case 5:
      if (content.contains('mixin Payable') && content.contains('mixin Reportable')) score += 3;
      if (content.contains('extends Employee')) score += 2;
      break;
  }
  
  return score;
}

String getLetterGrade(int percentage) {
  if (percentage >= 90) return 'A';
  if (percentage >= 80) return 'B';
  if (percentage >= 70) return 'C';
  if (percentage >= 60) return 'D';
  return 'F';
}

Future<void> writeTestResults(Map<String, Map<String, dynamic>> results) async {
  final file = File('test_results.txt');
  final content = StringBuffer();
  
  content.writeln('Dart Assignment Test Results');
  content.writeln('============================');
  content.writeln();
  
  for (final entry in results.entries) {
    final question = entry.key;
    final result = entry.value;
    content.writeln('$question: ${result['score']}/${result['maxScore']}');
    if (result['errors'].isNotEmpty) {
      content.writeln('  Errors: ${result['errors']}');
    }
  }
  
  await file.writeAsString(content.toString());
}

Future<void> writeGradeSummary(int totalScore, int maxScore, int percentage, String letterGrade) async {
  final file = File('grade_summary.txt');
  final content = StringBuffer();
  
  content.writeln('Final Grade: $totalScore/$maxScore ($percentage%) - $letterGrade');
  content.writeln();
  content.writeln('Breakdown:');
  content.writeln('- Question 1: Basic Data Types & Functions');
  content.writeln('- Question 2: Collections & Control Flow');
  content.writeln('- Question 3: Classes & Objects');
  content.writeln('- Question 4: Inheritance & Polymorphism');
  content.writeln('- Question 5: Advanced Features & Mixins');
  
  await file.writeAsString(content.toString());
}
