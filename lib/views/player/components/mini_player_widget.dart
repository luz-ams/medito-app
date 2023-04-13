import 'package:Medito/components/components.dart';
import 'package:Medito/constants/constants.dart';
import 'package:Medito/models/models.dart';
import 'package:Medito/view_model/page_view/page_view_viewmodel.dart';
import 'package:Medito/view_model/player/audio_play_pause_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'player_buttons/play_pause_button_component.dart';

class MiniPlayerWidget extends ConsumerWidget {
  const MiniPlayerWidget({super.key, required this.sessionModel});
  final SessionModel sessionModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(audioPlayPauseProvider(sessionModel.hasBackgroundSound));

    return InkWell(
      onTap: () {
        ref.read(pageviewNotifierProvider).gotoNextPage();
      },
      child: Container(
        height: 64,
        color: ColorConstants.greyIsTheNewGrey,
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sessionCoverImage(sessionModel.coverUrl),
                  _titleAndSubtitle(context),
                ],
              ),
            ),
            _playPauseButton(),
          ],
        ),
      ),
    );
  }

  Padding sessionCoverImage(String url) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SizedBox(
        height: 40,
        width: 40,
        child: NetworkImageComponent(
          url: url,
          isCache: true,
        ),
      ),
    );
  }

  Flexible _titleAndSubtitle(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(context),
            _subtitle(context),
          ],
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      sessionModel.title,
      textAlign: TextAlign.left,
      style: Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
            fontFamily: ClashDisplay,
            color: ColorConstants.walterWhite,
            fontSize: 16,
            letterSpacing: 1,
          ),
    );
  }

  SizedBox _subtitle(BuildContext context) {
    var titleMedium = Theme.of(context).textTheme.titleMedium;
    var walterWhite = ColorConstants.walterWhite.withOpacity(0.9);
    if (sessionModel.artist == null) {
      return SizedBox();
    }

    return SizedBox(
      height: 15,
      child: MarkdownComponent(
        body:
            '${sessionModel.artist?.name ?? ''} ${sessionModel.artist?.path ?? ''}',
        textAlign: WrapAlignment.start,
        p: titleMedium?.copyWith(
          fontFamily: DmMono,
          letterSpacing: 1,
          fontSize: 12,
          color: walterWhite,
          overflow: TextOverflow.ellipsis,
        ),
        a: titleMedium?.copyWith(
          fontFamily: DmMono,
          color: walterWhite,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Padding _playPauseButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: PlayPauseButtonComponent(
        iconSize: 40,
      ),
    );
  }
}
