import 'dart:async';

import 'package:Medito/constants/constants.dart';
import 'package:Medito/models/models.dart';
import 'package:Medito/providers/providers.dart';
import 'package:Medito/routes/routes.dart';
import 'package:Medito/utils/utils.dart';
import 'package:Medito/views/pack/widgets/pack_dismissible_widget.dart';
import 'package:Medito/views/pack/widgets/pack_item_widget.dart';
import 'package:Medito/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/headers/description_widget.dart';

class PackView extends ConsumerStatefulWidget {
  const PackView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  ConsumerState<PackView> createState() => _PackViewState();
}

class _PackViewState extends ConsumerState<PackView>
    with AutomaticKeepAliveClientMixin<PackView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var packs = ref.watch(packProvider(packId: widget.id));

    return Scaffold(
      body: packs.when(
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        data: (data) => _buildScaffoldWithData(data, ref),
        error: (err, stack) => MeditoErrorWidget(
          message: err.toString(),
          onTap: () => ref.refresh(packProvider(packId: widget.id)),
          isLoading: packs.isLoading,
        ),
        loading: () => const FolderShimmerWidget(),
      ),
    );
  }

  void _scrollListener() {
    setState(() => {});
  }

  RefreshIndicator _buildScaffoldWithData(
    PackModel pack,
    WidgetRef ref,
  ) {
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(packProvider(packId: widget.id)),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          MeditoAppBarLarge(
            scrollController: _scrollController,
            title: pack.title,
            coverUrl: pack.coverUrl,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [DescriptionWidget(description: pack.description)]
                      .cast<Widget>() +
                  _listItems(pack, ref) +
                  [
                    height32,
                  ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _listItems(PackModel pack, WidgetRef ref) {
    return pack.items
        .map(
          (packItem) => GestureDetector(
            onTap: () => _onListItemTap(
              packItem.id,
              packItem.type,
              packItem.path,
              ref.context,
            ),
            child: _buildListTile(
              packItem,
              pack.items.last == packItem,
            ),
          ),
        )
        .toList();
  }

  Widget _buildListTile(
    PackItemsModel item,
    bool isLast,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _onListItemTap(item.id, item.type, item.path, context);
          },
          splashColor: ColorConstants.charcoal,
          child: PackDismissibleWidget(
            child: PackItemWidget(item: item),
            onDismissed: () {
              ref.read(packProvider(packId: widget.id).notifier).toggle(
                    audioFileId: item.path.getIdFromPath(),
                    trackId: item.id,
                    isComplete: item.isCompleted == true,
                  );
            },
          ),
        ),
        if (!isLast)
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Divider(
              color: ColorConstants.charcoal,
              thickness: 2,
              height: 2,
            ),
          ),
      ],
    );
  }

  void _onListItemTap(
    String? id,
    String? type,
    String? path,
    BuildContext context,
  ) {
    checkConnectivity().then((value) {
      if (value) {
        var location = GoRouter.of(context).location;
        if (type == TypeConstants.pack) {
          if (location.contains('pack2')) {
            unawaited(handleNavigation(
              context: context,
              RouteConstants.pack3Path,
              [location.split('/')[2], widget.id, id.toString()],
            ));
          } else {
            unawaited(handleNavigation(
              context: context,
              RouteConstants.pack2Path,
              [widget.id, id.toString()],
            ));
          }
        } else {
          unawaited(handleNavigation(
            context: context,
            type,
            [id.toString(), path],
            ref: ref,
          ));
        }
      } else {
        createSnackBar(StringConstants.checkConnection, context);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
