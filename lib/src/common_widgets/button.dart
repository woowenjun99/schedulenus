import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: isLoading
            ? const SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Text(
                buttonText,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
