import 'package:flutter/material.dart';

class WorkoutSettingsButton extends StatelessWidget {
  const WorkoutSettingsButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isIcon,
    this.color,
    required this.radiusTop,
    required this.radiusBottom,
    required this.onTap,
  });

  final String title;
  final Widget icon;
  final bool isIcon;
  final MaterialColor? color;
  final double radiusTop;
  final double radiusBottom;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusTop),
          bottom: Radius.circular(radiusBottom),
        ),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusTop),
            bottom: Radius.circular(radiusBottom),
          ),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(
              left: isIcon ? 25 : 0,
            ),
            child: isIcon
                ? Row(
                    children: [
                      icon,
                      const SizedBox(width: 25),
                      Text(
                        title,
                        style: TextStyle(fontSize: 19, color: color),
                      ),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Center(
                      child: Text(title, style: const TextStyle(fontSize: 19)),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
