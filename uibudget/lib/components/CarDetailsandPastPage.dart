// import 'package:flutter/material.dart';
// import 'package:uibudget/components/SummaryCardComponent.dart';

// class Cardetailsandpastpage extends StatefulWidget {
//   final String title;
//   final String name;
//   final String brand;
//   final String model;
//   final String year;

//   const Cardetailsandpastpage({
//     super.key,
//     required this.title,
//     required this.name,
//     required this.brand,
//     required this.model,
//     required this.year,
//   });

//   @override
//   State<StatefulWidget> createState() => _CardetailandpastpageState();
// }

// class _CardetailandpastpageState extends State<Cardetailsandpastpage> {
//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme; // Dinamik tema renkleri

//     final List<Map<String, dynamic>> expenses = [
//       {
//         "title": "Yakıt Alımı",
//         "description": "Opet İstasyonu",
//         "amount": "₺ 1.450.00",
//         "date": "14 Ağu",
//         "icon": Icons.local_gas_station,
//         "extraInfo": "₺ 41.50 / Lt",
//       },
//       {
//         "title": "Periyodik Bakım",
//         "description": "10.000 KM Bakımı (Yağ & Filtre Değişimi)",
//         "amount": "₺ 4.200.00",
//         "date": "10 Ağu",
//         "icon": Icons.engineering,
//       },
//       {
//         "title": "Otopark",
//         "description": "Zorlu Center AVM Otoparkı",
//         "amount": "₺ 150.00",
//         "date": "08 Ağu",
//         "icon": Icons.local_parking,
//       },
//       {
//         "title": "Oto Yıkama",
//         "description": "İç / Dış Cilalı Yıkama",
//         "amount": "₺ 350.00",
//         "date": "05 Ağu",
//         "icon": Icons.local_car_wash,
//       },
//     ];

//     // TÜM SAYFAYI KAYDIRILABİLİR YAPAN WIDGET
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // --- GÖRSEL ALANI ---
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(
//                 'assets/25004_01.webp',
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 180,
//               ),
//             ),
//             const SizedBox(height: 24),

//             // --- BAŞLIKLAR ---
//             Text(
//               "${widget.title} (${widget.name}'in Arabası)",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.2,
//                 color: colors.onSurface, // Dinamik Renk
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "${widget.brand} ${widget.model} - ${widget.year}",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: colors.onSurfaceVariant, // Dinamik Renk
//                 letterSpacing: 1.0,
//               ),
//             ),
//             const SizedBox(height: 24),

//             // --- ÜST KARTLAR ALANI ---
//             Row(
//               children: const [
//                 Expanded(
//                   child: SummaryCardComponent(
//                     title: "Kilometre",
//                     amount: "141.366",
//                     icon: Icons.speed,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: SummaryCardComponent(
//                     title: "Kapasite",
//                     amount: "35 Lt",
//                     icon: Icons.local_gas_station,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: SummaryCardComponent(
//                     title: "Tüketim",
//                     amount: "6.8 Lt",
//                     icon: Icons.trending_up,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),

//             // --- HARCAMALAR LİSTESİ BAŞLIĞI ---
//             Text(
//               "Tüketim & Harcama Geçmişi",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: colors.onSurface, // Dinamik Renk
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 16),

