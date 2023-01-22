import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView( 
        padding: const EdgeInsets.only(left: 25),
        children: const [
          PrimaryHeading(input: 'Playlist', textColor: AppColor.textColor),
        ],
      ),
    );
  }
}
