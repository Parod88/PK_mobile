import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/domain/models/bookings/booking_model.dart';
import 'package:passkey/domain/models/building/building.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/theme/images.dart';
import 'package:passkey/shared/utils/dates.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class MainCard extends StatelessWidget {
  final BuildingModel building;
  final BookingModel? booking;
  final Function? onTap;
  final double height;
  final double? paddingX;

  const MainCard({
    required this.building,
    this.booking,
    this.onTap,
    this.height = 239,
    this.paddingX = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: clearGrey, width: 1),
          color: Colors.white,
          boxShadow: defaultShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 144,
              width: double.infinity,
              child: Image.asset(AppImages.mockgym, fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: paddingX ?? 0,
                  right: paddingX ?? 0,
                  top: 12,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: booking == null
                      ? _buildBuildingInfo()
                      : _buildBuildingBookingInfo(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBuildingInfo() {
    return [
      AppText(
        text: building.name,
        color: darkTextColor,
        size: 14,
        fontWeight: FontWeight.w600,
      ),
      AppText(
        text: building.address,
        size: 14,
        color: softTextColor,
      ),
      AppText(
        text: building.description,
        size: 12,
        color: softTextColor,
        overflow: TextOverflow.ellipsis,
      ),
    ];
  }

  List<Widget> _buildBuildingBookingInfo() {
    return [
      AppText(
        text: building.name,
        color: darkTextColor,
        size: 14,
        fontWeight: FontWeight.w600,
      ),
      Row(
        children: [
          SvgPicture.asset(
            AppIcons.mapPinIcon,
            color: softTextColor,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 4),
          AppText(
            text: building.address,
            size: 14,
            lineHeight: 1.5,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.266,
            color: softTextColor,
          ),
        ],
      ),
      Row(
        children: [
          SvgPicture.asset(
            AppIcons.calendarIcon,
            color: softTextColor,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 4),
          AppText(
            text: booking!.dates.length > 1
                ? '${DateFormatter.onlyDate(booking!.dates.first)} - ${DateFormatter.onlyDate(booking!.dates.last)}'
                : DateFormatter.onlyDate(booking!.dates.first),
            size: 14,
            lineHeight: 1.5,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.266,
            color: softTextColor,
          ),
        ],
      ),
      Row(
        children: [
          SvgPicture.asset(
            AppIcons.clockIcon,
            color: softTextColor,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 4),
          AppText(
            text: booking!.bookingTime.start,
            size: 14,
            lineHeight: 1.5,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.266,
            color: softTextColor,
          ),
        ],
      ),
    ];
  }
}
