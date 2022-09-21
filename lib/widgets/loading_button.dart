import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.radius = 12,
    this.color,
  }) : super(key: key);
  final String title;
  final Function() onTap;
  final double radius;
  final Color? color;

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(_isLoading ? 60 : widget.radius),
        onTap: () async {
          if (!_isLoading) {
            setState(() {
              _isLoading = true;
            });
            await widget.onTap();
            setState(() => _isLoading = false);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
              vertical: 8, horizontal: _isLoading ? 8 : 16),
          decoration: BoxDecoration(
            color: widget.color ?? context.colorScheme.secondary,
            borderRadius:
                BorderRadius.circular(_isLoading ? 60 : widget.radius),
          ),
          child: !_isLoading
              ? Center(
                  child: Text(
                    widget.title,
                    style: context.button.copyWith(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                )
              : const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
        ));
  }
}
