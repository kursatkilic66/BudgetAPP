// import 'package:flutter/material.dart';

// class AddExpensePage extends StatefulWidget {
//   final String initialCategory;

//   const AddExpensePage({super.key, required this.initialCategory});

//   @override
//   State<AddExpensePage> createState() => _AddExpensePageState();
// }

// class _AddExpensePageState extends State<AddExpensePage> {
//   late String _selectedCategory;

//   // C# Enumlarına karşılık gelen listeler
//   final List<String> _categories = [
//     "Yakıt",
//     "Otopark",
//     "Geçiş",
//     "Araç Bakım/Diğer",
//     "Yemek",
//   ];
//   final List<String> _gasStations = ["Petrol_Ofisi", "Shell", "Opet", "Total"];
//   final List<String> _paymentTypes = ["Credit_Card", "Cash"];

//   String _selectedStation = "Opet";
//   String _selectedPayment = "Credit_Card";

//   @override
//   void initState() {
//     super.initState();
//     // main.dart'tan gelen varsayılan kategoriyi ayarla
//     _selectedCategory = _categories.contains(widget.initialCategory)
//         ? widget.initialCategory
//         : "Yakıt";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Harcama Ekle")),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // --- 1. KATEGORİ SEÇİCİ (Aşağı Açılan Özel Menü) ---
//             Text(
//               "Harcama Türü",
//               style: TextStyle(
//                 color: colors.onSurfaceVariant,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 13,
//               ),
//             ),
//             const SizedBox(height: 8),

//             PopupMenuButton<String>(
//               initialValue: _selectedCategory,
//               offset: const Offset(0, 56), // Menüyü tam kutunun altına iter
//               color: colors.surface,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               onSelected: (String newValue) {
//                 setState(() {
//                   _selectedCategory = newValue;
//                 });
//               },
//               itemBuilder: (context) {
//                 return _categories.map((String category) {
//                   return PopupMenuItem<String>(
//                     value: category,
//                     child: Text(
//                       category,
//                       style: TextStyle(color: colors.onSurface, fontSize: 15),
//                     ),
//                   );
//                 }).toList();
//               },
//               // Ekranda görünen kutu tasarımı
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 16,
//                 ),
//                 decoration: BoxDecoration(
//                   color: colors.surface,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: colors.onSurfaceVariant.withOpacity(0.2),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       _selectedCategory,
//                       style: TextStyle(
//                         color: colors.onSurface,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Icon(Icons.keyboard_arrow_down, color: colors.primary),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // --- 2. DİNAMİK FORM ALANLARI ---

