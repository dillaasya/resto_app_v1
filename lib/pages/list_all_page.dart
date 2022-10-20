import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_1/models/resaurant_model.dart';
import 'package:resto_app_1/theme/theme_provider.dart';

import 'detail_page.dart';

class ListAllPage extends StatelessWidget {
  const ListAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final theme = Provider.of<ThemeNotifier>(context, listen: true);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/local_restaurant.json'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.redAccent));
              } else if (snapshot.hasError) {
                return const Text("There is something wrong");
              }

              
              final restaurant =
                  restaurantFromJson(snapshot.data ?? "").restaurants;

              return GridView.builder(
                scrollDirection: Axis.vertical,
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
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        color: theme.getTheme() == theme.lightTheme
                ? Colors.grey.shade200
                : Colors.grey.shade800,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 400,
                              child: Image.network(
                                restaurant[index].pictureId,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
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
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.97,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
