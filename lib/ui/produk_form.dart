import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Produk Daniel";
  String tombolSubmit = "Simpan";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "Ubah Produk Daniel";
        tombolSubmit = "Ubah";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding di sekitar form
          child: Card(
            elevation: 5, // Efek shadow untuk card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Sudut melengkung
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Padding dalam card
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kodeProdukTextField(),
                    const SizedBox(height: 16), // Jarak antar field
                    _namaProdukTextField(),
                    const SizedBox(height: 16), // Jarak antar field
                    _hargaProdukTextField(),
                    const SizedBox(height: 20), // Jarak antara input dan tombol
                    _buttonSubmit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Kode Produk
  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Kode Produk",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama Produk",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harga",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        if (double.tryParse(value) == null) {
          return "Harga harus berupa angka yang valid";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator()) // Tampilkan loading indicator
        : SizedBox(
            width: double.infinity, // Tombol full-width
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                tombolSubmit,
                style: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true; // Set loading state
                  });

                  // Simulate a network request
                  Future.delayed(const Duration(seconds: 2), () {
                    // Add or update product logic here
                    setState(() {
                      _isLoading = false;
                    });
                    // Optionally clear the input fields or navigate back
                    // Navigator.pop(context); // Uncomment to navigate back
                  });
                }
              },
            ),
          );
  }
}
