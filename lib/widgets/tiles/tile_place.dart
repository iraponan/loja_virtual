import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({super.key, required this.snapshot});

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    Uri phone = Uri(scheme: 'tel', path: snapshot.get('phone'));
    Uri map = Uri(
        scheme: 'https',
        host: 'www.google.com',
        path: 'maps/search/',
        queryParameters: {
          'api': '1',
          'query': '${snapshot.get('lat').toString()},${snapshot.get('long').toString()}'
        });

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(snapshot.get('image'), fit: BoxFit.cover),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.get('title'),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                Text(
                  snapshot.get('address'),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  launchUrl(map, mode: LaunchMode.inAppBrowserView);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: EdgeInsets.zero,
                ),
                child: const Text('Ver no Mapa'),
              ),
              TextButton(
                onPressed: () {
                  launchUrl(phone);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: EdgeInsets.zero,
                ),
                child: const Text('Ligar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
