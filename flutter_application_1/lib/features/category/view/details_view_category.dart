import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsViewCategory extends StatelessWidget {
  final String title;
  final List images;
  final String description;
  //final String category;
  final double price;
  final double rating;
  //final int stock;
  // final String thumbnail;

  DetailsViewCategory({
    super.key,
    required this.title,
    required this.images,
    required this.description,
    // required this.category,
    required this.price,
    required this.rating,
    // required this.stock,
    // required this.thumbnail,
  });
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        children: [
          SizedBox(
            height: 390,
            child: PageView.builder(
              controller: controller,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.network(images[index], fit: BoxFit.cover);
              },
            ),
          ),

          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: images.length,
              effect: WormEffect(dotHeight: 12, dotWidth: 12),
            ),
          ),

          SizedBox(height: 10),

          SizedBox(
            height: 80,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Image.network(images[index]),
                    ),
                  );
                },
              ),
            ),
          ),

          Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 1,
                  offset: Offset(5, 1),
                ),
              ],
            ),
            child: Divider(
              color: const Color.fromARGB(255, 112, 190, 254),
              thickness: 1,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.colorbluebutton),
                    ),
                    child: coustomtext(
                      text: "Free Shipping",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorbluebutton,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 120),
              RatingBarIndicator(
                rating: rating, // الرقم اللي جاي من الـ JSON بتاعك
                itemBuilder: (context, index) =>
                    Icon(Icons.star, color: Colors.black),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              Text("($rating)"),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                coustomtext(
                  text: title,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                ReadMoreText(
                  description, // الوصف اللي جاي من الـ JSON
                  trimLines: 2, // يظهر كام سطر قبل ما يقص
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: ' Show less',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10),
                coustomtext(
                  text: "Select Size",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  children: [
                    coustomtext(
                      text: "price",
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                    ),
                    coustomtext(
                      text: "${price}EGP",
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(width: 22),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(6),
                    height: 55,
                    width: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.colorbluebutton),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: AppColors.colorbluebutton,
                          ),
                          SizedBox(width: 6),
                          coustomtext(
                            text: "Free Shipping",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.colorbluebutton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
