import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sp24_lab/reuseable/AppStyles.dart';
import 'package:flutter_sp24_lab/reuseable/ImageDecoration.dart';
import 'package:flutter_sp24_lab/screens/MyDynamicImageListScreen.dart';

import '../data/DatabaseHelper.dart';
import '../data/cat_model.dart';
import '../main.dart';
import 'StaticImageList.dart';

class CatDetailScreen extends StatefulWidget {
  final Cat cat;

  const CatDetailScreen({super.key, required this.cat});

  @override
  State<CatDetailScreen> createState() => _CatDetailScreenState();
}

class _CatDetailScreenState extends State<CatDetailScreen> {
  int _ticketQuantity = 1;
  double _ticketPrice = 0, _runningCost = 0;

  @override
  Widget build(BuildContext context) {
    _ticketPrice = widget.cat.catData?.ticketPrice ?? 0.0;
    _runningCost = _ticketQuantity * 20.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cat.catData?.name ?? 'Cat Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Displaying the local image
            widget.cat.catData?.imagePath != null
                ? ImageDecoration(
                imagePath: widget.cat.catData!.imagePath!)
                : const SizedBox(height: 200, child: Placeholder()),

            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Name: ",
                  style: AppStyles.headlineStyle1,
                ),
                Text(
                  '${widget.cat.catData?.name ?? 'N/A'}',
                  style: AppStyles.headlineStyle2,
                ),
              ],
            ),

            const SizedBox(height: 10),
            Text('Breed: ${widget.cat.catData?.breed ?? 'N/A'}'),

            Text(
                'Adoption price: 20'),
            const SizedBox(height: 20),
            const Text('Select Ticket Quantity:'),
            Slider(
              value: _ticketQuantity.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _ticketQuantity.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _ticketQuantity = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Running Cost: OMR ${_runningCost.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _showNotification, child: const Text("Notify")),

            const SizedBox(height: 10),
            // Add RatingBar here
            RatingBar.builder(
              initialRating: widget.cat.catData?.starRating ?? 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                // Update the rating in the database
                widget.cat.catData?.starRating = rating;
                DatabaseHelper.updateCatData(
                    widget.cat.key!, widget.cat.catData!)
                    .then((_) {
                  // Show a snackbar on successful update
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Rating updated successfully')),
                  );
                }).catchError((error) {
                  // Handle errors and show a different snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Failed to update rating: ${error.toString()}')),
                  );
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _deleteCat(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Use min size for the Row
                children: [
                  Icon(Icons.delete), // Delete icon
                  SizedBox(width: 8), // Space between icon and text
                  Text('Delete Cat'), // Button text
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Main Page'),
            ),
          ],
        ),
      ),
    );
  }

  _deleteCat() {
    if (widget.cat.key != null && widget.cat.catData?.name != null) {
      String catName = widget.cat.catData!.name!;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Deletion'),
            content:
            Text('Are you sure you want to delete the cat $catName?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  DatabaseHelper.deleteCat(widget.cat.key!);
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$catName cat deleted')),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const MyDynamicImageListScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Purchase Confirmation',
      'Thank you for adopting $_ticketQuantity cat/s for a total of OMR ${_runningCost.toStringAsFixed(2)}',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
