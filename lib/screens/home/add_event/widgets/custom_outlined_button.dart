import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/providers/CreateEventProvider.dart';
import '../../../../core/resourse/ColorsManager.dart';
import '../../../../core/resourse/RouteManager.dart';

class CustomOutlinedButton extends StatelessWidget {
  final CreateEventProvider? provider;
  final String? location;
  final String? time;
  final String? date;
  final bool isLocation;

  const CustomOutlinedButton({
    super.key,
    this.provider,
    this.isLocation = false,
    this.location,
    this.time,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    String displayedLocation = "Choose Event Location";

    if (provider != null && provider!.city != null && provider!.country != null) {
      displayedLocation = "${provider!.city}, ${provider!.country}";
    } else if (location != null && location!.isNotEmpty) {
      displayedLocation = location!;
    }

    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          RouteManager.chooseLocation,
          arguments: provider,
        );
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: ColorsManager.blue, width: 1
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)
      )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isLocation
                    ? const Icon(
                  Icons.gps_fixed_outlined,
                  color: Colors.white,
                  size: 25,
                )
                    : SvgPicture.asset(AssetsManager.calendar),
              ),
              const SizedBox(width: 10),
              isLocation
                  ? Text(
                displayedLocation,
                style: const TextStyle(
                  color: ColorsManager.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date ?? "undefined",
                    style: const TextStyle(
                      color: ColorsManager.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    time ?? "undefined",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          if (isLocation)
            const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
              color: ColorsManager.blue,
            ),
        ],
      ),
    );
  }
}
