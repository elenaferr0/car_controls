import 'package:circular_progress_bar/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../business/models/minimal_notification.dart';
import '../../app_bloc.dart';
import '../../router/modal_bottom_sheet_route.dart';

class NotificationModalBottomSheet extends ModalBottomSheetGoRoute {
  static const String _path = '/modals/notifications';

  static String buildLocation() => _path;

  NotificationModalBottomSheet() : super(path: _path, builder: _builder);

  static Widget _builder(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      _NotificationModalBottomSheetWidget(
        state.extra as MinimalNotification,
      );
}

class _NotificationModalBottomSheetWidget extends StatelessWidget {
  final MinimalNotification notification;

  const _NotificationModalBottomSheetWidget(this.notification);

  @override
  Widget build(final BuildContext context) {
    final bloc = context.read<AppBloc>();
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            notification.icon != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(notification.icon!, height: 90),
                  )
                : Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Icon(
                      Icons.notifications,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
            Flexible(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title ?? 'New message',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    if (notification.text != null)
                      Text(
                        notification.text!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CircularProgressBar(
              strokeWidth: 10,
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveColor: Colors.black12,
              percentage: 100,
              radius: 30,
              percentageVisibility: false,
              duration: bloc.notificationDuration,
            )
          ],
        ),
      ),
    );
  }
}
