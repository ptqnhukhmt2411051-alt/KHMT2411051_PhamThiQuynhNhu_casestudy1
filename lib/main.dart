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
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

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