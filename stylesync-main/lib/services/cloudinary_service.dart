import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:stylesyncapp/utils/constants.dart';
import 'package:stylesyncapp/utils/showSnackBar.dart';

class CloudinaryService {
  Future<String> uploadImage(BuildContext context, File image) async {
    try {
      final cloudinary = CloudinaryPublic(cloudName, uploadPreset);
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: "users"),
      );
      print(res.secureUrl);
      return res.secureUrl;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return "";
  }

  Future<List<String>> uploadMultipleImages(BuildContext context, List<File> images) async {
  List<String> uploadedUrls = [];

  try {
    final cloudinary = CloudinaryPublic(cloudName, uploadPreset);

    for (File image in images) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: "designs"),
      );
      uploadedUrls.add(res.secureUrl);
    }

    return uploadedUrls;
  } catch (e) {
    showSnackBar(context, e.toString());
    return [];
  }
}
}
