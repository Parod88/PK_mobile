import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/screens/buildings/widgets/building_list.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/bloc/buildings/buildings_cubit.dart';
import 'package:passkey/shared/bloc/buildings/buildings_state.dart';
import 'package:passkey/shared/bloc/user/user_cubit.dart';
import 'package:passkey/shared/bloc/user/user_state.dart';
import 'package:passkey/shared/widgets/blue_header.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';

class FavoritesBuildings extends StatefulWidget {
  const FavoritesBuildings({super.key});

  @override
  FavoritesBuildingsState createState() => FavoritesBuildingsState();
}

class FavoritesBuildingsState extends State<FavoritesBuildings> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return ScreenLayout(
      child: Column(
        children: [
          BlueHeader(
            title: t.sections_favs,
            height: 124,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: BlocBuilder<UserCubit, UserState>(builder: (_, __) {
              return BlocBuilder<BuildingsCubit, BuildingsState>(
                builder: (_, buildingState) => BuildingList(
                  buildings: buildingState is BuildingsSuccess
                      ? buildingState.buildings
                          .where(
                            (building) => getIt<AuthService>()
                                .user!
                                .isFavorite(building.id),
                          )
                          .toList()
                      : [],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
