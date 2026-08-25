// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uibudget/components/SummaryCardComponent.dart';

// class Cardetailsandpastpage extends StatefulWidget {
//   const Cardetailsandpastpage({super.key});

//   @override
//   State<StatefulWidget> createState() => _CardetailandpastpageState();
// }

// class _CardetailandpastpageState extends State<Cardetailsandpastpage> {
//   final String _baseUrl = "http://10.0.2.2:5268";

//   bool _hasCarData = false;
//   bool _hasPhoto = false;
//   bool _isLoading = true;
//   bool _isSavingCar = false;

//   String _carTitle = "";
//   String _carBrand = "";
//   String _carModel = "";
//   String _carYear = "";
//   String _carTank = "";
//   String _carKm = "";

//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _brandController = TextEditingController();
//   final TextEditingController _modelController = TextEditingController();
//   final TextEditingController _yearController = TextEditingController();
//   final TextEditingController _tankController = TextEditingController();
//   final TextEditingController _kmController = TextEditingController();

//   List<Map<String, dynamic>> expenses = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchCarDataAndExpenses();
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _brandController.dispose();
//     _modelController.dispose();
//     _yearController.dispose();
//     _tankController.dispose();
//     _kmController.dispose();
//     super.dispose();
//   }

//   String _formatDate(String? isoString) {
//     if (isoString == null) return "";
//     try {
//       DateTime date = DateTime.parse(isoString);
//       List<String> months = [
//         "",
//         "Oca",
//         "Şub",
//         "Mar",
//         "Nis",
//         "May",
//         "Haz",
//         "Tem",
//         "Ağu",
//         "Eyl",
//         "Eki",
//         "Kas",
//         "Ara",
//       ];
//       return "${date.day} ${months[date.month]}";
//     } catch (e) {
//       return "";
//     }
//   }

//   Future<void> _fetchCarDataAndExpenses() async {
//     setState(() => _isLoading = true);

//     try {
//       // 1. Resim Durumunu Localden Çek
//       final prefs = await SharedPreferences.getInstance();
//       _hasPhoto = prefs.getBool('hasCarPhoto') ?? false;

//       // 2. Önce kayıtlı araç var mı kontrol edelim (/api/Cars)
//       final carRes = await http.get(Uri.parse("$_baseUrl/api/Cars"));
//       if (carRes.statusCode == 200) {
//         var cars = jsonDecode(carRes.body);
//         if (cars is List && cars.isNotEmpty) {
//           var car = cars[0];
//           setState(() {
//             _hasCarData = true;
//             _carTitle = car['title'] ?? car['Title'] ?? "Aracım";
//             _carBrand = car['brand'] ?? car['Brand'] ?? "";
//             _carModel = car['model'] ?? car['Model'] ?? "";
//             _carYear = (car['year'] ?? car['Year'] ?? "").toString();
//             _carTank = (car['tankSize'] ?? car['TankSize'] ?? "").toString();
//             _carKm = (car['kilometer'] ?? car['Kilometer'] ?? "").toString();
//           });
//         }
//       }

//       List<Map<String, dynamic>> tempList = [];

//       final fuelRes = await http.get(Uri.parse("$_baseUrl/api/FuelOrders"));
//       if (fuelRes.statusCode == 200) {
//         for (var item in jsonDecode(fuelRes.body)) {
//           tempList.add({
//             "title": "Yakıt Alımı",
//             "description": "İstasyon: Petrol Ofisi",
//             "amount": "₺ ${item['total_price'] ?? item['Total_price'] ?? 0}",
//             "date": _formatDate(item['orderAt'] ?? item['OrderAt']),
//             "sortDate":
//                 DateTime.tryParse(item['orderAt'] ?? item['OrderAt'] ?? "") ??
//                 DateTime.now(),
//             "icon": Icons.local_gas_station,
//             "extraInfo": "₺ ${item['unit_price'] ?? item['Unit_price']} / Lt",
//           });
//         }
//       }

