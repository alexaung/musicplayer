import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MonkCarousel extends StatelessWidget {
  const MonkCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints(
        // minWidth: 160,
        minHeight: 160,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 40,
            offset: const Offset(8, 10),
            color: Theme.of(context).primaryColor.withOpacity(0.18),
          ),
        ],
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 160,
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
                constraints: const BoxConstraints(
                  minHeight: 160,
                ),
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        minHeight: 100,
                      ),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/3.png"))),
                    ),
                    // Image.asset("assets/images/3.png"),
                    const SizedBox(
                      height: 5,
                    ),
                    const Flexible(
                      child: Text(
                        'မင်းကွန်းဆရာတော်ဘုရားကြီ:',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
