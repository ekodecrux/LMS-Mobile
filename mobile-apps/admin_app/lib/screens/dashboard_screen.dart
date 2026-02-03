import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic> _stats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);
    try {
      final apiService = Provider.of<ApiService>(context, listen: false);
      final stats = await apiService.getDashboardStats();
      setState(() {
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;

    return RefreshIndicator(
      onRefresh: _loadStats,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Text(
                      user?['name']?[0]?.toUpperCase() ?? 'A',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF59E0B),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back,',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          user?['name'] ?? 'Admin',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard(
                  icon: Icons.people_rounded,
                  label: 'Total Users',
                  value: '${_stats['total_users'] ?? 0}',
                  color: Colors.blue,
                ),
                _buildStatCard(
                  icon: Icons.class_rounded,
                  label: 'Classes',
                  value: '${_stats['total_classes'] ?? 0}',
                  color: Colors.green,
                ),
                _buildStatCard(
                  icon: Icons.school_rounded,
                  label: 'Students',
                  value: '${_stats['total_students'] ?? 0}',
                  color: Colors.purple,
                ),
                _buildStatCard(
                  icon: Icons.person_outline,
                  label: 'Teachers',
                  value: '${_stats['total_teachers'] ?? 0}',
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Management Grid
            const Text(
              'Institute Management',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildManagementIcon(
                  icon: Icons.person_add,
                  label: 'Add User',
                  color: const Color(0xFF3B82F6),
                  onTap: () {},
                ),
                _buildManagementIcon(
                  icon: Icons.class_,
                  label: 'Classes',
                  color: const Color(0xFF10B981),
                  onTap: () {},
                ),
                _buildManagementIcon(
                  icon: Icons.account_balance_wallet,
                  label: 'Fee Mgmt',
                  color: const Color(0xFFF59E0B),
                  onTap: () {},
                ),
                _buildManagementIcon(
                  icon: Icons.how_to_reg,
                  label: 'Attendance',
                  color: const Color(0xFF8B5CF6),
                  onTap: () {},
                ),
                _buildManagementIcon(
                  icon: Icons.library_books,
                  label: 'Library',
                  color: const Color(0xFFEC4899),
                  onTap: () {},
                ),
                _buildManagementIcon(
                  icon: Icons.store,
                  label: 'Store',
                  color: const Color(0xFF06B6D4),
                  onTap: () {},
                ),
                _buildManagementIcon(
                  icon: Icons.assessment,
                  label: 'Reports',
                  color: const Color(0xFFEF4444),
                  onTap: () {},
                ),
                _buildManagementIcon(
                  icon: Icons.notifications,
                  label: 'Alerts',
                  color: const Color(0xFFF97316),
                  onTap: () {},
                ),
                _buildManagementIcon(
                  icon: Icons.settings,
                  label: 'Settings',
                  color: const Color(0xFF64748B),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementIcon({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
