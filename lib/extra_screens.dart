
import 'package:flutter/material.dart';
import 'database_helper.dart';

// ==================== MÀN HÌNH THỐNG KÊ ====================

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<Map<String, dynamic>> transactions = [];
  bool isLoading = true;
  String selectedPeriod = 'Tháng này';

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    try {
      final data =
      await DatabaseHelper.instance.getTransactions();

      if (!mounted) return;

      setState(() {
        transactions = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  int get totalIncome {
    int total = 0;
    for (final item in transactions) {
      if (item['type'] == 'income') {
        total += (item['amount'] as num).toInt();
      }
    }
    return total;
  }

  int get totalExpense {
    int total = 0;
    for (final item in transactions) {
      if (item['type'] == 'expense') {
        total += (item['amount'] as num).toInt();
      }
    }
    return total;
  }

  String formatMoney(int amount) {
    final value = amount.toString();
    final result = StringBuffer();

    for (int i = 0; i < value.length; i++) {
      result.write(value[i]);

      final remaining = value.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        result.write('.');
      }
    }

    return '${result.toString()} đ';
  }

  @override
  Widget build(BuildContext context) {
    final categories = <String, int>{};

    for (final item in transactions) {
      if (item['type'] == 'expense') {
        final category = item['category']?.toString() ?? 'Khác';
        final amount = (item['amount'] as num).toInt();

        categories[category] =
            (categories[category] ?? 0) + amount;
      }
    }

    final sortedCategories = categories.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thống kê',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: loadTransactions,
            icon: const Icon(Icons.refresh),
            tooltip: 'Tải lại',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: loadTransactions,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedPeriod,
              decoration: const InputDecoration(
                labelText: 'Thời gian',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Tháng này',
                  child: Text('Tháng này'),
                ),
                DropdownMenuItem(
                  value: 'Tất cả',
                  child: Text('Tất cả giao dịch'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  selectedPeriod = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TỔNG THU NHẬP',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatMoney(totalIncome),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Divider(height: 28),
                    const Text(
                      'TỔNG CHI TIÊU',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatMoney(totalExpense),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Divider(height: 28),
                    const Text(
                      'SỐ DƯ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatMoney(totalIncome - totalExpense),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1769E8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Chi tiêu theo danh mục',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (sortedCategories.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'Chưa có dữ liệu chi tiêu',
                    ),
                  ),
                ),
              )
            else
              ...sortedCategories.map((entry) {
                final percent = totalExpense == 0
                    ? 0.0
                    : entry.value / totalExpense;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(formatMoney(entry.value)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: percent.clamp(0.0, 1.0),
                          minHeight: 8,
                          borderRadius:
                          BorderRadius.circular(8),
                          color: const Color(0xFF1769E8),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${(percent * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

// ==================== MÀN HÌNH CÁ NHÂN ====================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cá nhân',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          const CircleAvatar(
            radius: 48,
            backgroundColor: Color(0xFFE4EEFF),
            child: Icon(
              Icons.person,
              size: 56,
              color: Color(0xFF1769E8),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Người dùng',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              'Expense Manager',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 28),
          _profileItem(
            icon: Icons.person_outline,
            title: 'Thông tin cá nhân',
            subtitle: 'Thông tin tài khoản',
            onTap: () {
              _showMessage(context, 'Chức năng đang được phát triển');
            },
          ),
          _profileItem(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Danh mục chi tiêu',
            subtitle: 'Quản lý danh mục',
            onTap: () {
              _showMessage(context, 'Chức năng đang được phát triển');
            },
          ),
          _profileItem(
            icon: Icons.notifications_outlined,
            title: 'Thông báo',
            subtitle: 'Cài đặt thông báo',
            onTap: () {
              _showMessage(context, 'Chức năng đang được phát triển');
            },
          ),
          _profileItem(
            icon: Icons.backup_outlined,
            title: 'Sao lưu dữ liệu',
            subtitle: 'Bảo vệ dữ liệu giao dịch',
            onTap: () {
              _showMessage(context, 'Dữ liệu đang được lưu trong SQLite');
            },
          ),
          _profileItem(
            icon: Icons.info_outline,
            title: 'Giới thiệu ứng dụng',
            subtitle: 'Expense Manager',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Expense Manager',
                applicationVersion: '1.0.0',
                applicationLegalese: 'Ứng dụng quản lý thu chi cá nhân',
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _profileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1769E8)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  static void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

// ==================== MÀN HÌNH BỘ LỌC ====================

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String transactionType = 'all';
  String period = 'all';

  final List<String> categories = [
    'Ăn uống',
    'Mua sắm',
    'Lương',
    'Đi lại',
    'Học tập',
    'Khác',
  ];

  final Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bộ lọc',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Loại giao dịch',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Tất cả'),
            value: 'all',
            // Giữ API tương thích với nhiều phiên bản Flutter.
            // ignore: deprecated_member_use
            groupValue: transactionType,
            // ignore: deprecated_member_use
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  transactionType = value;
                });
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Thu nhập'),
            value: 'income',
            // ignore: deprecated_member_use
            groupValue: transactionType,
            // ignore: deprecated_member_use
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  transactionType = value;
                });
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Chi tiêu'),
            value: 'expense',
            // ignore: deprecated_member_use
            groupValue: transactionType,
            // ignore: deprecated_member_use
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  transactionType = value;
                });
              }
            },
          ),
          const Divider(height: 30),
          const Text(
            'Danh mục',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...categories.map((category) {
            return CheckboxListTile(
              title: Text(category),
              value: selectedCategories.contains(category),
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    selectedCategories.add(category);
                  } else {
                    selectedCategories.remove(category);
                  }
                });
              },
            );
          }),
          const Divider(height: 30),
          const Text(
            'Khoảng thời gian',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: period,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'all',
                child: Text('Tất cả thời gian'),
              ),
              DropdownMenuItem(
                value: 'month',
                child: Text('Tháng này'),
              ),
              DropdownMenuItem(
                value: 'week',
                child: Text('7 ngày gần đây'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  period = value;
                });
              }
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1769E8),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  <String, dynamic>{
                    'type': transactionType,
                    'categories': selectedCategories.toList(),
                    'period': period,
                  },
                );
              },
              child: const Text('Áp dụng'),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              setState(() {
                transactionType = 'all';
                period = 'all';
                selectedCategories.clear();
              });
            },
            child: const Text('Đặt lại'),
          ),
        ],
      ),
    );
  }
}
