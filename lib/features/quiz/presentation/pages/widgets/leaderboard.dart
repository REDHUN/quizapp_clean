import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final colors = [
                  const Color(0xFFEAB308),
                  const Color(0xFF94A3B8),
                  const Color(0xFFD97706),
                ];

                return ListTile(
                  leading: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: colors[index].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: colors[index],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'User ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: colors[index].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${1000 - (index * 100)} pts',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
