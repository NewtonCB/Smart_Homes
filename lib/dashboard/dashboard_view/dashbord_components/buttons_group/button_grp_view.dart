import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renting_app/landlords_agents/landlords/landlords_view.dart';
import 'package:renting_app/landlords_agents/agents/agents_view.dart';
class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.to(const AgentsPage());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor:const Color(0xff06113c),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Reduced border radius
                ),
                minimumSize: const Size(double.infinity, 35), // Expand button to fill row space
                elevation: 5.0, // Text color
              ),
              child: const Text(
                  'Agents',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 8.0), // Space between buttons
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.to(const LandlordsPage());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color(0xff06113c),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Reduced border radius
                ),
                minimumSize: const Size(double.infinity, 35), // Expand button to fill row space
                elevation: 5.0, // Text color
              ),
              child: const Text('Landlords'),
            ),
          ),
        ],
      ),
    );
  }
}
