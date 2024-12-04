import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/viewPdf.dart';
import 'package:guidedlayout2_1748/Home/isiAbs/isiAbs1.dart';

class AbsPage extends StatelessWidget {
  const AbsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Abs Workout',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  AbsWorkoutCard(
                    title: 'Cable Crunch',
                    imageAsset: 'assets/abs1.jpg',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => isiAbs1(
                            title: 'Cable Crunch',
                            imageAsset: 'assets/abs1.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                  AbsWorkoutCard(
                    title: 'Hanging Leg Raise',
                    imageAsset: 'assets/abs2.jpg',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => isiAbs1(
                            title: 'Hanging Leg Raise',
                            imageAsset: 'assets/abs2.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                  AbsWorkoutCard(
                    title: 'Bicycle Crunch',
                    imageAsset: 'assets/abs3.jpg',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => isiAbs1(
                            title: 'Bicycle Crunch',
                            imageAsset: 'assets/abs3.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildConfirmationDialog(
                      context,
                      text: 'Apakah anda yakin ingin bergabung dengan kelas ini?',
                      onConfirmPressed: () {
                        Navigator.of(context).pop(); // Tutup pop-up pertama
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _buildConfirmationDialog(
                              context,
                              text: 'Apakah anda ingin menambah untuk personal trainer?',
                              onConfirmPressed: () {
                                Navigator.of(context).pop(); // Tutup pop-up kedua
                              },
                              onCancelPressed: () {
                                Navigator.of(context).pop(); // Tutup pop-up kedua
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ViewPdf(
                                      className: 'Abs Workout',
                                      price: 150000,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      onCancelPressed: () {
                        Navigator.of(context).pop(); // Tutup pop-up pertama
                      },
                    );
                  },
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Join Class'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF92A3FD),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Navigasikan berdasarkan index
        },
      ),
    );
  }

  Widget _buildConfirmationDialog(
    BuildContext context, {
    required String text,
    required VoidCallback onConfirmPressed,
    required VoidCallback onCancelPressed,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.help_outline, size: 50, color: Colors.black),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirmPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF92A3FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Ya'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: onCancelPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Batal'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AbsWorkoutCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onPressed;

  const AbsWorkoutCard({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
              child: Image.asset(
                imageAsset,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 16,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 6.0,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('View More'),
            ),
          ),
        ],
      ),
    );
  }
}