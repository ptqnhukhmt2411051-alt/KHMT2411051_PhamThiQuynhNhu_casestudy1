import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'extra_screens.dart';

void main() {
  runApp(const ExpenseManagerApp());
}

class ExpenseManagerApp extends StatelessWidget {
  const ExpenseManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ======================================================
// MÀN HÌNH QUẢN LÝ GIAO DỊCH
// ======================================================

class TransactionMenuScreen extends StatelessWidget {
  const TransactionMenuScreen({super.key});

  Future<void> _editFirstTransaction(BuildContext context) async {
    final transactions = await DatabaseHelper.instance.getTransactions();

    if (!context.mounted) return;

    if (transactions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chưa có giao dịch để sửa')),
      );
      return;
    }

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EditTransactionScreen(
          transaction: transactions.first,
        ),
      ),
    );

    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã cập nhật giao dịch')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý giao dịch'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Quản lý giao dịch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF14213D),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Chọn chức năng bạn muốn thực hiện',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8A9AAF),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTransactionScreen(),
                    ),
                  );

                  if (result == true && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã lưu giao dịch')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Thêm giao dịch',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => _editFirstTransaction(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1976D2),
                  side: const BorderSide(color: Color(0xFF1976D2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sửa giao dịch',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// MÀN HÌNH THÊM GIAO DỊCH
// ======================================================

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool isExpense = true;
  String category = 'Ăn uống';

  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
    text: '12/04/2025',
  );
  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (!mounted || pickedDate == null) return;

    setState(() {
      dateController.text = _formatDate(pickedDate);
    });
  }

  Future<void> _saveTransaction() async {
    if (amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số tiền')),
      );
      return;
    }

    final amount = int.tryParse(
      amountController.text.replaceAll('.', '').replaceAll(',', '').trim(),
    );

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Số tiền không hợp lệ')),
      );
      return;
    }

    await DatabaseHelper.instance.insertTransaction({
      'type': isExpense ? 'expense' : 'income',
      'category': category,
      'amount': amount,
      'date': dateController.text,
      'note': noteController.text.trim(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã lưu giao dịch')),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Thêm giao dịch'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _typeSelector(),
            const SizedBox(height: 25),
            const Text(
              'Danh mục',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _categoryDropdown(),
            const SizedBox(height: 20),
            const Text(
              'Số tiền',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Nhập số tiền',
                suffixText: 'đ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ngày giao dịch',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: _pickDate,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.calendar_month),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ghi chú',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập ghi chú (tùy chọn)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _saveButton('Lưu', _saveTransaction),
          ],
        ),
      ),
    );
  }

  Widget _typeSelector() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isExpense = true),
            child: _typeButton('Chi tiêu', isExpense, Colors.redAccent),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isExpense = false),
            child: _typeButton('Thu nhập', !isExpense, Colors.green),
          ),
        ),
      ],
    );
  }

  Widget _typeButton(String text, bool selected, Color selectedColor) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: selected ? selectedColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _categoryDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: category,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.restaurant,
          color: Colors.redAccent,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'Ăn uống', child: Text('Ăn uống')),
        DropdownMenuItem(value: 'Mua sắm', child: Text('Mua sắm')),
        DropdownMenuItem(value: 'Di chuyển', child: Text('Di chuyển')),
        DropdownMenuItem(value: 'Giải trí', child: Text('Giải trí')),
        DropdownMenuItem(value: 'Giáo dục', child: Text('Giáo dục')),
      ],
      onChanged: (value) {
        if (value != null) {
          setState(() => category = value);
        }
      },
    );
  }

  Widget _saveButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ======================================================
