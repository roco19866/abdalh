import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/stats_card.dart';

class FamilyDashboard extends StatefulWidget {
  const FamilyDashboard({super.key});

  @override
  State<FamilyDashboard> createState() => _FamilyDashboardState();
}

class _FamilyDashboardState extends State<FamilyDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الأسرة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(),
          _buildRequestsTab(),
          _buildChildrenTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.request_page), label: 'طلباتي'),
          BottomNavigationBarItem(icon: Icon(Icons.child_care), label: 'الأطفال'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.familyBlue, Color(0xFF1565C0)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مرحباً بك، أسرة كريمة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'عدد أفراد الأسرة',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Colors.white70),
                ),
                const Text(
                  '٥ أفراد',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'الطلبات النشطة',
                  value: '٢',
                  icon: Icons.pending_actions,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  title: 'الطلبات المكتملة',
                  value: '٥',
                  icon: Icons.check_circle,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'الأطفال',
                  value: '٣',
                  icon: Icons.child_care,
                  color: AppColors.familyBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  title: 'الدعم المحصل',
                  value: '٨,٥٠٠',
                  icon: Icons.attach_money,
                  color: AppColors.donationGold,
                  subtitle: 'ر.س',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'آخر الطلبات',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildRequestCard('طلب ملابس شتوية', 'جاري المراجعة', AppColors.secondary),
          _buildRequestCard('طلب أدوية', 'تم الموافقة', AppColors.success),
          _buildRequestCard('طلب قرطاسية', 'مكتمل', AppColors.familyBlue),
        ],
      ),
    );
  }

  Widget _buildRequestCard(String title, String status, Color statusColor) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.receipt_long, color: statusColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'طلباتي',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showNewRequestDialog(),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('طلب جديد', style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFullRequestCard('طلب ملابس شتوية', '٢٠/٠٧/٢٠٢٦', 'جاري المراجعة', AppColors.secondary, 'ملابس شتوية للأطفال - ٣ أحذية'),
          _buildFullRequestCard('طلب أدوية', '١٥/٠٧/٢٠٢٦', 'تم الموافقة', AppColors.success, 'أدوية مزمنة - التهاب مفاصل'),
          _buildFullRequestCard('طلب قرطاسية', '٠١/٠٧/٢٠٢٦', 'مكتمل', AppColors.familyBlue, 'أدوات مدرسية - ٣ أطفال'),
          _buildFullRequestCard('طلب إعاشة', '١٥/٠٦/٢٠٢٦', 'مكتمل', AppColors.familyBlue, 'سُلطات غذائية شهرية'),
          _buildFullRequestCard('طلب علاج', '٠١/٠٦/٢٠٢٦', 'مرفوض', AppColors.error, 'علاج أسنان'),
        ],
      ),
    );
  }

  Widget _buildFullRequestCard(String title, String date, String status, Color statusColor, String details) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: statusColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              details,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'التاريخ: $date',
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.textHint),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الأطفال',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildChildCard('أحمد', '٨ سنوات', 'صف ثالث', Icons.boy, 'متفوق دراسياً'),
          _buildChildCard('فاطمة', '١٠ سنوات', 'صف خامس', Icons.girl, 'تحتاج دعم رياضيات'),
          _buildChildCard('يوسف', '٦ سنوات', 'صف أول', Icons.boy, 'مبتدئ'),
        ],
      ),
    );
  }

  Widget _buildChildCard(String name, String age, String grade, IconData icon, String note) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.familyBlue.withValues(alpha: 0.1),
          child: Icon(icon, size: 30, color: AppColors.familyBlue),
        ),
        title: Text(
          name,
          style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          '$age - $grade\n$note',
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.familyBlue,
            child: Icon(Icons.family_restroom, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            'أسرة الشمري',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            'مسجلة منذ يناير ٢٠٢٦',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          _buildProfileMenuItem(Icons.person_outline, 'بيانات الأسرة'),
          _buildProfileMenuItem(Icons.child_care, 'إدارة الأطفال'),
          _buildProfileMenuItem(Icons.request_page, 'سجل الطلبات'),
          _buildProfileMenuItem(Icons.notifications_outlined, 'الإشعارات'),
          _buildProfileMenuItem(Icons.help_outline, 'المساعدة'),
          _buildProfileMenuItem(Icons.logout, 'تسجيل الخروج', isLogout: true),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? AppColors.error : AppColors.textSecondary),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          color: isLogout ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textHint),
      onTap: () {},
    );
  }

  void _showNewRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('طلب جديد', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'نوع الطلب',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                ),
                items: const [
                  DropdownMenuItem(value: 'ملابس', child: Text('ملابس', style: TextStyle(fontFamily: 'Cairo'))),
                  DropdownMenuItem(value: 'علاج', child: Text('علاج', style: TextStyle(fontFamily: 'Cairo'))),
                  DropdownMenuItem(value: 'قرطاسية', child: Text('قرطاسية', style: TextStyle(fontFamily: 'Cairo'))),
                  DropdownMenuItem(value: 'إعاشة', child: Text('إعاشة', style: TextStyle(fontFamily: 'Cairo'))),
                  DropdownMenuItem(value: 'أدوية', child: Text('أدوية', style: TextStyle(fontFamily: 'Cairo'))),
                  DropdownMenuItem(value: 'أخرى', child: Text('أخرى', style: TextStyle(fontFamily: 'Cairo'))),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 12),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'تفاصيل الطلب',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إرسال', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }
}