//             // --- LİSTE ALANI ---
//             ListView.builder(
//               shrinkWrap: true, // İçeriği kadar yer kapla (taşmayı önler)
//               physics:
//                   const NeverScrollableScrollPhysics(), // Kendi içinde kaydırmayı kapat, dışarıdaki ScrollView yönetsin
//               itemCount: expenses.length,
//               itemBuilder: (context, index) {
//                 final expense = expenses[index];
//                 return _buildExpenseCard(
//                   context, // Tema renkleri için context gönderiliyor
//                   title: expense["title"],
//                   description: expense["description"],
//                   amount: expense["amount"],
//                   date: expense["date"],
//                   icon: expense["icon"],
//                   extraInfo: expense["extraInfo"],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // --- HARCAMA KARTI WIDGET'I ---
//   Widget _buildExpenseCard(
//     BuildContext context, {
//     required String title,
//     required String description,
//     required String amount,
//     required String date,
//     required IconData icon,
//     String? extraInfo,
//   }) {
//     final colors = Theme.of(context).colorScheme;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: colors.surface, // Dinamik Zemin
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: colors.onSurfaceVariant.withOpacity(0.15),
//           width: 1,
//         ),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: colors.primary.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: colors.primary, size: 24),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: colors.onSurface, // Dinamik Metin
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 4),
//             Text(
//               description,
//               style: TextStyle(
//                 color: colors.onSurfaceVariant,
//                 fontSize: 13,
//               ), // Dinamik Alt Metin
//             ),
//             if (extraInfo != null)
//               Container(
//                 margin: const EdgeInsets.only(top: 8),
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: colors.primary.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Text(
//                   extraInfo,
//                   style: TextStyle(
//                     color: colors.primary,
//                     fontSize: 11,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               amount,
//               style: TextStyle(
//                 color: colors.onSurface, // Dinamik Metin
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               date,
//               style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:uibudget/components/SummaryCardComponent.dart';

class Cardetailsandpastpage extends StatefulWidget {
  const Cardetailsandpastpage({super.key}); // Sabit parametreler kaldırıldı

  @override
  State<StatefulWidget> createState() => _CardetailandpastpageState();
}

class _CardetailandpastpageState extends State<Cardetailsandpastpage> {
  // --- ARAÇ DURUM YÖNETİMİ ---
  bool _hasCarData = false; // Başlangıçta araç yok (Empty State)

  // Geçiçi olarak formdan alınacak verileri tutacağımız değişkenler
  String _carBrand = "";
  String _carModel = "";
  String _carYear = "";
  String _carTitle = "";

  // --- HARCAMA LİSTESİ (Test İçin Boş) ---
  final List<Map<String, dynamic>> expenses = [];

  // --- FOTOĞRAF SEÇİM PENCERESİ ---
  void _showPhotoSelection() {
    final colors = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.onSurfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt_outlined, color: colors.primary),
                ),
                title: Text(
                  "Kamera ile Çek",
                  style: TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Kamera servisi eklenecek
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.secondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.photo_library_outlined,
                    color: colors.secondary,
                  ),
                ),
                title: Text(
                  "Galeriden Seç",
                  style: TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Galeri servisi eklenecek
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- ARAÇ BİLGİLERİ EKLEME FORMU ---
  void _showAddCarForm() {
    final colors = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.onSurfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Araç Bilgilerini Gir",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                "Aracın Takma Adı (Örn: Şehir Canavarı)",
                icon: Icons.favorite_border,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Marka (Örn: Toyota)",
                      icon: Icons.directions_car_outlined,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Model (Örn: Yaris)",
                      icon: Icons.info_outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Yıl",
                      icon: Icons.calendar_today,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Depo Hacmi (Lt)",
                      icon: Icons.local_gas_station_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Mevcut Kilometre",
                icon: Icons.speed,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // Test amaçlı sahte verilerle UI'ı dolu duruma geçiriyoruz
                    setState(() {
                      _hasCarData = true;
                      _carTitle = "Şehir Canavarı";
                      _carBrand = "Toyota";
                      _carModel = "Yaris";
                      _carYear = "2017";
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "KAYDET",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. DİNAMİK ARAÇ FOTOĞRAFI & PROFİL ALANI
            // ==========================================
            if (!_hasCarData) ...[
              // --- BOŞ DURUM (EMPTY STATE) ---
              InkWell(
                onTap: _showPhotoSelection,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colors.primary.withOpacity(0.3),
                      width: 2,
                      style: BorderStyle.solid,
                    ), // İleride dotted_border paketi ile kesik çizgili yapılabilir
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                        color: colors.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Araç Fotoğrafı Ekle",
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.surface,
                    foregroundColor: colors.onSurface,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                      color: colors.onSurfaceVariant.withOpacity(0.2),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    Icons.directions_car_outlined,
                    color: colors.primary,
                  ),
                  label: const Text(
                    "Araç Bilgilerini Gir",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  onPressed: _showAddCarForm,
                ),
              ),
            ] else ...[
              // --- DOLU DURUM (CAR EXISTS) ---
              InkWell(
                onTap:
                    _showPhotoSelection, // Doluyken de resim değiştirmek için tıklanabilir
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/25004_01.webp', // Profil doluysa gösterilecek resim
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 180,
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _carTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$_carBrand $_carModel - $_carYear",
                        style: TextStyle(
                          fontSize: 16,
                          color: colors.onSurfaceVariant,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_note, color: colors.primary),
                    onPressed: _showAddCarForm, // Bilgileri düzenle
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),

            // ==========================================
            // 2. ÜST KARTLAR ALANI (Özet)
            // ==========================================
            Row(
              children: [
                Expanded(
                  child: SummaryCardComponent(
                    title: "Kilometre",
                    amount: _hasCarData ? "141.366" : "-",
                    icon: Icons.speed,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SummaryCardComponent(
                    title: "Kapasite",
                    amount: _hasCarData ? "35 Lt" : "-",
                    icon: Icons.local_gas_station,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SummaryCardComponent(
                    title: "Tüketim",
                    amount: _hasCarData ? "6.8 Lt" : "-",
                    icon: Icons.trending_up,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // ==========================================
            // 3. HARCAMALAR LİSTESİ ALANI
            // ==========================================
            Text(
              "Tüketim & Harcama Geçmişi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),

            expenses.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colors.onSurfaceVariant.withOpacity(0.15),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 48,
                          color: colors.onSurfaceVariant.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Bu araca ait henüz bir harcama eklemediniz.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return _buildExpenseCard(
                        context,
                        title: expense["title"],
                        description: expense["description"],
                        amount: expense["amount"],
                        date: expense["date"],
                        icon: expense["icon"],
                        extraInfo: expense["extraInfo"],
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  // --- YARDIMCI WIDGET: Modern TextField (Form İçin) ---
  Widget _buildTextField(
    String label, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      keyboardType: keyboardType,
      style: TextStyle(color: colors.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colors.onSurfaceVariant, fontSize: 14),
        prefixIcon: icon != null
            ? Icon(icon, color: colors.primary, size: 20)
            : null,
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colors.onSurfaceVariant.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colors.onSurfaceVariant.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  // --- HARCAMA KARTI WIDGET'I ---
  Widget _buildExpenseCard(
    BuildContext context, {
    required String title,
    required String description,
    required String amount,
    required String date,
    required IconData icon,
    String? extraInfo,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.onSurfaceVariant.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: colors.primary, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
            ),
            if (extraInfo != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  extraInfo,
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                color: colors.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              date,
              style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
