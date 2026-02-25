import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:produk/models/mproduk.dart';
import 'package:produk/models/api.dart';
import 'package:produk/widgets/form.dart';

class Edit extends StatefulWidget {
  final ProdukModel sw;

  Edit({required this.sw});

  @override
  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  final formkey = GlobalKey<FormState>();

  final Color colorCyan = const Color(0xFF00c4cc);
  final Color colorPurple = const Color(0xFF7a2ae9);

  late TextEditingController kodeController,
      namaController,
      hargaController,
      gambarController;

  @override
  void initState() {
    kodeController = TextEditingController(text: widget.sw.kode);
    namaController = TextEditingController(text: widget.sw.nama);
    hargaController = TextEditingController(text: widget.sw.harga);
    gambarController = TextEditingController(text: widget.sw.gambar);
    super.initState();
  }

  Future editSw() async {
    return await http.post(
      Uri.parse(BaseUrl.edit),
      body: {
        "id": widget.sw.id.toString(),
        "kode": kodeController.text,
        "nama": namaController.text,
        "harga": hargaController.text,
        "gambar": gambarController.text,
      },
    );
  }

  void pesan() {
    Fluttertoast.showToast(
        msg: "Perubahan eksklusif berhasil disimpan",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: colorCyan,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onConfirm(context) async {
    try {
      http.Response response = await editSw();
      if (response.body.contains("{")) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          pesan();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route route) => false);
        }
      }
    } catch (e) {
      print("Error saat Update: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "EDIT ITEM",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: colorPurple.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: widget.sw.gambar.isNotEmpty
                    ? Image.network(widget.sw.gambar, fit: BoxFit.cover)
                    : Container(color: Colors.grey[200], child: const Icon(Icons.image)),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                children: [
                   Text(
                    "ID Produk: ${widget.sw.id}",
                    style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  AppForm(
                    formkey: formkey,
                    kodeController: kodeController,
                    namaController: namaController,
                    hargaController: hargaController,
                    gambarController: gambarController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 40),
        color: const Color(0xFFF8F9FD),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: [colorPurple, colorCyan],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: colorCyan.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            ),
            child: const Text(
              "CONFIRM CHANGES",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
            onPressed: () => _onConfirm(context),
          ),
        ),
      ),
    );
  }
}