//       final parkRes = await http.get(Uri.parse("$_baseUrl/api/ParkingOrders"));
//       if (parkRes.statusCode == 200) {
//         for (var item in jsonDecode(parkRes.body)) {
//           tempList.add({
//             "title": "Otopark",
//             "description":
//                 item['parking_name'] ?? item['Parking_name'] ?? "Otopark",
//             "amount": "₺ ${item['total_price'] ?? item['Total_price'] ?? 0}",
//             "date": _formatDate(item['createdAt'] ?? item['CreatedAt']),
//             "sortDate":
//                 DateTime.tryParse(
//                   item['createdAt'] ?? item['CreatedAt'] ?? "",
//                 ) ??
//                 DateTime.now(),
//             "icon": Icons.local_parking,
//           });
//         }
//       }

//       final passRes = await http.get(Uri.parse("$_baseUrl/api/PassingOrders"));
//       if (passRes.statusCode == 200) {
//         for (var item in jsonDecode(passRes.body)) {
//           tempList.add({
//             "title": "Geçiş (Otoyol/Köprü)",
//             "description": item['name'] ?? item['Name'] ?? "Geçiş",
//             "amount": "₺ ${item['price'] ?? item['Price'] ?? 0}",
//             "date": _formatDate(item['createdAt'] ?? item['CreatedAt']),
//             "sortDate":
//                 DateTime.tryParse(
//                   item['createdAt'] ?? item['CreatedAt'] ?? "",
//                 ) ??
//                 DateTime.now(),
//             "icon": Icons.sensors,
//           });
//         }
//       }

//       final otherRes = await http.get(
//         Uri.parse("$_baseUrl/api/OtherCarOrders"),
//       );
//       if (otherRes.statusCode == 200) {
//         for (var item in jsonDecode(otherRes.body)) {
//           tempList.add({
//             "title": "Araç Bakım/Diğer",
//             "description": item['name'] ?? item['Name'] ?? "Ekstra Gider",
//             "amount": "₺ ${item['price'] ?? item['Price'] ?? 0}",
//             "date": _formatDate(item['createdAt'] ?? item['CreatedAt']),
//             "sortDate":
//                 DateTime.tryParse(
//                   item['createdAt'] ?? item['CreatedAt'] ?? "",
//                 ) ??
//                 DateTime.now(),
//             "icon": Icons.build_circle_outlined,
//           });
//         }
//       }

//       tempList.sort((a, b) => b["sortDate"].compareTo(a["sortDate"]));
//       setState(() {
//         expenses = tempList;
//       });
//     } catch (e) {
//       print("API Hatası: $e");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _submitCarToApi() async {
//     setState(() => _isSavingCar = true);

//     Map<String, dynamic> carPayload = {
//       "title": _titleController.text,
//       "brand": _brandController.text,
//       "model": _modelController.text,
//       "year": int.tryParse(_yearController.text) ?? 0,
//       "kilometer": int.tryParse(_kmController.text) ?? 0,
//       "tankSize": int.tryParse(_tankController.text) ?? 0,
//       "user_id": 1,
//     };

//     try {
//       http.Response response;

//       if (_hasCarData) {
//         // Zaten araç varsa Güncelleme Yap (PUT) - ID'sini 1 kabul ediyoruz
//         carPayload["id"] = 1;
//         response = await http.put(
//           Uri.parse("$_baseUrl/api/Cars/1"),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(carPayload),
//         );
//       } else {
//         // Araç yoksa Yeni Ekle (POST)
//         response = await http.post(
//           Uri.parse("$_baseUrl/api/Cars"),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(carPayload),
//         );
//       }

//       if (response.statusCode == 200 ||
//           response.statusCode == 201 ||
//           response.statusCode == 204) {
//         if (!mounted) return;
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text("Araç bilgileri başarıyla kaydedildi!"),
//             backgroundColor: Theme.of(context).colorScheme.primary,
//           ),
//         );
//         _fetchCarDataAndExpenses();
//       } else {
//         throw Exception("İşlem başarısız: ${response.statusCode}");
//       }
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Hata: $e"),
//           backgroundColor: Theme.of(context).colorScheme.error,
//         ),
//       );
//     } finally {
//       setState(() => _isSavingCar = false);
//     }
//   }