//             // YAKIT (FuelOrder.cs) -> unit_price, total_price, fuel_liter, station
//             if (_selectedCategory == "Yakıt") ...[
//               _buildCustomDropdownField(
//                 "İstasyon",
//                 _gasStations,
//                 _selectedStation,
//                 (val) => setState(() => _selectedStation = val),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildTextField(
//                       "Litre",
//                       icon: Icons.water_drop_outlined,
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildTextField(
//                       "Birim Fiyat (₺)",
//                       icon: Icons.price_change_outlined,
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Toplam Tutar (₺)",
//                 icon: Icons.account_balance_wallet_outlined,
//                 keyboardType: TextInputType.number,
//               ),
//             ],

//             // OTOPARK (ParkingOrder.cs) -> parking_name, total_price, hour, payment_type
//             if (_selectedCategory == "Otopark") ...[
//               _buildTextField("Otopark Adı", icon: Icons.local_parking),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildTextField(
//                       "Süre (Saat)",
//                       icon: Icons.schedule,
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildTextField(
//                       "Toplam Tutar (₺)",
//                       icon: Icons.account_balance_wallet_outlined,
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               _buildCustomDropdownField(
//                 "Ödeme Yöntemi",
//                 _paymentTypes,
//                 _selectedPayment,
//                 (val) => setState(() => _selectedPayment = val),
//               ),
//             ],

//             // YEMEK & YAŞAM (FoodOrder.cs) -> food_name, price, restaurant
//             if (_selectedCategory == "Yemek") ...[
//               _buildTextField(
//                 "Yemek / Harcama Adı",
//                 icon: Icons.fastfood_outlined,
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Restoran / Mekan",
//                 icon: Icons.storefront_outlined,
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Toplam Tutar (₺)",
//                 icon: Icons.account_balance_wallet_outlined,
//                 keyboardType: TextInputType.number,
//               ),
//             ],

//             // GEÇİŞ (PassingOrder.cs) -> name, price, payment_type
//             if (_selectedCategory == "Geçiş") ...[
//               _buildTextField(
//                 "Gişe / Geçiş Adı (HGS vs.)",
//                 icon: Icons.sensors,
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Geçiş Ücreti (₺)",
//                 icon: Icons.account_balance_wallet_outlined,
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 16),
//               _buildCustomDropdownField(
//                 "Ödeme Yöntemi",
//                 _paymentTypes,
//                 _selectedPayment,
//                 (val) => setState(() => _selectedPayment = val),
//               ),
//             ],

//             // DİĞER ARAÇ GİDERLERİ (OtherCarOrder.cs & CarItem.cs)
//             if (_selectedCategory == "Araç Bakım/Diğer") ...[
//               _buildTextField(
//                 "Harcama Adı (Örn: Silecek, Yıkama)",
//                 icon: Icons.build_circle_outlined,
//               ),
//               const SizedBox(height: 16),
//               _buildTextField("Açıklama", icon: Icons.description_outlined),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Tutar (₺)",
//                 icon: Icons.account_balance_wallet_outlined,
//                 keyboardType: TextInputType.number,
//               ),
//             ],

//             const SizedBox(height: 40),

//             // --- KAYDET BUTONU ---
//             SizedBox(
//               width: double.infinity,
//               height: 54,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: colors.primary,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 2,
//                 ),
//                 onPressed: () {
//                   // TODO: Buradan API'ye HTTP POST atılacak
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: const Text("Harcama başarıyla kaydedildi!"),
//                       backgroundColor: colors.primary,
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   "KAYDET",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.0,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // --- YARDIMCI WIDGET: Modern TextField ---
//   Widget _buildTextField(
//     String label, {
//     IconData? icon,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     final colors = Theme.of(context).colorScheme;
//     return TextField(
//       keyboardType: keyboardType,
//       style: TextStyle(color: colors.onSurface),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: colors.onSurfaceVariant),
//         prefixIcon: icon != null ? Icon(icon, color: colors.primary) : null,
//         filled: true,
//         fillColor: colors.surface,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: colors.primary, width: 1.5),
//         ),
//       ),
//     );
//   }

//   // --- YARDIMCI WIDGET: Kendi Yaptığımız "Hep Aşağı Açılan" Dropdown ---
//   Widget _buildCustomDropdownField(
//     String label,
//     List<String> items,
//     String currentValue,
//     Function(String) onChanged,
//   ) {
//     final colors = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             color: colors.onSurfaceVariant,
//             fontWeight: FontWeight.bold,
//             fontSize: 13,
//           ),
//         ),
//         const SizedBox(height: 8),
//         PopupMenuButton<String>(
//           initialValue: currentValue,
//           offset: const Offset(0, 56), // Menüyü aşağı iter
//           color: colors.surface,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           onSelected: onChanged,
//           itemBuilder: (context) {
//             return items.map((String item) {
//               return PopupMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item.replaceAll("_", " "),
//                   style: TextStyle(color: colors.onSurface, fontSize: 15),
//                 ),
//               );
//             }).toList();
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             decoration: BoxDecoration(
//               color: colors.surface,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: colors.onSurfaceVariant.withOpacity(0.1),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   currentValue.replaceAll("_", " "),
//                   style: TextStyle(color: colors.onSurface, fontSize: 15),
//                 ),
//                 Icon(Icons.arrow_drop_down, color: colors.onSurfaceVariant),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  final String initialCategory;

  const AddExpensePage({super.key, required this.initialCategory});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  late String _selectedCategory;

  final List<String> _categories = [
    "Yakıt",
    "Otopark",
    "Geçiş",
    "Araç Bakım/Diğer",
    "Yemek",
  ];
  final List<String> _gasStations = ["Petrol_Ofisi", "Shell", "Opet", "Total"];
  final List<String> _paymentTypes = ["Credit_Card", "Cash"];

  String _selectedStation = "Opet";
  String _selectedPayment = "Credit_Card";

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories.contains(widget.initialCategory)
        ? widget.initialCategory
        : "Yakıt";
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Harcama Ekle")),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. KATEGORİ SEÇİCİ (Aşağı Açılan Özel Menü) ---
            Text(
              "Harcama Türü",
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),

            PopupMenuButton<String>(
              initialValue: _selectedCategory,
              offset: const Offset(0, 56),
              color: colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              // Menünün tam ekran genişliğinde olmasını sağlar (20 sol + 20 sağ padding = 40)
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width - 40,
              ),
              onSelected: (String newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              itemBuilder: (context) {
                return _categories.map((String category) {
                  return PopupMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: TextStyle(color: colors.onSurface, fontSize: 15),
                    ),
                  );
                }).toList();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colors.onSurfaceVariant.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCategory,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: colors.primary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- 2. DİNAMİK FORM ALANLARI ---
            if (_selectedCategory == "Yakıt") ...[
              _buildCustomDropdownField(
                "İstasyon",
                _gasStations,
                _selectedStation,
                (val) => setState(() => _selectedStation = val),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Litre",
                      icon: Icons.water_drop_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Birim Fiyat (₺)",
                      icon: Icons.price_change_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Toplam Tutar (₺)",
                icon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
              ),
            ],

            if (_selectedCategory == "Otopark") ...[
              _buildTextField("Otopark Adı", icon: Icons.local_parking),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Süre (Saat)",
                      icon: Icons.schedule,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Toplam Tutar (₺)",
                      icon: Icons.account_balance_wallet_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildCustomDropdownField(
                "Ödeme Yöntemi",
                _paymentTypes,
                _selectedPayment,
                (val) => setState(() => _selectedPayment = val),
              ),
            ],

            if (_selectedCategory == "Yemek") ...[
              _buildTextField(
                "Yemek / Harcama Adı",
                icon: Icons.fastfood_outlined,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Restoran / Mekan",
                icon: Icons.storefront_outlined,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Toplam Tutar (₺)",
                icon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
              ),
            ],

            if (_selectedCategory == "Geçiş") ...[
              _buildTextField(
                "Gişe / Geçiş Adı (HGS vs.)",
                icon: Icons.sensors,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Geçiş Ücreti (₺)",
                icon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildCustomDropdownField(
                "Ödeme Yöntemi",
                _paymentTypes,
                _selectedPayment,
                (val) => setState(() => _selectedPayment = val),
              ),
            ],

            if (_selectedCategory == "Araç Bakım/Diğer") ...[
              _buildTextField(
                "Harcama Adı (Örn: Silecek, Yıkama)",
                icon: Icons.build_circle_outlined,
              ),
              const SizedBox(height: 16),
              _buildTextField("Açıklama", icon: Icons.description_outlined),
              const SizedBox(height: 16),
              _buildTextField(
                "Tutar (₺)",
                icon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
              ),
            ],

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Harcama başarıyla kaydedildi!"),
                      backgroundColor: colors.primary,
                    ),
                  );
                },
                child: const Text(
                  "KAYDET",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        labelStyle: TextStyle(color: colors.onSurfaceVariant),
        prefixIcon: icon != null ? Icon(icon, color: colors.primary) : null,
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildCustomDropdownField(
    String label,
    List<String> items,
    String currentValue,
    Function(String) onChanged,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        PopupMenuButton<String>(
          initialValue: currentValue,
          offset: const Offset(0, 56),
          color: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // Alt menü için de genişlik kısıtlaması eklendi
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 40,
          ),
          onSelected: onChanged,
          itemBuilder: (context) {
            return items.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                child: Text(
                  item.replaceAll("_", " "),
                  style: TextStyle(color: colors.onSurface, fontSize: 15),
                ),
              );
            }).toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colors.onSurfaceVariant.withOpacity(0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentValue.replaceAll("_", " "),
                  style: TextStyle(color: colors.onSurface, fontSize: 15),
                ),
                Icon(Icons.arrow_drop_down, color: colors.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
