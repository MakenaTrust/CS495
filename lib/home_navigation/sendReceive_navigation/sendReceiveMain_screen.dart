import 'package:flutter/material.dart';

class SendReceive extends StatelessWidget {
  const SendReceive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Send/Receive here',
          style: Theme.of(context).textTheme.headline6),
    );
  }
}
