import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:produk/models/api.dart';
import 'package:produk/widgets/form.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Create extends StatefulWidget {
  @override
  CreateState createState() => CreateState();
}

class CreateState extends State<Create> {
  final formkey = GlobalKey<FormState>();

  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController gambarController = TextEditingController();

  final Color colorCyan = const Color(0xFF00c4cc);
  final Color colorPurple = const Color(0xFF7a2ae9);

  Future createSw() async {
    return await http.post(
      Uri.parse(BaseUrl.tambah),
      body: {
        "kode": kodeController.text,
        "nama": namaController.text,
        "harga": hargaController.text,
        "gambar": gambarController.text,
      },
    );
  }

  void pesan() {
    Fluttertoast.showToast(
        msg: "Produk Baru Berhasil Ditambah",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: colorPurple,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onConfirm(context) async {
    try {
      http.Response response = await createSw();
      if (response.body.startsWith('{')) {
        final data = json.decode(response.body);
        if (data['success'] == true || data['success'] == 1) {
          pesan();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route route) => false);
        }
      }
    } catch (e) {
      print("Error Create: $e");
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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "ADD NEW ITEM",
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
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorCyan.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add_business_rounded, size: 40, color: colorCyan),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Informasi Produk",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: AppForm(
                formkey: formkey,
                kodeController: kodeController,
                namaController: namaController,
                hargaController: hargaController,
                gambarController: gambarController,
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [colorCyan, colorPurple],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: colorPurple.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text(
              "SAVE TO CATALOG",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              if (formkey.currentState!.validate()) {
                _onConfirm(context);
              }
            },
          ),
        ),
      ),
    );
  }
}