//   void _showPhotoSelection() {
//     final colors = Theme.of(context).colorScheme;
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Theme.of(context).cardColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: colors.onSurfaceVariant.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               ListTile(
//                 leading: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: colors.primary.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.camera_alt_outlined, color: colors.primary),
//                 ),
//                 title: Text(
//                   "Kamera ile Çek",
//                   style: TextStyle(
//                     color: colors.onSurface,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   final prefs = await SharedPreferences.getInstance();
//                   await prefs.setBool('hasCarPhoto', true);
//                   setState(() {
//                     _hasPhoto = true;
//                   });
//                 },
//               ),
//               const SizedBox(height: 8),
//               ListTile(
//                 leading: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: colors.secondary.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.photo_library_outlined,
//                     color: colors.secondary,
//                   ),
//                 ),
//                 title: Text(
//                   "Galeriden Seç",
//                   style: TextStyle(
//                     color: colors.onSurface,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   final prefs = await SharedPreferences.getInstance();
//                   await prefs.setBool('hasCarPhoto', true);
//                   setState(() {
//                     _hasPhoto = true;
//                   });
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showAddCarForm() {
//     final colors = Theme.of(context).colorScheme;

//     if (_hasCarData) {
//       _titleController.text = _carTitle;
//       _brandController.text = _carBrand;
//       _modelController.text = _carModel;
//       _yearController.text = _carYear;
//       _tankController.text = _carTank;
//       _kmController.text = _carKm;
//     }

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Theme.of(context).cardColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: 20,
//             right: 20,
//             top: 16,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: colors.onSurfaceVariant.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 "Araç Bilgilerini Gir",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: colors.onSurface,
//                 ),
//               ),
//               const SizedBox(height: 24),

//               _buildTextField(
//                 "Aracın Takma Adı",
//                 icon: Icons.favorite_border,
//                 controller: _titleController,
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildTextField(
//                       "Marka",
//                       icon: Icons.directions_car_outlined,
//                       controller: _brandController,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildTextField(
//                       "Model",
//                       icon: Icons.info_outline,
//                       controller: _modelController,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildTextField(
//                       "Yıl",
//                       icon: Icons.calendar_today,
//                       keyboardType: TextInputType.number,
//                       controller: _yearController,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildTextField(
//                       "Depo (Lt)",
//                       icon: Icons.local_gas_station_outlined,
//                       keyboardType: TextInputType.number,
//                       controller: _tankController,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Kilometre",
//                 icon: Icons.speed,
//                 keyboardType: TextInputType.number,
//                 controller: _kmController,
//               ),
//               const SizedBox(height: 32),

//               SizedBox(
//                 width: double.infinity,
//                 height: 54,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: colors.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   onPressed: _isSavingCar ? null : _submitCarToApi,
//                   child: _isSavingCar
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                           "KAYDET",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (!_hasPhoto)
//               InkWell(
//                 onTap: _showPhotoSelection,
//                 borderRadius: BorderRadius.circular(16),
//                 child: Container(
//                   width: double.infinity,
//                   height: 160,
//                   decoration: BoxDecoration(
//                     color: colors.primary.withOpacity(0.05),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: colors.primary.withOpacity(0.3),
//                       width: 2,
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.add_a_photo_outlined,
//                         size: 40,
//                         color: colors.primary,
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         "Araç Fotoğrafı Ekle",
//                         style: TextStyle(
//                           color: colors.primary,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             else
//               InkWell(
//                 onTap: _showPhotoSelection,
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Image.asset(
//                         'assets/25004_01.webp',
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         height: 180,
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 12,
//                       right: 12,
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.6),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//             const SizedBox(height: 16),

//             if (!_hasCarData)
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: colors.surface,
//                     foregroundColor: colors.onSurface,
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     side: BorderSide(
//                       color: colors.onSurfaceVariant.withOpacity(0.2),
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   icon: Icon(
//                     Icons.directions_car_outlined,
//                     color: colors.primary,
//                   ),
//                   label: const Text(
//                     "Araç Bilgilerini Gir",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                   ),
//                   onPressed: _showAddCarForm,
//                 ),
//               )
//             else
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _carTitle,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1.2,
//                           color: colors.onSurface,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "$_carBrand $_carModel - $_carYear",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: colors.onSurfaceVariant,
//                           letterSpacing: 1.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.edit_note, color: colors.primary),
//                     onPressed: _showAddCarForm,
//                   ),
//                 ],
//               ),

//             const SizedBox(height: 24),

//             Row(
//               children: [
//                 Expanded(
//                   child: SummaryCardComponent(
//                     title: "Kilometre",
//                     amount: _hasCarData ? _carKm : "-",
//                     icon: Icons.speed,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: SummaryCardComponent(
//                     title: "Kapasite",
//                     amount: _hasCarData ? "$_carTank Lt" : "-",
//                     icon: Icons.local_gas_station,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Expanded(
//                   child: SummaryCardComponent(
//                     title: "Tüketim",
//                     amount: "-",
//                     icon: Icons.trending_up,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),

//             Text(
//               "Tüketim & Harcama Geçmişi",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: colors.onSurface,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 16),

//             if (_isLoading)
//               const Center(child: CircularProgressIndicator())
//             else if (expenses.isEmpty)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 40,
//                   horizontal: 20,
//                 ),
//                 decoration: BoxDecoration(
//                   color: colors.surface,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: colors.onSurfaceVariant.withOpacity(0.15),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.receipt_long_outlined,
//                       size: 48,
//                       color: colors.onSurfaceVariant.withOpacity(0.5),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       "Bu araca ait henüz bir harcama eklemediniz.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: colors.onSurfaceVariant,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: expenses.length,
//                 itemBuilder: (context, index) {
//                   final expense = expenses[index];
//                   return _buildExpenseCard(
//                     context,
//                     title: expense["title"],
//                     description: expense["description"],
//                     amount: expense["amount"].toString(),
//                     date: expense["date"],
//                     icon: expense["icon"],
//                     extraInfo: expense["extraInfo"],
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     String label, {
//     IconData? icon,
//     TextInputType keyboardType = TextInputType.text,
//     required TextEditingController controller,
//   }) {
//     final colors = Theme.of(context).colorScheme;
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(color: colors.onSurface),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: colors.onSurfaceVariant, fontSize: 14),
//         prefixIcon: icon != null
//             ? Icon(icon, color: colors.primary, size: 20)
//             : null,
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
//         color: colors.surface,
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
//             color: colors.onSurface,
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
//               style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
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
//                 color: colors.onSurface,
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uibudget/components/SummaryCardComponent.dart';

class Cardetailsandpastpage extends StatefulWidget {
  const Cardetailsandpastpage({super.key});

  @override
  State<StatefulWidget> createState() => _CardetailandpastpageState();
}

class _CardetailandpastpageState extends State<Cardetailsandpastpage> {
  final String _baseUrl = "http://10.0.2.2:5268";

  bool _hasCarData = false;
  bool _hasPhoto = false;
  bool _isLoading = true;
  bool _isSavingCar = false;

  String _carTitle = "";
  String _carBrand = "";
  String _carModel = "";
  String _carYear = "";
  String _carTank = "";
  String _carKm = "";

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _tankController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();

  List<Map<String, dynamic>> expenses = [];

  @override
  void initState() {
    super.initState();
    _fetchCarDataAndExpenses();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _tankController.dispose();
    _kmController.dispose();
    super.dispose();
  }

  String _formatDate(String? isoString) {
    if (isoString == null) return "";
    try {
      DateTime date = DateTime.parse(isoString);
      List<String> months = [
        "",
        "Oca",
        "Şub",
        "Mar",
        "Nis",
        "May",
        "Haz",
        "Tem",
        "Ağu",
        "Eyl",
        "Eki",
        "Kas",
        "Ara",
      ];
      return "${date.day} ${months[date.month]}";
    } catch (e) {
      return "";
    }
  }

  Future<void> _fetchCarDataAndExpenses() async {
    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      _hasPhoto = prefs.getBool('hasCarPhoto') ?? false;
      final int currentUserId = prefs.getInt('userId') ?? 0;

      // 1. Araç bilgisini dinamik kullanıcı ID'sine göre çek
      final carRes = await http.get(
        Uri.parse("$_baseUrl/api/Cars/$currentUserId"),
      );
      if (carRes.statusCode == 200) {
        var cars = jsonDecode(carRes.body);
        if (cars is List && cars.isNotEmpty) {
          var car = cars[0];
          setState(() {
            _hasCarData = true;
            _carTitle = car['title'] ?? car['Title'] ?? "Aracım";
            _carBrand = car['brand'] ?? car['Brand'] ?? "";
            _carModel = car['model'] ?? car['Model'] ?? "";
            _carYear = (car['year'] ?? car['Year'] ?? "").toString();
            _carTank = (car['tankSize'] ?? car['TankSize'] ?? "").toString();
            _carKm = (car['kilometer'] ?? car['Kilometer'] ?? "").toString();
          });
        }
      }

      List<Map<String, dynamic>> tempList = [];

      final fuelRes = await http.get(
        Uri.parse("$_baseUrl/api/FuelOrders/GetAll/$currentUserId"),
      );
      if (fuelRes.statusCode == 200) {
        for (var item in jsonDecode(fuelRes.body)) {
          tempList.add({
            "title": "Yakıt Alımı",
            "description": "İstasyon: Petrol Ofisi",
            "amount": "₺ ${item['total_price'] ?? item['Total_price'] ?? 0}",
            "date": _formatDate(item['orderAt'] ?? item['OrderAt']),
            "sortDate":
                DateTime.tryParse(item['orderAt'] ?? item['OrderAt'] ?? "") ??
                DateTime.now(),
            "icon": Icons.local_gas_station,
            "extraInfo": "₺ ${item['unit_price'] ?? item['Unit_price']} / Lt",
          });
        }
      }

      final parkRes = await http.get(
        Uri.parse("$_baseUrl/api/ParkingOrders/$currentUserId"),
      );
      if (parkRes.statusCode == 200) {
        for (var item in jsonDecode(parkRes.body)) {
          tempList.add({
            "title": "Otopark",
            "description":
                item['parking_name'] ?? item['Parking_name'] ?? "Otopark",
            "amount": "₺ ${item['total_price'] ?? item['Total_price'] ?? 0}",
            "date": _formatDate(item['createdAt'] ?? item['CreatedAt']),
            "sortDate":
                DateTime.tryParse(
                  item['createdAt'] ?? item['CreatedAt'] ?? "",
                ) ??
                DateTime.now(),
            "icon": Icons.local_parking,
          });
        }
      }

      final passRes = await http.get(
        Uri.parse("$_baseUrl/api/PassingOrders/$currentUserId"),
      );
      if (passRes.statusCode == 200) {
        for (var item in jsonDecode(passRes.body)) {
          tempList.add({
            "title": "Geçiş (Otoyol/Köprü)",
            "description": item['name'] ?? item['Name'] ?? "Geçiş",
            "amount": "₺ ${item['price'] ?? item['Price'] ?? 0}",
            "date": _formatDate(item['createdAt'] ?? item['CreatedAt']),
            "sortDate":
                DateTime.tryParse(
                  item['createdAt'] ?? item['CreatedAt'] ?? "",
                ) ??
                DateTime.now(),
            "icon": Icons.sensors,
          });
        }
      }

      final otherRes = await http.get(
        Uri.parse("$_baseUrl/api/OtherCarOrders/$currentUserId"),
      );
      if (otherRes.statusCode == 200) {
        for (var item in jsonDecode(otherRes.body)) {
          tempList.add({
            "title": "Araç Bakım/Diğer",
            "description": item['name'] ?? item['Name'] ?? "Ekstra Gider",
            "amount": "₺ ${item['price'] ?? item['Price'] ?? 0}",
            "date": _formatDate(item['createdAt'] ?? item['CreatedAt']),
            "sortDate":
                DateTime.tryParse(
                  item['createdAt'] ?? item['CreatedAt'] ?? "",
                ) ??
                DateTime.now(),
            "icon": Icons.build_circle_outlined,
          });
        }
      }

      tempList.sort((a, b) => b["sortDate"].compareTo(a["sortDate"]));
      setState(() {
        expenses = tempList;
      });
    } catch (e) {
      print("API Hatası: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _submitCarToApi() async {
    setState(() => _isSavingCar = true);

    final prefs = await SharedPreferences.getInstance();
    final int currentUserId = prefs.getInt('userId') ?? 0;

    Map<String, dynamic> carPayload = {
      "title": _titleController.text,
      "brand": _brandController.text,
      "model": _modelController.text,
      "year": int.tryParse(_yearController.text) ?? 0,
      "kilometer": int.tryParse(_kmController.text) ?? 0,
      "tankSize": int.tryParse(_tankController.text) ?? 0,
      "user_id": currentUserId,
    };

    try {
      http.Response response;

      if (_hasCarData) {
        carPayload["id"] = 1;
        response = await http.put(
          Uri.parse("$_baseUrl/api/Cars/1"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(carPayload),
        );
      } else {
        response = await http.post(
          Uri.parse("$_baseUrl/api/Cars"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(carPayload),
        );
      }

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Araç bilgileri başarıyla kaydedildi!"),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        _fetchCarDataAndExpenses();
      } else {
        throw Exception("İşlem başarısız: ${response.statusCode}");
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hata: $e"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() => _isSavingCar = false);
    }
  }

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
                onTap: () async {
                  Navigator.pop(context);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('hasCarPhoto', true);
                  setState(() {
                    _hasPhoto = true;
                  });
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
                onTap: () async {
                  Navigator.pop(context);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('hasCarPhoto', true);
                  setState(() {
                    _hasPhoto = true;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddCarForm() {
    final colors = Theme.of(context).colorScheme;

    if (_hasCarData) {
      _titleController.text = _carTitle;
      _brandController.text = _carBrand;
      _modelController.text = _carModel;
      _yearController.text = _carYear;
      _tankController.text = _carTank;
      _kmController.text = _carKm;
    }

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
                "Aracın Takma Adı",
                icon: Icons.favorite_border,
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Marka",
                      icon: Icons.directions_car_outlined,
                      controller: _brandController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Model",
                      icon: Icons.info_outline,
                      controller: _modelController,
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
                      controller: _yearController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Depo (Lt)",
                      icon: Icons.local_gas_station_outlined,
                      keyboardType: TextInputType.number,
                      controller: _tankController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Kilometre",
                icon: Icons.speed,
                keyboardType: TextInputType.number,
                controller: _kmController,
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
                  onPressed: _isSavingCar ? null : _submitCarToApi,
                  child: _isSavingCar
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
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
            if (!_hasPhoto)
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
                    ),
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
              )
            else
              InkWell(
                onTap: _showPhotoSelection,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/25004_01.webp',
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

            const SizedBox(height: 16),

            if (!_hasCarData)
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
              )
            else
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
                    onPressed: _showAddCarForm,
                  ),
                ],
              ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: SummaryCardComponent(
                    title: "Kilometre",
                    amount: _hasCarData ? _carKm : "-",
                    icon: Icons.speed,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SummaryCardComponent(
                    title: "Kapasite",
                    amount: _hasCarData ? "$_carTank Lt" : "-",
                    icon: Icons.local_gas_station,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: SummaryCardComponent(
                    title: "Tüketim",
                    amount: "-",
                    icon: Icons.trending_up,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

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

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (expenses.isEmpty)
              Container(
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
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return _buildExpenseCard(
                    context,
                    title: expense["title"],
                    description: expense["description"],
                    amount: expense["amount"].toString(),
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

  Widget _buildTextField(
    String label, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
  }) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
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
