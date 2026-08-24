import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddExpensePage extends StatefulWidget {
  final String initialCategory;
  const AddExpensePage({super.key, required this.initialCategory});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  // TODO: Kendi .NET API adresini buraya yaz
  final String _baseUrl =
      "http://10.0.2.2:5268"; // Emülatör için varsayılan localhost

  late String _selectedCategory;
  bool _isLoading = false;

  final List<String> _categories = [
    "Yakıt",
    "Otopark",
    "Geçiş",
    "Araç Bakım/Diğer",
    "Yemek",
  ];
  final List<String> _gasStations = ["Petrol_Ofisi", "Shell", "Opet", "Total"];
  final List<String> _paymentTypes = ["Credit_Card", "Cash"];

  String _selectedStation = "Petrol_Ofisi";
  String _selectedPayment = "Credit_Card";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _fuelUnitPriceCtrl = TextEditingController();
  final TextEditingController _fuelTotalPriceCtrl = TextEditingController();
  final TextEditingController _fuelLiterCtrl = TextEditingController();
  final TextEditingController _parkingHourPriceCtrl = TextEditingController();
  final TextEditingController _parkingHourCtrl = TextEditingController();
  final TextEditingController _parkingFreeHourCtrl = TextEditingController();
  final TextEditingController _parkingTotalPriceCtrl = TextEditingController();
  final TextEditingController _restaurantCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories.contains(widget.initialCategory)
        ? widget.initialCategory
        : "Yakıt";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _fuelUnitPriceCtrl.dispose();
    _fuelTotalPriceCtrl.dispose();
    _fuelLiterCtrl.dispose();
    _parkingHourPriceCtrl.dispose();
    _parkingHourCtrl.dispose();
    _parkingFreeHourCtrl.dispose();
    _parkingTotalPriceCtrl.dispose();
    _restaurantCtrl.dispose();
    super.dispose();
  }

  // --- API GÖNDERİM İŞLEMİ ---
  Future<void> _submitDataToApi() async {
    setState(() => _isLoading = true);

    String apiUrl = "";
    Map<String, dynamic> payload = {};

    // 1. YAKIT (FuelOrder)
    if (_selectedCategory == "Yakıt") {
      apiUrl = "/api/FuelOrders";
      payload = {
        "user_id": 1,
        "car_id": 1,
        "unit_price": double.tryParse(_fuelUnitPriceCtrl.text) ?? 0.0,
        "total_price": double.tryParse(_fuelTotalPriceCtrl.text) ?? 0.0,
        "fuel_liter": double.tryParse(_fuelLiterCtrl.text) ?? 0.0,
        "station": _gasStations.indexOf(
          _selectedStation,
        ), // Enum index (0, 1, 2, 3)
      };
    }
    // 2. OTOPARK (ParkingOrder)
    else if (_selectedCategory == "Otopark") {
      apiUrl = "/api/ParkingOrders";
      payload = {
        "user_id": 1,
        "car_id": 1,
        "parking_name": _nameController.text,
        "total_price": double.tryParse(_parkingTotalPriceCtrl.text) ?? 0.0,
        "hour_price": double.tryParse(_parkingHourPriceCtrl.text) ?? 0.0,
        "hour": double.tryParse(_parkingHourCtrl.text) ?? 0.0,
        "free_hour": double.tryParse(_parkingFreeHourCtrl.text) ?? 0.0,
        "payment_type": _paymentTypes.indexOf(
          _selectedPayment,
        ), // Enum index (0, 1)
      };
    }
    // 3. GEÇİŞ (PassingOrder)
    else if (_selectedCategory == "Geçiş") {
      apiUrl = "/api/PassingOrders";
      payload = {
        "user_id": 1,
        "car_id": 1,
        "name": _nameController.text,
        "price": double.tryParse(_priceController.text) ?? 0.0,
        "payment_type": _paymentTypes.indexOf(_selectedPayment),
      };
    }
    // 4. ARAÇ BAKIM / DİĞER (OtherCarOrder)
    else if (_selectedCategory == "Araç Bakım/Diğer") {
      apiUrl = "/api/OtherCarOrders";
      payload = {
        "user_id": 1,
        "car_id": 1,
        "name": _nameController.text,
        "price": double.tryParse(_priceController.text) ?? 0.0,
      };
    }
    // 5. YEMEK (FoodOrder - Bu araca ait olmadığı için car_id yok)
    else if (_selectedCategory == "Yemek") {
      apiUrl = "/api/FoodOrders";
      payload = {
        "user_id": 1,
        "food_name": _nameController.text,
        "price": double.tryParse(_priceController.text) ?? 0.0,
        "restaurant": _restaurantCtrl.text,
      };
    }

    // HTTP İsteği
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl$apiUrl"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      // Başarılı ise sayfayı kapat ve mesaj göster
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        Navigator.pop(context); // Sayfayı kapat
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Harcama başarıyla eklendi!"),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      } else {
        throw Exception("Sunucu hatası: ${response.statusCode}");
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hata oluştu: $e"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width - 40,
              ),
              onSelected: (String newValue) {
                _nameController.clear();
                _priceController.clear();
                _fuelTotalPriceCtrl.clear();
                _parkingTotalPriceCtrl.clear();
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
                      "Litre (Lt)",
                      icon: Icons.water_drop_outlined,
                      keyboardType: TextInputType.number,
                      controller: _fuelLiterCtrl,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Birim Fiyat (₺)",
                      icon: Icons.price_change_outlined,
                      keyboardType: TextInputType.number,
                      controller: _fuelUnitPriceCtrl,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Toplam Tutar (₺)",
                icon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
                controller: _fuelTotalPriceCtrl,
              ),
            ],

            if (_selectedCategory == "Otopark") ...[
              _buildTextField(
                "Otopark Adı",
                icon: Icons.local_parking,
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Süre (Saat)",
                      icon: Icons.schedule,
                      keyboardType: TextInputType.number,
                      controller: _parkingHourCtrl,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Ücretsiz Süre",
                      icon: Icons.timer_off_outlined,
                      keyboardType: TextInputType.number,
                      controller: _parkingFreeHourCtrl,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Saatlik Ücret (₺)",
                      icon: Icons.price_change_outlined,
                      keyboardType: TextInputType.number,
                      controller: _parkingHourPriceCtrl,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      "Toplam Tutar",
                      icon: Icons.account_balance_wallet_outlined,
                      keyboardType: TextInputType.number,
                      controller: _parkingTotalPriceCtrl,
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
                "Yemek Adı",
                icon: Icons.fastfood_outlined,
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Restoran / Mekan",
                icon: Icons.storefront_outlined,
                controller: _restaurantCtrl,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Tutar (₺)",
                icon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
                controller: _priceController,
              ),
            ],

            if (_selectedCategory == "Geçiş") ...[
              _buildTextField(
                "Gişe / Geçiş Adı (HGS vb.)",
                icon: Icons.sensors,
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Geçiş Ücreti (₺)",
                icon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
                controller: _priceController,
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
                "Harcama Adı (Örn: Silecek)",
                icon: Icons.build_circle_outlined,
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Tutar (₺)",
                icon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
                controller: _priceController,
              ),
            ],

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                onPressed: _isLoading ? null : _submitDataToApi,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "KAYDET",
                        style: TextStyle(
                          color: Colors.white,
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
    required TextEditingController controller,
  }) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
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
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 40,
          ),
          onSelected: onChanged,
          itemBuilder: (context) => items
              .map(
                (String item) => PopupMenuItem<String>(
                  value: item,
                  child: Text(
                    item.replaceAll("_", " "),
                    style: TextStyle(color: colors.onSurface, fontSize: 15),
                  ),
                ),
              )
              .toList(),
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
