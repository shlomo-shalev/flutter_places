// packages
import 'package:flutter/material.dart';
// widgets
import 'package:great_places/widgets/image_input_widget.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        label: const Text('Title'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInputWidget(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.secondary,
                ).copyWith(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                label: const Text('Add place'),
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
