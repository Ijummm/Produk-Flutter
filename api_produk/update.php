<?php
header('Content-Type: application/json');
Include "konekdb.php";

$id = $_POST['id'];
$kode = $_POST['kode'];
$nama = $_POST['nama'];
$harga = $_POST['harga'];
$gambar = $_POST['gambar'];

$stmt = $konekdb->prepare("UPDATE produk SET kode=?, nama=?, harga=?, gambar=? WHERE id=?");
$result = $stmt->execute([$kode, $nama, $harga, $gambar, $id]);
echo json_encode([
"success" => $result
]);
?>