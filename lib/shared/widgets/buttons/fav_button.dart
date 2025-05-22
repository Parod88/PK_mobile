import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/bloc/user/user_cubit.dart';
import 'package:passkey/shared/bloc/user/user_state.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/widgets/circled_button.dart';

class FavButton extends StatelessWidget {
  final String buildingId;
  const FavButton({super.key, required this.buildingId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return CircledButton(
          onTap: () =>
              BlocProvider.of<UserCubit>(context).updateFavs(buildingId),
          icon: getIt<AuthService>().user!.isFavorite(buildingId)
              ? AppIcons.heartFilledIcon
              : AppIcons.heartIcon,
        );
      },
    );
  }
}
