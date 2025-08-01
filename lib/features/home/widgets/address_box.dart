import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(223, 38, 202, 60),
            Color.fromARGB(224, 162, 236, 168)
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(children: [
        const Icon(Icons.location_on_outlined),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Delivery to ${user.name} - ${user.address}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5, top: 2, right: 5),
          child: Icon(
            Icons.arrow_drop_down_circle_outlined,
            size: 25,
          ),
        ),
      ]),
    );
  }
}
