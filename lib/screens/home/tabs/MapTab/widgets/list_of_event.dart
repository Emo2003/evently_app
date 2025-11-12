import 'package:evently_app/core/resourse/AppConstant.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:flutter/material.dart';
import '../../../../../models/EventModel.dart';

class ListOfEvents extends StatelessWidget {
  final Event event;

  const ListOfEvents({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
      width: width * 0.73,
      decoration: BoxDecoration(
        color: ColorsManager.backgroundLight,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorsManager.blue, width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              typeImage[event.type].toString(),
              fit: BoxFit.fill,
              width: 100,
              height: height * 0.3,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event.title}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                   "${ event.description}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 14),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${event.city} , ${event.country}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