// MÀN HÌNH CHÀO
// ======================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Spacer(flex: 3),
              SizedBox(
                width: 120,
                height: 100,
                child: Stack(
                  children: [
                    Positioned(
                      left: 22,
                      top: 20,
                      child: Container(
                        width: 58,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFF59B957),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 32,
                      top: 15,
                      child: Container(
                        width: 62,
                        height: 37,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7BCB7B),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 39,
                      child: Container(
                        width: 82,
                        height: 58,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1976D2),
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 66,
                      top: 53,
                      child: Container(
                        width: 36,
                        height: 24,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1555A5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Expense Manager',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF14213D),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Quản lý chi tiêu cá nhân\nđơn giản và hiệu quả',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8A9AAF),
                  height: 1.5,
                ),
              ),
              const Spacer(flex: 4),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionMenuScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Bắt đầu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// MÀN HÌNH SỬA GIAO DỊCH
// ======================================================

class EditTransactionScreen extends StatefulWidget {
  final Map<String, dynamic> transaction;

  const EditTransactionScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late bool isExpense;
  late String category;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final transaction = widget.transaction;
    isExpense = transaction['type'] == 'expense';
    category = transaction['category']?.toString() ?? 'Ăn uống';
    amountController.text = transaction['amount']?.toString() ?? '';
    dateController.text = transaction['date']?.toString() ?? '';
    noteController.text = transaction['note']?.toString() ?? '';
  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime initialDate = DateTime.now();

    final parts = dateController.text.split('/');
    if (parts.length == 3) {
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (day != null && month != null && year != null) {
        initialDate = DateTime(year, month, day);
      }
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (!mounted || pickedDate == null) return;

    setState(() {
      dateController.text = _formatDate(pickedDate);
    });
  }

  Future<void> _updateTransaction() async {
    final amount = int.tryParse(
      amountController.text.replaceAll('.', '').replaceAll(',', '').trim(),
    );

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Số tiền không hợp lệ')),
      );
      return;
    }

    final id = widget.transaction['id'];
    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy mã giao dịch')),
      );
      return;
    }

    await DatabaseHelper.instance.updateTransaction(
      id as int,
      {
        'type': isExpense ? 'expense' : 'income',
        'category': category,
        'amount': amount,
        'date': dateController.text,
        'note': noteController.text.trim(),
      },
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Sửa giao dịch'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isExpense = true),
                    child: _editTypeButton(
                      'Chi tiêu',
                      isExpense,
                      Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isExpense = false),
                    child: _editTypeButton(
                      'Thu nhập',
                      !isExpense,
                      Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Danh mục',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _validCategory(category),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.restaurant,
                  color: Colors.redAccent,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Ăn uống', child: Text('Ăn uống')),
                DropdownMenuItem(value: 'Mua sắm', child: Text('Mua sắm')),
                DropdownMenuItem(value: 'Di chuyển', child: Text('Di chuyển')),
                DropdownMenuItem(value: 'Giải trí', child: Text('Giải trí')),
                DropdownMenuItem(value: 'Giáo dục', child: Text('Giáo dục')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => category = value);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Số tiền',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixText: 'đ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ngày giao dịch',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: _pickDate,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.calendar_month),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ghi chú',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _updateTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editTypeButton(String text, bool selected, Color selectedColor) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: selected ? selectedColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _validCategory(String value) {
    const categories = {
      'Ăn uống',
      'Mua sắm',
      'Di chuyển',
      'Giải trí',
      'Giáo dục',
    };
    return categories.contains(value) ? value : 'Ăn uống';
  }
}

// ======================================================
// DASHBOARD - BUỔI 6
// ======================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> transactions = [];
  int totalIncome = 0;
  int totalExpense = 0;

  int get balance => totalIncome - totalExpense;

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final data = await DatabaseHelper.instance.getTransactions();

    int income = 0;
    int expense = 0;

    for (final transaction in data) {
      final amount = (transaction['amount'] as num?)?.toInt() ?? 0;
      if (transaction['type'] == 'income') {
        income += amount;
      } else {
        expense += amount;
      }
    }

    if (!mounted) return;

    setState(() {
      transactions = data;
      totalIncome = income;
      totalExpense = expense;
    });
  }

  String _money(int amount) {
    final text = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(text[i]);
    }
    return '${buffer.toString()} đ';
  }

  Future<void> _openAddTransaction() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTransactionScreen(),
      ),
    );

    if (result == true) {
      await loadTransactions();
    }
  }

  Future<void> _openEditTransaction(
      Map<String, dynamic> transaction,
      ) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EditTransactionScreen(
          transaction: transaction,
        ),
      ),
    );

    if (result == true) {
      await loadTransactions();
    }
  }

  IconData _iconForCategory(String category) {
    switch (category) {
      case 'Ăn uống':
        return Icons.restaurant;
      case 'Mua sắm':
        return Icons.shopping_cart;
      case 'Di chuyển':
        return Icons.directions_car;
      case 'Giải trí':
        return Icons.movie;
      case 'Giáo dục':
        return Icons.school;
      default:
        return Icons.receipt_long;
    }
  }

  Color _iconColorForCategory(String category) {
    switch (category) {
      case 'Ăn uống':
        return Colors.orange;
      case 'Mua sắm':
        return Colors.purple;
      case 'Di chuyển':
        return Colors.blue;
      case 'Giải trí':
        return Colors.pink;
      case 'Giáo dục':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionMenuScreen(),
              ),
            ).then((_) => loadTransactions());
          },
        ),
        title: const Text(
          'Quản lý thu chi',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black87,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 7,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadTransactions,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4385F5),
                      Color(0xFF2468D8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'SỐ DƯ HIỆN TẠI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.visibility_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _money(balance),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.circle, color: Colors.white, size: 7),
                        SizedBox(width: 5),
                        Icon(Icons.circle, color: Colors.white54, size: 7),
                        SizedBox(width: 5),
                        Icon(Icons.circle, color: Colors.white54, size: 7),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      title: 'TỔNG THU NHẬP',
                      amount: _money(totalIncome),
                      icon: Icons.arrow_downward,
                      iconColor: Colors.green,
                      backgroundColor: const Color(0xFFEAF8ED),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _summaryCard(
                      title: 'TỔNG CHI TIÊU',
                      amount: _money(totalExpense),
                      icon: Icons.arrow_upward,
                      iconColor: Colors.red,
                      backgroundColor: const Color(0xFFFFEEEE),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Giao dịch gần đây',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (transactions.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Chưa có giao dịch'),
                          ),
                        );
                        return;
                      }

                      await _openEditTransaction(transactions.first);
                    },
                    child: const Text(
                      'Xem tất cả',
                      style: TextStyle(
                        color: Color(0xFF2468D8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: transactions.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'Chưa có giao dịch.\nHãy bấm nút + để thêm giao dịch.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
                    : Column(
                  children: transactions.take(10).map((transaction) {
                    final type = transaction['type']?.toString() ?? 'expense';
                    final category =
                        transaction['category']?.toString() ?? 'Khác';
                    final amount =
                        (transaction['amount'] as num?)?.toInt() ?? 0;
                    final note = transaction['note']?.toString() ?? '';
                    final date = transaction['date']?.toString() ?? '';
                    final title = note.isNotEmpty ? note : category;
                    final isIncome = type == 'income';
                    final color = _iconColorForCategory(category);

                    return InkWell(
                      onTap: () => _openEditTransaction(transaction),
                      child: _transactionItem(
                        icon: isIncome
                            ? Icons.attach_money
                            : _iconForCategory(category),
                        iconColor: isIncome ? Colors.green : color,
                        title: title,
                        category: category,
                        date: date,
                        amount: '${isIncome ? '+' : '-'}${_money(amount)}',
                        amountColor:
                        isIncome ? Colors.green : Colors.red,
                        showDivider: transaction != transactions.take(10).last,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2474E8),
        onPressed: _openAddTransaction,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _summaryCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 13,
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String category,
    required String date,
    required String amount,
    required Color amountColor,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                amount,
                style: TextStyle(
                  color: amountColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            indent: 64,
            endIndent: 12,
          ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

// ======================================================
// ĐIỀU HƯỚNG CHÍNH: TRANG CHỦ, GIAO DỊCH, THỐNG KÊ, CÁ NHÂN
// ======================================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;
  final GlobalKey<_DashboardScreenState> dashboardKey =
  GlobalKey<_DashboardScreenState>();

  late final List<Widget> screens = [
    DashboardScreen(key: dashboardKey),
    const TransactionMenuScreen(),
    const StatisticsScreen(),
    const ProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() => currentIndex = index);
    if (index == 0) {
      dashboardKey.currentState?.loadTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1769E8),
        unselectedItemColor: Colors.grey,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Giao dịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Thống kê',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}

