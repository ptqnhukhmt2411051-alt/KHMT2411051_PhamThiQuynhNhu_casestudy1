import 'package:flutter/material.dart';

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
      home: const DashboardScreen(),
    );
  }
}
class TransactionMenuScreen extends StatelessWidget {
  const TransactionMenuScreen({super.key});

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

            // ==========================================
            // NÚT THÊM GIAO DỊCH
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const AddTransactionScreen(),
                    ),
                  );
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

            // ==========================================
            // NÚT SỬA GIAO DỊCH
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const EditTransactionScreen(),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1976D2),

                  side: const BorderSide(
                    color: Color(0xFF1976D2),
                  ),

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
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends State<AddTransactionScreen> {

  bool isExpense = true;

  String category = 'Ăn uống';

  final TextEditingController amountController =
  TextEditingController();

  final TextEditingController dateController =
  TextEditingController(
    text: '12/04/2025',
  );

  final TextEditingController noteController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pop(context);
          },
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

            // ==========================================
            // CHI TIÊU / THU NHẬP
            // ==========================================

            Row(
              children: [

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpense = true;
                      });
                    },

                    child: Container(
                      height: 48,

                      decoration: BoxDecoration(
                        color: isExpense
                            ? Colors.redAccent
                            : Colors.white,

                        borderRadius:
                        BorderRadius.circular(8),

                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),

                      child: Center(
                        child: Text(
                          'Chi tiêu',

                          style: TextStyle(
                            color: isExpense
                                ? Colors.white
                                : Colors.black,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpense = false;
                      });
                    },

                    child: Container(
                      height: 48,

                      decoration: BoxDecoration(
                        color: !isExpense
                            ? Colors.green
                            : Colors.white,

                        borderRadius:
                        BorderRadius.circular(8),

                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),

                      child: Center(
                        child: Text(
                          'Thu nhập',

                          style: TextStyle(
                            color: !isExpense
                                ? Colors.white
                                : Colors.black,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==========================================
            // DANH MỤC
            // ==========================================

            const Text(
              'Danh mục',

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: category,

              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.restaurant,
                  color: Colors.redAccent,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),

              items: const [

                DropdownMenuItem(
                  value: 'Ăn uống',
                  child: Text('Ăn uống'),
                ),

                DropdownMenuItem(
                  value: 'Mua sắm',
                  child: Text('Mua sắm'),
                ),

                DropdownMenuItem(
                  value: 'Di chuyển',
                  child: Text('Di chuyển'),
                ),

                DropdownMenuItem(
                  value: 'Giải trí',
                  child: Text('Giải trí'),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // ==========================================
            // SỐ TIỀN
            // ==========================================

            const Text(
              'Số tiền',

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: amountController,

              keyboardType:
              TextInputType.number,

              decoration: InputDecoration(
                hintText: 'Nhập số tiền',

                suffixText: 'đ',

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================
            // NGÀY GIAO DỊCH
            // ==========================================

            const Text(
              'Ngày giao dịch',

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: dateController,

              readOnly: true,

              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.calendar_month,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),

              onTap: () async {

                DateTime? pickedDate =
                await showDatePicker(
                  context: context,

                  initialDate: DateTime.now(),

                  firstDate: DateTime(2020),

                  lastDate: DateTime(2030),
                );

                if (pickedDate != null) {

                  setState(() {

                    dateController.text =
                    '${pickedDate.day.toString().padLeft(2, '0')}/'
                        '${pickedDate.month.toString().padLeft(2, '0')}/'
                        '${pickedDate.year}';
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            // ==========================================
            // GHI CHÚ
            // ==========================================

            const Text(
              'Ghi chú',

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: noteController,

              maxLines: 3,

              decoration: InputDecoration(
                hintText:
                'Nhập ghi chú (tùy chọn)',

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ==========================================
            // NÚT LƯU
            // ==========================================

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(

                onPressed: () {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Đã lưu giao dịch',
                      ),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF1976D2),

                  foregroundColor:
                  Colors.white,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(8),
                  ),
                ),

                child: const Text(
                  'Lưu',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
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

              // Đẩy logo xuống giữa màn hình
              const Spacer(flex: 3),

              // ==================================================
              // LOGO EXPENSE MANAGER
              // ==================================================

              SizedBox(
                width: 120,
                height: 100,

                child: Stack(
                  children: [

                    // ------------------------------------------
                    // PHẦN XANH LÁ ĐẬM
                    // ------------------------------------------

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

                    // ------------------------------------------
                    // PHẦN XANH LÁ NHẠT
                    // ------------------------------------------

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

                    // ------------------------------------------
                    // THÂN VÍ MÀU XANH DƯƠNG
                    // ------------------------------------------

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

                    // ------------------------------------------
                    // PHẦN KHÓA VÍ MÀU XANH ĐẬM
                    // ------------------------------------------

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

              // ==================================================
              // TIÊU ĐỀ
              // ==================================================

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

              // ==================================================
              // MÔ TẢ
              // ==================================================

              const Text(
                'Quản lý chi tiêu cá nhân\nđơn giản và hiệu quả',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8A9AAF),
                  height: 1.5,
                ),
              ),

              // Đẩy nút xuống phía dưới
              const Spacer(flex: 4),

              // ==================================================
              // NÚT BẮT ĐẦU
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    // Chức năng sẽ thực hiện ở các buổi sau
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
  const EditTransactionScreen({super.key});

  @override
  State<EditTransactionScreen> createState() =>
      _EditTransactionScreenState();
}

class _EditTransactionScreenState
    extends State<EditTransactionScreen> {

  bool isExpense = true;

  String category = 'Ăn uống';

  final TextEditingController amountController =
  TextEditingController(
    text: '100.000',
  );

  final TextEditingController dateController =
  TextEditingController(
    text: '12/04/2025',
  );

  final TextEditingController noteController =
  TextEditingController(
    text: 'Ăn trưa',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pop(context);
          },
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
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // CHI TIÊU / THU NHẬP

            Row(
              children: [

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpense = true;
                      });
                    },

                    child: Container(
                      height: 48,

                      decoration: BoxDecoration(
                        color: isExpense
                            ? Colors.redAccent
                            : Colors.white,

                        borderRadius:
                        BorderRadius.circular(8),

                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),

                      child: Center(
                        child: Text(
                          'Chi tiêu',

                          style: TextStyle(
                            color: isExpense
                                ? Colors.white
                                : Colors.black,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpense = false;
                      });
                    },

                    child: Container(
                      height: 48,

                      decoration: BoxDecoration(
                        color: !isExpense
                            ? Colors.green
                            : Colors.white,

                        borderRadius:
                        BorderRadius.circular(8),

                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),

                      child: Center(
                        child: Text(
                          'Thu nhập',

                          style: TextStyle(
                            color: !isExpense
                                ? Colors.white
                                : Colors.black,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // DANH MỤC

            const Text(
              'Danh mục',

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: category,

              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.restaurant,
                  color: Colors.redAccent,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),

              items: const [

                DropdownMenuItem(
                  value: 'Ăn uống',
                  child: Text('Ăn uống'),
                ),

                DropdownMenuItem(
                  value: 'Mua sắm',
                  child: Text('Mua sắm'),
                ),

                DropdownMenuItem(
                  value: 'Di chuyển',
                  child: Text('Di chuyển'),
                ),

                DropdownMenuItem(
                  value: 'Giải trí',
                  child: Text('Giải trí'),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // SỐ TIỀN

            const Text(
              'Số tiền',

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: amountController,

              keyboardType:
              TextInputType.number,

              decoration: InputDecoration(
                suffixText: 'đ',

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // NGÀY GIAO DỊCH

            const Text(
              'Ngày giao dịch',

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: dateController,

              readOnly: true,

              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.calendar_month,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),

              onTap: () async {

                DateTime? pickedDate =
                await showDatePicker(
                  context: context,

                  initialDate: DateTime.now(),

                  firstDate: DateTime(2020),

                  lastDate: DateTime(2030),
                );

                if (pickedDate != null) {

                  setState(() {

                    dateController.text =
                    '${pickedDate.day.toString().padLeft(2, '0')}/'
                        '${pickedDate.month.toString().padLeft(2, '0')}/'
                        '${pickedDate.year}';
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            // GHI CHÚ

            const Text(
              'Ghi chú',

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: noteController,

              maxLines: 3,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // NÚT LƯU

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(

                onPressed: () {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Đã cập nhật giao dịch',
                      ),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF1976D2),

                  foregroundColor:
                  Colors.white,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(8),
                  ),
                ),

                child: const Text(
                  'Lưu',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
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
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // SỐ DƯ HIỆN TẠI
            // =========================
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

                  const Text(
                    '5.000.000 đ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 7,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.circle,
                        color: Colors.white54,
                        size: 7,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.circle,
                        color: Colors.white54,
                        size: 7,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // =========================
            // TỔNG THU / CHI
            // =========================
            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    title: 'TỔNG THU NHẬP',
                    amount: '8.000.000 đ',
                    icon: Icons.arrow_downward,
                    iconColor: Colors.green,
                    backgroundColor: const Color(0xFFEAF8ED),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _summaryCard(
                    title: 'TỔNG CHI TIÊU',
                    amount: '3.000.000 đ',
                    icon: Icons.arrow_upward,
                    iconColor: Colors.red,
                    backgroundColor: const Color(0xFFFFEEEE),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =========================
            // GIAO DỊCH GẦN ĐÂY
            // =========================
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
                  onPressed: () {},
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
              child: Column(
                children: [
                  _transactionItem(
                    icon: Icons.restaurant,
                    iconColor: Colors.orange,
                    title: 'Ăn trưa',
                    category: 'Ăn uống',
                    date: '03/09/2024',
                    amount: '-50.000 đ',
                    amountColor: Colors.red,
                  ),

                  _transactionItem(
                    icon: Icons.directions_car,
                    iconColor: Colors.blue,
                    title: 'Xăng xe',
                    category: 'Di chuyển',
                    date: '03/09/2024',
                    amount: '-100.000 đ',
                    amountColor: Colors.red,
                  ),

                  _transactionItem(
                    icon: Icons.attach_money,
                    iconColor: Colors.green,
                    title: 'Lương tháng 9',
                    category: 'Thu nhập',
                    date: '01/09/2024',
                    amount: '+8.000.000 đ',
                    amountColor: Colors.green,
                  ),

                  _transactionItem(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.purple,
                    title: 'Mua sắm',
                    category: 'Mua sắm',
                    date: '31/08/2024',
                    amount: '-300.000 đ',
                    amountColor: Colors.red,
                  ),

                  _transactionItem(
                    icon: Icons.school,
                    iconColor: Colors.teal,
                    title: 'Học phí',
                    category: 'Giáo dục',
                    date: '30/08/2024',
                    amount: '-500.000 đ',
                    amountColor: Colors.red,
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // =========================
      // NÚT THÊM
      // =========================
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2474E8),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.endFloat,

      // =========================
      // THANH MENU DƯỚI
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2474E8),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Giao dịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Thống kê',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }

  // =========================
  // CARD THU / CHI
  // =========================
  static Widget _summaryCard({
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

  // =========================
  // GIAO DỊCH
  // =========================
  static Widget _transactionItem({
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
                  color: iconColor.withOpacity(0.12),
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
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