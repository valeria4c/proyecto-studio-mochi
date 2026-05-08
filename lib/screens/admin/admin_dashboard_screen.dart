import 'package:flutter/material.dart';
import '../../widgets/custom_banner.dart';
import '../../widgets/custom_footer.dart';
import '../../services/auth_service.dart';
import '../photographers/photographers_list_screen.dart';
import '../sessions/sessions_list_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          const CustomBanner(title: 'Panel de Administración'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildDashboardCard(
                    context,
                    title: 'Fotógrafos',
                    icon: Icons.camera_enhance,
                    color: const Color(0xFF384057),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PhotographersListScreen()),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Sesiones de Fotos',
                    icon: Icons.photo_library,
                    color: const Color(0xFF2E3B6E),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SessionsListScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const CustomFooter(),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: color.withAlpha(25),
              child: Icon(icon, size: 40, color: color),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
