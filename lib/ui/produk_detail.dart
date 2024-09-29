import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Daniel'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5, // Efek bayangan agar card lebih menonjol
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15), // Membuat sudut melengkung
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem("Kode Produk", widget.produk!.kodeProduk!),
                  const SizedBox(height: 8.0), // Spasi antara item
                  _buildDetailItem("Nama Produk", widget.produk!.namaProduk!),
                  const SizedBox(height: 8.0), // Spasi antara item
                  _buildDetailItem(
                      "Harga Produk", 'Rp. ${widget.produk!.hargaProduk}'),
                  const SizedBox(
                      height: 20.0), // Spasi antara detail dan tombol
                  _tombolHapusEdit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Membuat widget untuk menampilkan detail produk dalam card
  Widget _buildDetailItem(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  // Membuat tombol Edit dan Hapus
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("Edit"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(produk: widget.produk!),
              ),
            ).then((value) {
              if (value == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Produk berhasil diperbarui!')),
                );
              }
            });
          },
        ),
        const SizedBox(width: 8.0), // Jarak antar tombol
        // Tombol Hapus
        OutlinedButton(
          child: const Text("Delete"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  // Dialog konfirmasi untuk menghapus produk
  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Konfirmasi"),
      content: const Text("Yakin ingin menghapus produk ini?"),
      actions: [
        // Tombol hapus
        TextButton(
          child: const Text("Ya"),
          onPressed: () {
            // Logika penghapusan produk
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Produk berhasil dihapus!')),
            );
            Navigator.pop(context); // Menutup dialog
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        // Tombol batal
        TextButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
