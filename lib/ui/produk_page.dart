import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  // Placeholder for the product list
  final List<Produk> produkList = [
    Produk(
      id: 1,
      kodeProduk: 'A001',
      namaProduk: 'Kamera',
      hargaProduk: 5000000,
    ),
    Produk(
      id: 2,
      kodeProduk: 'A002',
      namaProduk: 'Kulkas',
      hargaProduk: 2500000,
    ),
    Produk(
      id: 3,
      kodeProduk: 'A003',
      namaProduk: 'Mesin Cuci',
      hargaProduk: 2000000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk Daniel'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                // Navigate to the form to add a new product
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdukForm()),
                );
                setState(() {
                  // Refresh the list of products if needed
                });
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout Daniel'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                // Implement logout logic here
                // e.g., clear session, navigate to login screen
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: produkList.length,
        itemBuilder: (context, index) {
          return ItemProduk(produk: produkList[index]);
        },
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Card(
        elevation: 5, // Tambahkan efek shadow
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Card dengan sudut melengkung
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Gambar Produk Placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300], // Warna background untuk placeholder
                ),
                child: const Icon(
                  Icons.image, // Icon gambar sebagai placeholder
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16), // Spasi antara gambar dan deskripsi
              // Detail Produk
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produk.namaProduk ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8), // Spasi antara nama dan harga
                    Text(
                      'Rp. ${produk.hargaProduk.toString()}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
