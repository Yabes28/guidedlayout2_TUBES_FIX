import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/data/people.dart';

class ListNamaView extends StatelessWidget {
  const ListNamaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Trainer"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Layout untuk layar lebar
            return const WideLayout();
          } else {
            // Layout untuk layar sempit
            return const NarrowLayout();
          }
        },
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: PeopleList(
        onPersonTap: (person) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text("Trainer Details"),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body: PersonDetail(person),
            ),
          ),
        ),
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Person? _selectedPerson;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Daftar Trainer
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: PeopleList(
              onPersonTap: (person) {
                setState(() {
                  _selectedPerson = person;
                });
              },
            ),
          ),
        ),
        // Detail Trainer
        Expanded(
          flex: 3,
          child: _selectedPerson == null
              ? const Center(
                  child: Text(
                    "Select a Trainer",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                )
              : PersonDetail(_selectedPerson!),
        ),
      ],
    );
  }
}

class PeopleList extends StatelessWidget {
  // Callback function yang akan dipanggil ketika pengguna memilih seorang pelatih
  final void Function(Person) onPersonTap;

  // Konstruktor untuk menerima callback function
  const PeopleList({super.key, required this.onPersonTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // Jumlah item dalam daftar sesuai jumlah orang dalam 'people'
      itemCount: people.length,
      // Separator (jarak antar item) berupa SizedBox
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      // Builder untuk setiap item dalam daftar
      itemBuilder: (context, index) {
        final person = people[index]; // Mendapatkan data pelatih berdasarkan index
        return Card(
          // Membuat elemen ListTile menjadi berbentuk kotak dengan sudut melengkung
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2, // Memberikan bayangan pada Card
          child: ListTile(
            contentPadding: const EdgeInsets.all(12.0), // Jarak dalam konten
            leading: CircleAvatar(
              radius: 30, // Ukuran avatar
              backgroundImage: NetworkImage(person.picture), // Gambar profil
            ),
            title: Text(
              person.name, // Nama pelatih
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16), // Icon di sebelah kanan
            onTap: () => onPersonTap(person), // Memanggil fungsi callback saat item ditekan
          ),
        );
      },
    );
  }
}

class PersonDetail extends StatelessWidget {
  // Objek pelatih yang akan ditampilkan detailnya
  final Person person;

  // Konstruktor menerima objek pelatih
  const PersonDetail(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang layar putih
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Padding konten
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Menyusun konten ke kiri
          children: [
            // Bagian profil dan statistik
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50, // Ukuran avatar
                    backgroundImage: NetworkImage(person.picture), // Gambar profil
                  ),
                  const SizedBox(height: 16), // Spasi antara avatar dan nama
                  Text(
                    person.name, // Nama pelatih
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8), // Spasi
                  const Text(
                    "Fitness and Nutrition Trainer • 15+ years of experience", // Deskripsi pelatih
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20), // Spasi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Rata tengah
                    children: const [
                      _StatCard(label: "Clients", value: "110"), // Kartu statistik
                      _StatCard(label: "Sessions", value: "568"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), // Spasi antar bagian

            // Bagian keahlian
            const Text(
              "Specializes in:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12), // Spasi
            Wrap(
              spacing: 10, // Jarak horizontal antar item
              runSpacing: 10, // Jarak vertikal antar item
              children: const [
                _SpecializationChip(label: "Fitness Training"), // Chip keahlian
                _SpecializationChip(label: "Muscle Building"),
                _SpecializationChip(label: "Cardio"),
              ],
            ),
            const SizedBox(height: 30),

            // Bagian layanan yang ditawarkan
            const Text(
              "Provides:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const _ServiceRow(
              service: "Personal Training",
              price: "starts @ Rp. 200.000/- per session",
            ),
            const _ServiceRow(
              service: "Online Training",
              price: "starts @ Rp. 200.000/- per session",
            ),
            const _ServiceRow(
              service: "Small Group Training",
              price: "starts @ Rp. 200.000/- per session",
            ),
            const SizedBox(height: 30),

            // Tombol booking sesi
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Tambahkan fungsi booking
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna tombol
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Sudut melengkung tombol
                  ),
                ),
                child: const Text(
                  "Book Session", // Teks tombol
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _StatCard extends StatelessWidget {
  final String label; // Label (misalnya: "Clients")
  final String value; // Nilai (misalnya: "110")

  const _StatCard({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _SpecializationChip extends StatelessWidget {
  final String label;

  const _SpecializationChip({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final String service; // Nama layanan
  final String price; // Harga layanan

  const _ServiceRow({required this.service, required this.price, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              service,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
