import 'package:flutter/material.dart';
import 'package:flutter_sp24_lab/data/DatabaseHelper.dart';
import 'package:flutter_sp24_lab/data/cat_model.dart';
import '../main.dart';

class CatCreationScreen extends StatefulWidget {
  const CatCreationScreen({Key? key}) : super(key: key);

  @override
  State<CatCreationScreen> createState() => _CatCreationScreenState();
}

class _CatCreationScreenState extends State<CatCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _imageController = TextEditingController();
  final _ticketPriceController = TextEditingController();
  final _starRatingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Cat")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                icon: Icon(Icons.pets), // Changed icon to cat icon
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Cat name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _breedController,
              decoration: const InputDecoration(
                labelText: 'Breed',
                icon: Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Breed';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                icon: Icon(Icons.image),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _starRatingController,
              decoration: const InputDecoration(
                labelText: 'Star Rating',
                icon: Icon(Icons.star),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextFormField(
              controller: _ticketPriceController,
              decoration: const InputDecoration(
                labelText: 'Ticket Price',
                icon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      CatData catData = CatData(
        _nameController.text,
        _breedController.text,
        _imageController.text,
        double.tryParse(_starRatingController.text) ?? 0.0,
        double.tryParse(_ticketPriceController.text) ?? 0.0,
      );

      DatabaseHelper.addNewCat(catData);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _imageController.dispose();
    _starRatingController.dispose();
    _ticketPriceController.dispose();
    super.dispose();
  }
}
