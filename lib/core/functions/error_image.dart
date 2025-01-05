import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: avoid_types_as_parameter_names, non_constant_identifier_names
Widget myErrorWidget(context, imageUrl, error) {
  return CachedNetworkImage(
    imageUrl:
        'https://conference.nbasbl.org/wp-content/uploads/2022/05/placeholder-image-1.png',
    fit: BoxFit.cover,
  );
}
