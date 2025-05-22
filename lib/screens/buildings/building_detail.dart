import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/screens/bookings/new-booking/bloc/new_booking_cubit.dart';
import 'package:passkey/screens/bookings/new-booking/bloc/new_booking_state.dart';
import 'package:passkey/screens/buildings/widgets/detail_description.dart';
import 'package:passkey/screens/buildings/widgets/detail_features.dart';
import 'package:passkey/screens/buildings/widgets/detail_title.dart';
import 'package:passkey/shared/app_divider.dart';
import 'package:passkey/shared/mixin/loading.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/theme/images.dart';
import 'package:passkey/shared/widgets/buttons/fav_button.dart';
import 'package:passkey/shared/widgets/buttons/main_button.dart';
import 'package:passkey/shared/widgets/circled_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildingDetail extends StatefulWidget {
  final BuildingModel building;

  const BuildingDetail({
    super.key,
    required this.building,
  });

  @override
  State<BuildingDetail> createState() => _BuildingDetailState();
}

class _BuildingDetailState extends State<BuildingDetail> with LoadingOverlay {
  late NewBookingCubit _newBookingCubit;

  @override
  void initState() {
    super.initState();
    _newBookingCubit = BlocProvider.of<NewBookingCubit>(context);
    _newBookingCubit.stream.listen((state) {
      if (mounted) {
        if (state is NewBookingStartProcess) {
          _newBookingCubit.fetchPrevBookings(widget.building);
        }
        if (state is NewBookingFetchPrevBookings) {
          showSpinner(context);
        }
        if (state is NewBookingFormState) {
          hideSpinner();
          Navigator.pushNamed(
            context,
            Routes.bookingNew,
            arguments: state.availability,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 334,
                  child: Image.asset(
                    AppImages.mockgym,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailTitle(building: widget.building),
                          const AppDivider(mt: 12, mb: 12),
                          DetailDescription(building: widget.building),
                          const AppDivider(mt: 12, mb: 12),
                          DetailFeatures(features: widget.building.features),
                        ],
                      ),
                    ),
                  ),
                ),
                const AppDivider(mt: 12, mb: 12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 19),
                  child: MainButton(
                    onTap: () =>
                        _newBookingCubit.selectBuilding(widget.building),
                    btnText: t.detail_btn_book,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 65,
            left: 18,
            right: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircledButton(
                  onTap: () => Navigator.pop(context),
                  icon: AppIcons.leftArrowIcon,
                ),
                FavButton(buildingId: widget.building.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
