import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(right: 25),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const VideoPreview(fileName: 'Pulimurugan');
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
      itemCount: 5,
    );
  }
}
