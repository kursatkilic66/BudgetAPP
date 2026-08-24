import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:uibudget/main.dart'; // themeNotifier'a erişmek için kendi main.dart yolunu ekle

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Tema & Görünüm")),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "UYGULAMA TEMASI",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: colors.onSurfaceVariant,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colors.onSurfaceVariant.withOpacity(0.15),
              ),
            ),
            child: Column(
              children: [
                _buildThemeOption(
                  title: "Sistem Varsayılanı",
                  subtitle: "Cihazınızın temasına otomatik uyar",
                  icon: BootstrapIcons.display,
                  mode: ThemeMode.system,
                  colors: colors,
                ),
                Divider(
                  height: 1,
                  color: colors.onSurfaceVariant.withOpacity(0.1),
                ),
                _buildThemeOption(
                  title: "Aydınlık Mod",
                  subtitle: "Modern pastel ve ferah görünüm",
                  icon: BootstrapIcons.sun,
                  mode: ThemeMode.light,
                  colors: colors,
                ),
                Divider(
                  height: 1,
                  color: colors.onSurfaceVariant.withOpacity(0.1),
                ),
                _buildThemeOption(
                  title: "Karanlık Mod",
                  subtitle: "Gece ve gül kurusu tonları",
                  icon: BootstrapIcons.moon_stars,
                  mode: ThemeMode.dark,
                  colors: colors,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode mode,
    required ColorScheme colors,
  }) {
    final bool isSelected = themeNotifier.value == mode;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary.withOpacity(0.15)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? colors.primary : colors.onSurfaceVariant,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: colors.onSurface,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          fontSize: 15,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: colors.primary)
          : null,
      onTap: () {
        // Temayı anında değiştir
        setState(() {
          themeNotifier.value = mode;
        });
      },
    );
  }
}
