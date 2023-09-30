// ignore_for_file: unused_local_variable

import 'package:find_house/models/city.dart';
import 'package:find_house/models/space.dart';
import 'package:find_house/models/tips.dart';
import 'package:find_house/providers/space_providers.dart';
import 'package:find_house/theme.dart';
import 'package:find_house/widgets/bottom_navbar_items.dart';
import 'package:find_house/widgets/city_card.dart';
import 'package:find_house/widgets/space_card.dart';
import 'package:find_house/widgets/tips_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var spaceProvider = Provider.of<SpaceProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            SizedBox(
              height: edge,
            ),
            // NOTE: Title/Header
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Explore Now',
                style: blackTextStyle.copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Mencari kosan yang cozy',
                style: greyTextStyle.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // NOTE: POPULAR CITIES
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Popular Cities',
                style: regularTextStyle.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 24),
                  CityCard(City(
                    id: 1,
                    name: 'Jakarta',
                    imageUrl: 'assets/image_10.png',
                  )),
                  const SizedBox(width: 20),
                  CityCard(City(
                      id: 2,
                      name: 'Bandung',
                      imageUrl: 'assets/image_11.png',
                      isPopular: true)),
                  const SizedBox(width: 20),
                  CityCard(City(
                    id: 3,
                    name: 'Surabaya',
                    imageUrl: 'assets/image_detail.png',
                  )),
                  const SizedBox(width: 24),
                  const SizedBox(width: 20),
                  CityCard(City(
                    id: 4,
                    name: 'Palembang',
                    imageUrl: 'assets/palembang.png',
                  )),
                  const SizedBox(width: 20),
                  CityCard(City(
                      id: 5,
                      name: 'Aceh',
                      imageUrl: 'assets/aceh.png',
                      isPopular: true)),
                  const SizedBox(width: 20),
                  CityCard(City(
                    id: 6,
                    name: 'Bogor',
                    imageUrl: 'assets/bogor.png',
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // NOTE: RECOMENDED SPACE
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Popular Cities',
                style: regularTextStyle.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                "Recomended Space",
                style: blackTextStyle.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edge,
              ),
              child: FutureBuilder<List<Space>>(
                future: spaceProvider.getRecomendedSpace(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    List<Space> data = snapshot.data!;

                    int index = 0;

                    return Column(
                      children: data.map((item) {
                        index++;
                        return Container(
                          margin: EdgeInsets.only(top: index == 1 ? 0 : 30),
                          child: SpaceCard(item),
                        );
                      }).toList(),
                    );
                  }
                  return const Text('tidak ada data');
                }),
              ),
            ),

            //NOTES AND GUIDANCE
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Tips & Guidance',
                style: regularTextStyle.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge),
              child: Column(
                children: [
                  TipsCard(Tips(
                      Id: 1,
                      title: 'City Guidelines',
                      imagaUrl: 'assets/iconguidline.png',
                      updatedAt: '20 Apr')),
                  const SizedBox(
                    height: 20,
                  ),
                  TipsCard(Tips(
                      Id: 2,
                      title: 'Jakarta Fireship',
                      imagaUrl: 'assets/iconjf.png',
                      updatedAt: '11 Dec'))
                ],
              ),
            ),
            SizedBox(
              height: 50 + edge,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 65,
        width: MediaQuery.of(context).size.width - (2 * edge),
        margin: EdgeInsets.symmetric(
          horizontal: edge,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF6F7F8),
          borderRadius: BorderRadius.circular(23),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavbarItem(
              imageUrl: 'assets/icon_home.png',
              isActive: true,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_message.png',
              isActive: false,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_card.png',
              isActive: false,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_love.png',
              isActive: false,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
