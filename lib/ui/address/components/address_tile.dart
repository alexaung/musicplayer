import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressTile extends StatelessWidget {
  final About about;
  final int index;
  const AddressTile({required this.about, required this.index, Key? key})
      : super(key: key);

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    Address address = about.addresses![index];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12, top: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).backgroundColor),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_pin,
                      //size: 30,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: AutoSizeText(
                        address.line1Address!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      AutoSizeText(
                        '${address.line2Address!} ${address.township!} ${address.state!} ${address.country!} ${address.postalCode}',
                        //maxLines: 1,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      //size: 30,
                    ),
                    const SizedBox(width: 4),
                    Row(
                      children: [
                        //const SizedBox(height: 30),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            _launchURL("tel:${address.phone1!}");
                          },
                          child: Text(address.phone1!),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            _launchURL("tel:${address.phone2!}");
                          },
                          child: Text(address.phone2!),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _launchURL(about.facebook!);
                      },
                      icon: const Icon(Icons.facebook_outlined),
                      label: const AutoSizeText("Facebook"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _launchURL(about.messenger!);
                      },
                      icon: const Icon(Icons.messenger_outline_sharp),
                      label: const AutoSizeText("Chat"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _launchURL(about.youtube!);
                      },
                      icon: const Icon(Icons.videocam),
                      label: const AutoSizeText("Youtube"),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 10),
          //   height: 60,
          //   width: 0.5,
          //   color: Colors.grey[200]!.withOpacity(0.7),
          // ),
          // RotatedBox(
          //   quarterTurns: 3,
          //   child: AutoSizeText(
          //     address.country == 'Myanmar' ? "မြန်မာ" : "စင်္ကာပူ",
          //     style: const TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
