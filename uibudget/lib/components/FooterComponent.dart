import 'package:flutter/material.dart';

class Footercomponent extends StatelessWidget {
  const Footercomponent({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Anasayfa"),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.stacked_line_chart),
        //   label: "İstatistik",
        // ),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Ekle"),
        BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "Profil"),
      ],
    );
  }
}
