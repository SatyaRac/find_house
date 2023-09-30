import 'package:find_house/models/space.dart';
import 'package:find_house/pages/error_page.dart';
import 'package:find_house/theme.dart';
import 'package:find_house/widgets/facility_items.dart';
import 'package:find_house/widgets/ratting_item.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.space}) : super(key: key);
  final Space space;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    void _launchUrl(String url) async {
      // if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
      if (await canLaunchUrl(Uri.parse(url))) {
        launchUrl(Uri.parse(url));
      } else {
        // throw (url);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ErrorPage(),
            ));
      }
    }

    void showConfirmationDialog() {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Konfirmasi'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Apakah Anda yakin ingin menghubungi pemilik kost?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Tidak'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Hubungi'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _launchUrl('tel:${widget.space.phone}');
                },
              ),
            ],
          );
        },
      );
    }

    int index = 0;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.network(
              widget.space.imageUrl,
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                const SizedBox(
                  height: 328,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      // Title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.space.name,
                                    style:
                                        blackTextStyle.copyWith(fontSize: 22),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: '\$${widget.space.price}',
                                      style: purpleTextStyle.copyWith(
                                          fontSize: 16),
                                      children: [
                                        TextSpan(
                                            text: '/ month',
                                            style: greyTextStyle.copyWith(
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [1, 2, 3, 4, 5].map((index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  child: RattingItem(
                                      index: index,
                                      ratting: widget.space.rating),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // Main Facilities
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Text(
                          'Main Facilities',
                          style: regularTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityItems(
                                imageUrl: 'assets/iconBar.png',
                                name: 'kitchen',
                                total: widget.space.number_of_kitchens),
                            FacilityItems(
                                imageUrl: 'assets/iconBed.png',
                                name: 'bedroom',
                                total: widget.space.number_of_bedrooms),
                            FacilityItems(
                                imageUrl: 'assets/iconLemari.png',
                                name: 'Big Lemari',
                                total: widget.space.number_of_cupboards),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // Photos
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Text(
                          'Photos',
                          style: regularTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 88,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: widget.space.photos.map((e) {
                            index++;
                            return Container(
                              margin: EdgeInsets.only(
                                left: index == 0 ? edge : 18,
                                right: index == widget.space.photos.length
                                    ? edge
                                    : 0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  e,
                                  width: 110,
                                  height: 88,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // Location
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Text(
                          'Location',
                          style: regularTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.space.address,
                              style: greyTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                _launchUrl(widget.space.mapUrl);
                              },
                              child: Image.asset(
                                'assets/iconMap.png',
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: (() {
                          showConfirmationDialog();
                        }),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: edge),
                          height: 50,
                          width: MediaQuery.of(context).size.width - (2 * edge),
                          decoration: BoxDecoration(
                              color: purpleColor,
                              borderRadius: BorderRadius.circular(17)),
                          child: Center(
                              child: Text(
                            'Book Now',
                            style: whiteTextStyle.copyWith(fontSize: 18),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/btn_back.png',
                      width: 40,
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        isLike = !isLike;
                      });
                    }),
                    child: Image.asset(
                      isLike
                          ? 'assets/btn_wishlist.png'
                          : 'assets/icon_love.png',
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
