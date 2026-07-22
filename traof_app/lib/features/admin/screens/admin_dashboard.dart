import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/stats_card.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الإدارة العامة'),
        backgroundColor: AppColors.adminPurple,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(),
          _buildUsersTab(),
          _buildDonationsTab(),
          _buildReportsTab(),
          _buildSettingsTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.adminPurple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'المستخدمين'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'التبرعات'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'التقارير'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
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
                colors: [AppColors.adminPurple, Color(0xFF4A148C)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'لوحة التحكم الإدارية',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'نظرة شاملة على أداء الجمعية',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 12),
                Text(
                  'آخر تحديث: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.white.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              StatsCard(title: 'إجمالي المستخدمين', value: '١٥٦', icon: Icons.people, color: AppColors.adminPurple),
              StatsCard(title: 'الداعمين النشطين', value: '٤٥', icon: Icons.favorite, color: AppColors.donationGold),
              StatsCard(title: 'الأسر المستفيدة', value: '٢٣', icon: Icons.family_restroom, color: AppColors.familyBlue),
              StatsCard(title: 'الأيتام', value: '٨٩', icon: Icons.child_care, color: AppColors.primary),
              StatsCard(title: 'الموظفين', value: '١٢', icon: Icons.work, color: AppColors.employeeGreen),
              StatsCard(title: 'إجمالي التبرعات', value: '٢٥٠K', icon: Icons.attach_money, color: AppColors.success),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'آخر النشاطات',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildActivityItem('تسجيل داعم جديد', 'أحمد الحربي - منذ ٥ دقائق', Icons.person_add, AppColors.adminPurple),
          _buildActivityItem('تبرع جديد', '٥,٠٠٠ ر.س - عبدالله سالم', Icons.favorite, AppColors.donationGold),
          _buildActivityItem('طلب إجازة', 'خالد العتيبي - إجازة سنوية', Icons.event_busy, AppColors.employeeGreen),
          _buildActivityItem('تسجيل أسرة جديدة', 'أسرة الزهراء - حي الملقا', Icons.family_restroom, AppColors.familyBlue),
          _buildActivityItem('تقرير شهري', 'تقرير يونيو - جاهز للمراجعة', Icons.description, AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
      ),
    );
  }

  Widget _buildUsersTab() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
            labelColor: AppColors.adminPurple,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.adminPurple,
            labelStyle: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 12),
            isScrollable: true,
            tabs: [
              Tab(text: 'الكل'),
              Tab(text: 'الداعمين'),
              Tab(text: 'الأسر'),
              Tab(text: 'الموظفين'),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppConstants.padding),
              children: [
                _buildUserCard('عبدالله الشمري', 'donor@traof.com', 'داعم', AppColors.donationGold, Icons.person),
                _buildUserCard('فاطمة الزهراء', 'family@traof.com', 'أسرة', AppColors.familyBlue, Icons.family_restroom),
                _buildUserCard('خالد العتيبي', 'emp@traof.com', 'موظف', AppColors.employeeGreen, Icons.work),
                _buildUserCard('أحمد الحربي', 'donor2@traof.com', 'داعم', AppColors.donationGold, Icons.person),
                _buildUserCard('سارة القحطاني', 'family2@traof.com', 'أسرة', AppColors.familyBlue, Icons.family_restroom),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(String name, String email, String role, Color roleColor, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: roleColor.withValues(alpha: 0.1),
          child: Icon(icon, color: roleColor, size: 22),
        ),
        title: Text(name, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        subtitle: Text(email, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {},
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('تعديل', style: TextStyle(fontFamily: 'Cairo'))),
            const PopupMenuItem(value: 'suspend', child: Text('تعطيل', style: TextStyle(fontFamily: 'Cairo'))),
            const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(fontFamily: 'Cairo', color: AppColors.error))),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: roleColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(role, style: TextStyle(fontFamily: 'Cairo', fontSize: 11, color: roleColor, fontWeight: FontWeight.bold)),
          ),
        ),
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
            'إدارة التبرعات',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.adminPurple.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.adminPurple.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('إجمالي التبرعات هذا الشهر', style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                const Text(
                  '٤٥,٠٠٠ ر.س',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.adminPurple),
                ),
                const SizedBox(height: 4),
                Text(
                  '+١٢٪ عن الشهر الماضي',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.success.withValues(alpha: 0.8), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildDonationAdminItem('تبرع شهري', 'عبدالله الشمري', '٢,٥٠٠ ر.س', 'مكتمل', AppColors.success),
          _buildDonationAdminItem('تبرع صحي', 'أحمد الحربي', '٣,٠٠٠ ر.س', 'مكتمل', AppColors.success),
          _buildDonationAdminItem('تبرع تعليمي', 'سالم المطيري', '١,٥٠٠ ر.س', 'قيد المراجعة', AppColors.secondary),
          _buildDonationAdminItem('تبرع ملابس', 'نورة العتيبي', '٨٠٠ ر.س', 'مكتمل', AppColors.success),
        ],
      ),
    );
  }

  Widget _buildDonationAdminItem(String type, String donor, String amount, String status, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.donationGold.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.favorite, color: AppColors.donationGold, size: 20),
        ),
        title: Text(type, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(donor, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amount, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: AppColors.donationGold, fontSize: 13)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
              child: Text(status, style: TextStyle(fontFamily: 'Cairo', fontSize: 10, color: statusColor, fontWeight: FontWeight.bold)),
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
            'التقارير الإدارية',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildReportCard('التقرير الشهري - يوليو ٢٠٢٦', 'تقرير شامل عن الأداء', Icons.description, AppColors.adminPurple),
          _buildReportCard('تقرير التبرعات', 'إجمالي التبرعات والداعمين', Icons.favorite, AppColors.donationGold),
          _buildReportCard('تقرير الأيتام', 'حالة الأيتام المدعومين', Icons.child_care, AppColors.primary),
          _buildReportCard('تقرير الأسر', 'الأسر المستفيدة والطلبات', Icons.family_restroom, AppColors.familyBlue),
          _buildReportCard('تقرير الموظفين', 'أداء وحضور الموظفين', Icons.work, AppColors.employeeGreen),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('تصدير التقارير PDF', style: TextStyle(fontFamily: 'Cairo')),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.adminPurple),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {},
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'view', child: Text('عرض', style: TextStyle(fontFamily: 'Cairo'))),
            const PopupMenuItem(value: 'download', child: Text('تحميل', style: TextStyle(fontFamily: 'Cairo'))),
            const PopupMenuItem(value: 'share', child: Text('مشاركة', style: TextStyle(fontFamily: 'Cairo'))),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الإعدادات',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSettingsGroup('عام', [
            _buildSettingsItem(Icons.language, 'اللغة', 'العربية'),
            _buildSettingsItem(Icons.dark_mode, 'الوضع', 'فاتح'),
            _buildSettingsItem(Icons.notifications, 'الإشعارات', 'مفعّلة'),
          ]),
          const SizedBox(height: 16),
          _buildSettingsGroup('الأمان', [
            _buildSettingsItem(Icons.lock, 'كلمة المرور', 'آخر تغيير: ١٥/٠٧'),
            _buildSettingsItem(Icons.fingerprint, 'بصمة الوجه', 'مفعّل'),
            _buildSettingsItem(Icons.security, 'المصادقة الثنائية', 'مفعّلة'),
          ]),
          const SizedBox(height: 16),
          _buildSettingsGroup('الإدارة', [
            _buildSettingsItem(Icons.people_alt, 'إدارة الأدوار', '٤ أدوار'),
            _buildSettingsItem(Icons.backup, 'النسخ الاحتياطي', 'أوتوماتيك'),
            _buildSettingsItem(Icons.update, 'تحديث التطبيق', 'آخر تحديث: اليوم'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.adminPurple),
        ),
        const SizedBox(height: 8),
        Card(child: Column(children: children)),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.adminPurple, size: 22),
      title: Text(title, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600, fontSize: 14)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textHint),
        ],
      ),
      onTap: () {},
    );
  }
}
