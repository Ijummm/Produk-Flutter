class ProdukModel {
  final String id;
  final String kode;
  final String nama;
  final String harga;
  final String gambar;

  ProdukModel({
    required this.id,
    required this.kode,
    required this.nama,
    required this.harga,
    required this.gambar,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      id: json['id'].toString(),
      kode: json['kode'].toString(),
      nama: json['nama'].toString(),
      harga: json['harga'].toString(),
      gambar: json['gambar'] ?? '',
    );
  }
}