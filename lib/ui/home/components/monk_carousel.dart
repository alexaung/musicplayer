import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class MonkCarousel extends StatelessWidget {
  const MonkCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: (MediaQuery.of(context).size.width - 90) / 2,
        // aspectRatio: 16/6,
        // enlargeCenterPage: true,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(
          milliseconds: 800,
        ),
        viewportFraction: 0.5,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/3.png"),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'မင်းကွန်းဆရာတော်ဘုရားကြီ:',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
