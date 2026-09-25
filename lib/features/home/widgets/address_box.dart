import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.addressBarGradient,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(GlobalVariables.radiusSm),
            ),
            child: const Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliver to ${user.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (user.address.isNotEmpty)
                  Text(
                    user.address,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white.withOpacity(0.8),
            size: 22,
          ),
        ],
      ),
    );
  }
}
