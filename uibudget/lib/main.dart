import 'package:flutter/material.dart';
import 'package:uibudget/components/CarDetailsandPastPage.dart';
import 'package:uibudget/components/DrawerComponent.dart';
import 'package:uibudget/components/SummaryPage.dart';
import 'package:uibudget/components/FooterComponent.dart'; // Footer'ı import etmeyi unutma

void main() {
  runApp(const MyApp());
}

// --- MERKEZİ TEMA RENKLERİ ---
const Color bgDark = Color(0xFF181216); // Ana Zemin
const Color cardDark = Color(0xFF241A21); // Kart ve AppBar Zemini
const Color accentPink = Color(0xFFFF7EB3); // Vurgu Pembesi
const Color textLight = Color(0xFFF3E8EE); // Ana Metin
const Color textMuted = Color(0xFF8B7382); // Alt Metin

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDark,

        // Merkezi AppBar Tasarımı
        appBarTheme: const AppBarTheme(
          backgroundColor: bgDark,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: accentPink),
          titleTextStyle: TextStyle(
            color: textLight,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),

        // Drawer Merkezi Tasarımı
        expansionTileTheme: const ExpansionTileThemeData(
          textColor: accentPink,
          collapsedTextColor: textLight,
          iconColor: accentPink,
          collapsedIconColor: textMuted,
          backgroundColor: cardDark,
          collapsedBackgroundColor: Colors.transparent,
          childrenPadding: EdgeInsets.only(left: 16),
        ),

        // --- YENİ: Footer (BottomNavigationBar) Merkezi Tasarımı ---
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: cardDark, // Alt menü zemini kartlarla uyumlu olsun
          selectedItemColor: accentPink, // Seçili olan pembe parlasın
          unselectedItemColor: textMuted, // Seçili olmayanlar soluk gül kurusu
          showUnselectedLabels:
              true, // Seçili olmayanların yazısı görünsün mü? (İsteğe bağlı)
          type: BottomNavigationBarType.fixed,
          elevation: 8, // Üstte hafif bir gölge oluşturur
        ),
      ),
      home: const MyHomePage(title: 'Bütçe Özeti'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: textMuted),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawercomponent(semanticLabel: "Kürşat"),
      // body: const Summarypage(userName: "Kürşat"),
      body: Cardetailsandpastpage(
        title: "Sally",
        name: "Kürşat",
        brand: "Toyota",
        model: "Yaris",
        year: "2017",
      ),

      // YENİ: Footer bileşenini Scaffold'un bottomNavigationBar özelliğine ekliyoruz
      bottomNavigationBar: const Footercomponent(),
    );
  }
}
