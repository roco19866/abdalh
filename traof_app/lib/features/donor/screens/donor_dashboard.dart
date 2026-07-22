import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/stats_card.dart';

class DonorDashboard extends StatefulWidget {
  const DonorDashboard({super.key});

  @override
  State<DonorDashboard> createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الداعم'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(),
          _buildDonationsTab(),
          _buildReportsTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'تبرعاتي'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'التقارير'),
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
                colors: [AppColors.donationGold, Color(0xFFB8860B)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مرحباً بك، داعم كريم',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'إجمالي تبرعاتك',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '١٢,٥٠٠ ر.س',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'آخر تبرع: ١٥/٠٧/٢٠٢٦',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.7),
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
                  title: 'عدد التبرعات',
                  value: '٨',
                  icon: Icons.favorite,
                  color: AppColors.donationGold,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  title: 'الأيتام المدعومين',
                  value: '٣',
                  icon: Icons.child_care,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'ال báo cáo',
                  value: '٥',
                  icon: Icons.description,
                  color: AppColors.familyBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  title: 'الأسر المستفيدة',
                  value: '٢',
                  icon: Icons.family_restroom,
                  color: AppColors.employeeGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'الأيتام المدعومين',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildOrphanCard('أحمد محمد', '٨ سنوات', 'يحتاج دعم تعليمي', Icons.boy),
          _buildOrphanCard('فاطمة علي', '١٠ سنوات', 'يحتاج دعم صحي', Icons.girl),
          _buildOrphanCard('يوسف حسن', '٦ سنوات', 'يحتاج ملابس', Icons.boy),
        ],
      ),
    );
  }

  Widget _buildOrphanCard(String name, String age, String need, IconData icon) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.donationGold.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.donationGold),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '$age - $need',
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildDonationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'سجل التبرعات',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildDonationItem('تبرع شهري', '٢,٥٠٠ ر.س', '٠١/٠٧/٢٠٢٦', AppColors.primary, 'مكتمل'),
          _buildDonationItem('تبرع تعليمي', '١,٠٠٠ ر.س', '١٥/٠٦/٢٠٢٦', AppColors.familyBlue, 'مكتمل'),
          _buildDonationItem('تبرع صحي', '٣,٠٠٠ ر.س', '٠١/٠٦/٢٠٢٦', AppColors.employeeGreen, 'مكتمل'),
          _buildDonationItem('تبرع ملابس', '٥٠٠ ر.س', '١٥/٠٥/٢٠٢٦', AppColors.secondary, 'مكتمل'),
          _buildDonationItem('تبرع إعاشة', '٥,٥٠٠ ر.س', '٠١/٠٥/٢٠٢٦', AppColors.donationGold, 'قيد التنفيذ'),
        ],
      ),
    );
  }

  Widget _buildDonationItem(String title, String amount, String date, Color color, String status) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.favorite, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          date,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.textSecondary),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: status == 'مكتمل' ? AppColors.success.withValues(alpha: 0.1) : AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10,
                  color: status == 'مكتمل' ? AppColors.success : AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تقارير الأيتام',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            'تقرير أحمد - يوليو ٢٠٢٦',
            'الحالة: ممتاز - التقدم الدراسي ممتاز',
            AppColors.success,
          ),
          _buildReportCard(
            'تقرير فاطمة - يوليو ٢٠٢٦',
            'الحالة: جيد - تحتاج دعم في الرياضيات',
            AppColors.familyBlue,
          ),
          _buildReportCard(
            'تقرير يوسف - يونيو ٢٠٢٦',
            'الحالة: جيد جداً - تم توفير الملابس',
            AppColors.employeeGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, String subtitle, Color color) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.description, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
        ),
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
            backgroundColor: AppColors.donationGold,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            'عبدالله الشمري',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'داعم متميز',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: AppColors.donationGold,
            ),
          ),
          const SizedBox(height: 24),
          _buildProfileMenuItem(Icons.person_outline, 'الملف الشخصي'),
          _buildProfileMenuItem(Icons.payment, 'طرق الدفع'),
          _buildProfileMenuItem(Icons.history, 'سجل المعاملات'),
          _buildProfileMenuItem(Icons.notifications_outlined, 'الإشعارات'),
          _buildProfileMenuItem(Icons.help_outline, 'المساعدة'),
          _buildProfileMenuItem(Icons.info_outline, 'عن التطبيق'),
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
}
