import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto_app_1/models/resaurant_model.dart';

import '../pages/detail_page.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
    required List items,
    required this.width,
    required this.height,
    required this.heightPicture,
  }) : super(key: key);

  final double height;
  final double heightPicture;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent));
          } else if (snapshot.hasError) {
            return const Text("There is something wrong");
          }

          final restaurant =
              restaurantFromJson(snapshot.data ?? "").restaurants;

          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailPage(
                              restaurant: restaurant[index],
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: width,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width,
                              height: heightPicture,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  restaurant[index].pictureId,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          //Text(restaurant[index].id),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: width,
                            child: Text(
                              maxLines: 1,
                              restaurant[index].name,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: Colors.red,
                                size: 15,
                              ),
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                restaurant[index].city,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ));
              });
        },
      ),
    );
  }
}
