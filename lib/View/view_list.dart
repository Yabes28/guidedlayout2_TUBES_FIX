import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(person.picture),
            ),
            title: Text(
              person.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
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
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(person.picture),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    person.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
            Text("Personal Training: ${person.price}"),
          ],
        ),
      ),
    );
  }
}

class ApiService {
  static Future<List<Person>> fetchPeople() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/pt'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trainers');
    }
  }
}

class Person {
  final String name;
  final String picture;
  final String price;

  Person({required this.name, required this.picture, required this.price});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      picture: json['picture'],
      price: json['price'],
    );
  }
}
