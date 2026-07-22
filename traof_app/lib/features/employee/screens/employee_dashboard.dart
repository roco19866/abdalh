import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/stats_card.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الموظف'),
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
          _buildTasksTab(),
          _buildLeaveTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'المهام'),
          BottomNavigationBarItem(icon: Icon(Icons.event_busy), label: 'الإجازات'),
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
                colors: [AppColors.employeeGreen, Color(0xFF2E7D32)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مرحباً بك، موظف متميز',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.work, color: Colors.white70, size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'مدير ميداني',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white70, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'تاريخ الانضمام: ٠١/٠١/٢٠٢٦',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.white.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'المهام النشطة',
                  value: '٤',
                  icon: Icons.task_alt,
                  color: AppColors.employeeGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  title: 'المهام المكتملة',
                  value: '١٢',
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
                  title: 'أيام الإجازة المتبقية',
                  value: '١٥',
                  icon: Icons.event,
                  color: AppColors.familyBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  title: 'الزيارات الميدانية',
                  value: '٨',
                  icon: Icons.location_on,
                  color: AppColors.donationGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'مهام اليوم',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildTaskItem('زيارة الأسرة - حي النرجس', '٠٩:٠٠ صباحاً', AppColors.primary, true),
          _buildTaskItem('تسليم تقرير الأيتام', '١٢:٠٠ ظهراً', AppColors.secondary, false),
          _buildTaskItem('اجتماع فريق العمل', '٠٢:٠٠ ظهراً', AppColors.familyBlue, false),
          _buildTaskItem('متابعة طلب علاج', '٠٣:٣٠ عصراً', AppColors.employeeGreen, false),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, String time, Color color, bool isCompleted) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: (value) {},
          activeColor: AppColors.success,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? AppColors.textHint : AppColors.textPrimary,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.access_time, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              time,
              style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: color),
            ),
          ],
        ),
        trailing: Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildTasksTab() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: AppColors.employeeGreen,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.employeeGreen,
            labelStyle: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'النشطة'),
              Tab(text: 'قيد الانتظار'),
              Tab(text: 'المكتملة'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTasksList([
                  {'title': 'زيارة الأسرة', 'desc': 'حي النرجس - تقرير الأيتام', 'priority': 'عالية'},
                  {'title': 'تسليم تقرير', 'desc': 'تقرير شهري - الأيتام المدعومين', 'priority': 'متوسطة'},
                ]),
                _buildTasksList([
                  {'title': 'متابعة طلب علاج', 'desc': 'طلب علاج أسنان - انتظار موافقة', 'priority': 'منخفضة'},
                  {'title': 'تحضير عروض', 'desc': 'عروض تقديمية للاجتماع', 'priority': 'متوسطة'},
                ]),
                _buildTasksList([
                  {'title': 'زيارة سابقة', 'desc': 'حي الورود - تم بنجاح', 'priority': 'منجزة'},
                  {'title': 'تقرير تسليم', 'desc': 'تقرير يونيو - تم التسليم', 'priority': 'منجزة'},
                  {'title': 'تسجيل أسرة', 'desc': 'أسرة جديدة - تم التسجيل', 'priority': 'منجزة'},
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList(List<Map<String, String>> tasks) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.padding),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final priorityColor = task['priority'] == 'عالية'
            ? AppColors.error
            : task['priority'] == 'متوسطة'
                ? AppColors.secondary
                : task['priority'] == 'منجزة'
                    ? AppColors.success
                    : AppColors.textHint;
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
                      task['title']!,
                      style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: priorityColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        task['priority']!,
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 11, color: priorityColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  task['desc']!,
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeaveTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'طلبات الإجازة',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () => _showLeaveRequestDialog(),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('طلب إجازة', style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildLeaveCard('إجازة مرضية', '٢٠/٠٧/٢٠٢٦ - ٢٢/٠٧/٢٠٢٦', 'تمت الموافقة', AppColors.success),
          _buildLeaveCard('إجازة سنوية', '٠١/٠٨/٢٠٢٦ - ٠٥/٠٨/٢٠٢٦', 'قيد المراجعة', AppColors.secondary),
          _buildLeaveCard('إجازة طارئة', '١٥/٠٦/٢٠٢٦', 'تمت الموافقة', AppColors.success),
        ],
      ),
    );
  }

  Widget _buildLeaveCard(String type, String dates, String status, Color statusColor) {
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
                  type,
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
            Row(
              children: [
                const Icon(Icons.date_range, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  dates,
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
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
            backgroundColor: AppColors.employeeGreen,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            'خالد العتيبي',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            'مدير ميداني',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.employeeGreen),
          ),
          const SizedBox(height: 24),
          _buildProfileMenuItem(Icons.person_outline, 'الملف الشخصي'),
          _buildProfileMenuItem(Icons.task_alt, 'سجل المهام'),
          _buildProfileMenuItem(Icons.event, 'سجل الإجازات'),
          _buildProfileMenuItem(Icons.location_on, 'الزيارات الميدانية'),
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

  void _showLeaveRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('طلب إجازة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'نوع الإجازة', labelStyle: TextStyle(fontFamily: 'Cairo')),
                items: const [
                  DropdownMenuItem(value: 'سنوية', child: Text('إجازة سنوية', style: TextStyle(fontFamily: 'Cairo'))),
                  DropdownMenuItem(value: 'مرضية', child: Text('إجازة مرضية', style: TextStyle(fontFamily: 'Cairo'))),
                  DropdownMenuItem(value: 'طارئة', child: Text('إجازة طارئة', style: TextStyle(fontFamily: 'Cairo'))),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(labelText: 'من تاريخ', labelStyle: TextStyle(fontFamily: 'Cairo')),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(labelText: 'إلى تاريخ', labelStyle: TextStyle(fontFamily: 'Cairo')),
              ),
              const SizedBox(height: 12),
              const TextField(
                maxLines: 2,
                decoration: InputDecoration(labelText: 'السبب', labelStyle: TextStyle(fontFamily: 'Cairo')),
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
