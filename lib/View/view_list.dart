import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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
            return const WideLayout();
          } else {
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
      child: FutureBuilder<List<Person>>(
        future: ApiService.fetchPeople(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }
          return PeopleList(
            people: snapshot.data!,
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
          );
        },
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
    return FutureBuilder<List<Person>>(
      future: ApiService.fetchPeople(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data available"));
        }
        final people = snapshot.data!;
        return Row(
          children: [
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: PeopleList(
                  people: people,
                  onPersonTap: (person) {
                    setState(() {
                      _selectedPerson = person;
                    });
                  },
                ),
              ),
            ),
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
      },
    );
  }
}

class PeopleList extends StatelessWidget {
  final List<Person> people;
  final void Function(Person) onPersonTap;

  const PeopleList({super.key, required this.people, required this.onPersonTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: people.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final person = people[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12.0),
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("data:image/png;base64,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"),
            ),
            title: Text(
              person.nama,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 2)
                  .format(person.harga),
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => onPersonTap(person),
          ),
        );
      },
    );
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;

  const PersonDetail(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedPrice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 2,
    ).format(person.harga);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage("data:image/png;base64,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"),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    person.nama,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Rating Bintang
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber[600], size: 20),
                      Icon(Icons.star, color: Colors.amber[600], size: 20),
                      Icon(Icons.star, color: Colors.amber[600], size: 20),
                      Icon(Icons.star, color: Colors.amber[600], size: 20),
                      Icon(Icons.star_half, color: Colors.amber[600], size: 20),
                      const SizedBox(width: 5),
                      const Text(
                        "4.5", // Dummy rating
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Fitness and Nutrition Trainer • 15+ years of experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _StatCard(label: "Clients", value: "110"),
                      _StatCard(label: "Sessions", value: "568"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Specializes in:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _SpecializationChip(label: "Fitness Training"),
                _SpecializationChip(label: "Muscle Building"),
                _SpecializationChip(label: "Cardio"),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Provides:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _ServiceRow(
              service: "Personal Training",
              price: "starts @ $formattedPrice per session",
            ),
            _ServiceRow(
              service: "Online Training",
              price: "starts @ $formattedPrice per session",
            ),
            _ServiceRow(
              service: "Small Group Training",
              price: "starts @ $formattedPrice per session",
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Book Session",
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
  final String label;
  final String value;

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
  final String service;
  final String price;

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

class ApiService {
  static Future<List<Person>> fetchPeople() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/pt'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        return jsonResponse.map((item) => Person.fromJson(item)).toList();
      } else if (jsonResponse is Map<String, dynamic>) {
        if (jsonResponse['data'] != null && jsonResponse['data'] is List) {
          return (jsonResponse['data'] as List)
              .map((item) => Person.fromJson(item))
              .toList();
        } else {
          throw Exception('Invalid data structure: "data" key not found');
        }
      } else {
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Failed to load trainers');
    }
  }
}

class Person {
  final String nama;
  final double harga;

  Person({required this.nama, required this.harga});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      nama: json['nama'] ?? 'Tanpa Nama',
      harga: (json['harga'] as num).toDouble(),
    );
  }
}
