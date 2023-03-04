import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../globals/globals.dart';

text({required String text}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.bold, color: Global.bg),
  );
}

Widget carouselSlider(
    {required double height,
    required double width,
    required String productName,
    required String category}) {
  return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 4/3,
        autoPlay: true,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: List.generate(
        4,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                  "https://source.unsplash.com/random/${index + 1}?$productName,$category"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ).toList());
}
