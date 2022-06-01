import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Controllers/announcecontroller.dart';

class ModifyAnnounceWidget extends StatefulWidget {
  final announce_id;
  const ModifyAnnounceWidget({Key? key, required this.announce_id})
      : super(key: key);

  @override
  State<ModifyAnnounceWidget> createState() => _ModifyAnnounceWidgetState();
}

class _ModifyAnnounceWidgetState extends State<ModifyAnnounceWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.announce_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Modify'),
        actions: [
          OutlinedButton(
              onPressed: () {
                AnnounceController.deleteannounce(widget.announce_id);
              },
              child: const Text('Delete'))
        ],
      ),
      body: ListView(
        children: [
          ListView.builder(itemBuilder:((context, index) {
            return Stack(
              children: [
                // Image.network(src),

              ],
            );
          })),

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Text('Save')),
    );
  }
}
