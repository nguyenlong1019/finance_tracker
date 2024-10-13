void main() {
  Map<String, double> spending = {
    'Bill': 250.0,
    'Food': 300.0,
    'Entertainment': 150.0,
    'Shopping': 200.0,
    'Save': 100.0,
  };

  double saveTarget = 200.0;
  int months = 6; // Number of months to save
  double monthlySaveTarget = saveTarget / months;

  double decrementSpend = monthlySaveTarget - spending['Save']!;

  // Non-essential categories
  List<String> unnecessary = ['Entertainment', 'Shopping'];

  if (decrementSpend > 0) {
    double eachReduction = decrementSpend / unnecessary.length; // Evenly split the reduction amount

    for (String category in unnecessary) {
      double reduction = spending[category]! < eachReduction ? spending[category]! : eachReduction;
      spending[category] = spending[category]! - reduction;
    }

    spending['Save'] = spending['Save']! + decrementSpend;
  }

  print('Solution recommendation for $months months:');
  spending.forEach((category, money) {
    print('$category: ${money.toStringAsFixed(2)} \$');
  });
}
