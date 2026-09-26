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
      home: const WelcomeScreen(),
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