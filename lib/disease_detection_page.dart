import 'package:flutter/material.dart';
import 'models/mango_disease_detection.dart';
import 'models/tomato_disease_detection.dart';
// Import your model screens

class DiseaseDetectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of crops with their images and corresponding model screens
    final crops = [
      {
        'name': 'Mango',
        'image': 'lib/assets/mango.jpg',
        'screen': Placeholder(),
      },
      {
        'name': 'Tomato',
        'image': 'lib/assets/tomato.jpg',
        'screen': Placeholder(),
      },
      {
        'name': 'Corn',
        'image': 'lib/assets/corn.jpg',
        'screen': Placeholder(),
      },
      {
        'name': 'Potato',
        'image': 'lib/assets/potato.jpeg',
        'screen': Placeholder(),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.6, // Adjust this to make tiles larger
          ),
          itemCount: crops.length,
          itemBuilder: (context, index) {
            final crop = crops[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => crop['screen'] as Widget,
                  ),
                );
              },
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadowColor: Colors.greenAccent,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        crop['image'] as String,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(15)),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        crop['name'] as String,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


// import 'package:crop_care/on_boarding.dart';
// import 'package:flutter/material.dart';

// class DiseaseDetectionPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // List of crops with their images
//     final crops = [
//       {'name': 'Mango', 'image': 'lib/assets/mango.jpg'},
//       {'name': 'Tomato', 'image': 'lib/assets/tomato.jpg'},
//       {'name': 'Corn', 'image': 'lib/assets/corn.jpg'},
//       {'name': 'Potato', 'image': 'lib/assets/potato.jpeg'},
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16.0,
//             mainAxisSpacing: 16.0,
//             childAspectRatio: 0.6, // Adjust this to make tiles larger
//           ),
//           itemCount: crops.length,
//           itemBuilder: (context, index) {
//             final crop = crops[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => OnboardingScreen(),
//                   ),
//                 );
//               },
//               child: Card(
//                 elevation: 8.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 shadowColor: Colors.greenAccent,
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     ClipRRect(
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(15)),
//                       child: Image.asset(
//                         crop['image']!,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.black.withOpacity(0.6),
//                             Colors.transparent
//                           ],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                         ),
//                         borderRadius:
//                             BorderRadius.vertical(bottom: Radius.circular(15)),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 10,
//                       left: 10,
//                       child: Text(
//                         crop['name']!,
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
