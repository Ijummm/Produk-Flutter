<?php
header('Content-Type: application/json');
include "konekdb.php";
$kode= $_POST['kode'];
$nama = $_POST['nama'];
$harga = $_POST['harga'];
$gambar = $_POST['gambar'];
$stmt = $konekdb->prepare("INSERT INTO produk (kode, nama, harga, gambar)
                                VALUES (?, ?, ?, ?)");
$result = $stmt->execute([$kode, $nama, $harga, $gambar]);
echo json_encode([
"success" => $result ]);
?>