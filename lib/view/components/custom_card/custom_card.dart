import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:bluetooth_invoices_printer/utils/app_size/app_size.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool useGradient;
  final List<Color>? gradientColors;
  final bool withShadow;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.useGradient = false,
    this.gradientColors,
    this.withShadow = true,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      padding: padding ?? EdgeInsets.all(AppSize.cardPadding),
      decoration: BoxDecoration(
        color: useGradient
            ? null
            : (backgroundColor ?? AppColors.cardBackground),
        gradient: useGradient
            ? LinearGradient(
                colors: gradientColors ?? AppColors.cardGradient.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppSize.radiusLarge,
        ),
        boxShadow: withShadow ? AppColors.cardShadow : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSize.radiusLarge,
          ),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
