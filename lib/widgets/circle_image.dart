import 'package:flutter/material.dart';
import 'package:medi_vault/utils/image_utils.dart';

class CircleImage extends StatelessWidget {
  final double size;
  final String? imageString;

  const CircleImage({
    Key? key,
    this.imageString,
    this.size = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey,
          radius: size + 2,
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: size,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size),
              child: imageString != null
                  ? ImageUtility.imageFromBase64String(imageString!)
                  : Image.asset(
                      "assets/profile.png",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        )
      ],
    );
  }
}
