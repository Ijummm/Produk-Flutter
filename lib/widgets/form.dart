import 'package:flutter/material.dart';
import 'dart:convert'; // Sudah ditambahkan

class AppForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController kodeController,
      namaController,
      hargaController,
      gambarController;

  AppForm({
    required this.formkey,
    required this.kodeController,
    required this.namaController,
    required this.hargaController,
    required this.gambarController,
  });

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  final Color colorCyan = const Color(0xFF00c4cc);
  final Color colorPurple = const Color(0xFF7a2ae9);

  Widget tampilkanGambar(String sumber) {
    if (sumber.isEmpty) {
      return Container(
        color: Colors.grey[100],
        child: Icon(Icons.image_search, color: Colors.grey[400], size: 40),
      );
    }

    try {
      if (sumber.startsWith('data:image') || (sumber.length > 100 && !sumber.startsWith('http'))) {
        String cleanBase64 = sumber.contains(',') ? sumber.split(',').last : sumber;
        
        cleanBase64 = cleanBase64.replaceAll(RegExp(r'\s+'), ''); 

        return Image.memory(
          base64Decode(cleanBase64),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => errorIcon("Format Base64 Salah"),
        );
      } 
      
      else {
        return Image.network(
          sumber,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => errorIcon("CORS Blocked / Link Mati"),
        );
      }
    } catch (e) {
      return errorIcon("Invalid Data");
    }
  }

  Widget errorIcon(String pesan) {
    return Container(
      color: Colors.red[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.broken_image, color: Colors.redAccent, size: 30),
          const SizedBox(height: 4),
          Text(pesan, style: const TextStyle(fontSize: 10, color: Colors.redAccent), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text(
            "LIVE PREVIEW",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ValueListenableBuilder(
                valueListenable: widget.gambarController,
                builder: (context, TextEditingValue value, __) {
                  return tampilkanGambar(value.text);
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          txtKode(),
          const SizedBox(height: 20),
          txtNama(),
          const SizedBox(height: 20),
          txtHarga(),
          const SizedBox(height: 20),
          txtGambar(),
        ],
      ),
    );
  }
  InputDecoration customInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      prefixIcon: Icon(icon, color: colorPurple, size: 20),
      filled: true,
      fillColor: Colors.grey[50],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: colorCyan, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  Widget txtKode() {
    return TextFormField(
      controller: widget.kodeController,
      style: const TextStyle(fontSize: 14),
      decoration: customInputDecoration("PRODUCT CODE", Icons.qr_code_rounded),
      validator: (value) => value!.isEmpty ? 'Kode wajib diisi' : null,
    );
  }

  Widget txtNama() {
    return TextFormField(
      controller: widget.namaController,
      style: const TextStyle(fontSize: 14),
      decoration: customInputDecoration("PRODUCT NAME", Icons.shopping_bag_outlined),
      validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
    );
  }

  Widget txtHarga() {
    return TextFormField(
      controller: widget.hargaController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      decoration: customInputDecoration("PRICE (IDR)", Icons.payments_outlined),
      validator: (value) => value!.isEmpty ? 'Harga wajib diisi' : null,
    );
  }

  Widget txtGambar() {
    return TextFormField(
      controller: widget.gambarController,
      style: const TextStyle(fontSize: 12),
      decoration: customInputDecoration("IMAGE URL / BASE64", Icons.link_rounded),
      validator: (value) => value!.isEmpty ? 'Foto wajib diisi' : null,
    );
  }
}