import 'package:material_ui/material_ui.dart';
import 'package:portfolio_mobile/screens/menu.dart';
import 'package:portfolio_mobile/screens/experience_form.dart';
import 'package:portfolio_mobile/screens/experience_list.dart';
import 'package:portfolio_mobile/screens/project_form.dart';
import 'package:portfolio_mobile/screens/project_list.dart';
import 'package:portfolio_mobile/services/auth_state.dart';
import 'package:portfolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // Setiap ItemCard memakai warnanya sendiri dari model ItemHomepage.
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Area responsif terhadap sentuhan
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );

          if (item.name == "Lihat Proyek") {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProjectListPage()),
            );
          } else if (item.name == "Tambah Proyek") {
            final authorized = await ensureLoggedIn(context);
            if (!authorized || !context.mounted) return;
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProjectFormPage()),
            );
          } else if (item.name == "Lihat Pengalaman") {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExperienceListPage()),
            );
          } else if (item.name == "Tambah Pengalaman") {
            final authorized = await ensureLoggedIn(context);
            if (!authorized || !context.mounted) return;
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExperienceFormPage()),
            );
          } else if (item.name == "Logout") {
            if (!context.read<AuthState>().isLoggedIn) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Anda belum login.')),
              );
              return;
            }
            await context.read<AuthState>().logout();
            if (!context.mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Anda telah logout.')));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
