import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:resto_app_1/models/resaurant_model.dart';

import '../theme/theme_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.restaurant,
  });

  final RestaurantElement restaurant;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<String> foodMenu = [];
  final List<String> drinkMenu = [];

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context, listen: true);

    var food = widget.restaurant.menus.foods;
    var drink = widget.restaurant.menus.drinks;

    for (var i = 0; i < widget.restaurant.menus.foods.length; i++) {
      foodMenu.add(food[i].name);
    }
    for (var i = 0; i < drink.length; i++) {
      drinkMenu.add(drink[i].name);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Hero(
                  tag: "image-resto",
                  child: Image.network(
                    widget.restaurant.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.restaurant.name,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.red,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.restaurant.city,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w200),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rate_rounded,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.restaurant.rating.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: ReadMoreText(
                  widget.restaurant.description,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.normal),
                  trimLines: 5,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              ExpansionTile(
                textColor: theme.getTheme() == theme.lightTheme
                    ? Colors.black
                    : Colors.white,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text("Food Menu",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                children: foodMenu
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          color: theme.getTheme() == theme.lightTheme
                              ? Colors.grey.shade200
                              : Colors.grey.shade800,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 12, left: 16),
                                child: Image.asset(
                                  "assets/images/Icon - Sushi.png",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(e,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ExpansionTile(
                textColor: theme.getTheme() == theme.lightTheme
                    ? Colors.black
                    : Colors.white,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text("Drink Menu",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                children: drinkMenu
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          color: theme.getTheme() == theme.lightTheme
                              ? Colors.grey.shade200
                              : Colors.grey.shade800,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 12, left: 16),
                                child: Image.asset(
                                  "assets/images/Icon - Noodles.png",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(e,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
