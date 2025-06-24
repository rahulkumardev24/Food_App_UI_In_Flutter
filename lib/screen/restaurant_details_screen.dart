import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_ui/screen/search_details_screen.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: SvgPicture.string(shareIconSvg),
            onPressed: () {},
          ),
          /// search button 
          IconButton(
            icon: SvgPicture.string(searchIconSvg),
            onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen() ));
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              RestaurantInfo(),
              SizedBox(height: 16),
              FeaturedItems(),
              Items(),
            ],
          ),
        ),
      ),
    );
  }
}

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTabController(
          length: demoTabs.length,
          child: TabBar(
            isScrollable: true,
            unselectedLabelColor: const Color(0xFF010F07),
            labelStyle: Theme.of(context).textTheme.titleLarge,
            indicatorColor: const Color(0xFF22A45D),
            onTap: (value) {
              // you will get selected tab index
            },
            tabs: demoTabs,
          ),
        ),
        // SizedBox(height: defaultPadding),
        ...List.generate(
          demoData.length,
              (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ItemCard(
              title: demoData[index]["title"],
              description: demoData[index]["description"],
              image: demoData[index]["image"],
              foodType: demoData[index]['foodType'],
              price: demoData[index]["price"],
              priceRange: demoData[index]["priceRange"],
              press: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.foodType,
    required this.price,
    required this.priceRange,
    required this.press,
  });

  final String? title, description, image, foodType, priceRange;
  final double? price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
      color: const Color(0xFF010F07).withOpacity(0.64),
      fontWeight: FontWeight.normal,
    );
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 110,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                    ),
                    Text(
                      description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          priceRange!,
                          style: textStyle,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: SmallDot(),
                        ),
                        Text(foodType!, style: textStyle),
                        const Spacer(),
                        Text(
                          "USD$price",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: const Color(0xFF22A45D)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Tab> demoTabs = <Tab>[
  const Tab(
    child: Text('Most Populars'),
  ),
  const Tab(
    child: Text('Beef & Lamb'),
  ),
  const Tab(
    child: Text('Seafood'),
  ),
  const Tab(
    child: Text('Appetizers'),
  ),
  const Tab(
    child: Text('Dim Sum'),
  ),
];

final List<Map<String, dynamic>> demoData = List.generate(
  3,
      (index) => {
    "image": index == 0
        ? 'https://i.postimg.cc/hPQLdC7W/featured-items-1.png'
        : index == 1
        ? 'https://i.postimg.cc/vTJ6hs6R/featured-items-2.png'
        : 'https://i.postimg.cc/L8dzBzzq/featured-items-3.png',
    "title": "Cookie Sandwich",
    "description": "Shortbread, chocolate turtle cookies, and red velvet.",
    "price": 7.4,
    "foodType": "Chinese",
    "priceRange": "\$" * 2,
  },
);

class FeaturedItems extends StatelessWidget {
  const FeaturedItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("Featured Items",
              style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                3, // for demo we use 3
                    (index) => Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: FeaturedItemCard(
                    title: "Cookie Sandwich",
                    image: index == 0
                        ? 'https://i.postimg.cc/hPQLdC7W/featured-items-1.png'
                        : index == 1
                        ? 'https://i.postimg.cc/vTJ6hs6R/featured-items-2.png'
                        : 'https://i.postimg.cc/L8dzBzzq/featured-items-3.png',
                    foodType: "Chines",
                    priceRange: "\$" * 2,
                    press: () {},
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class FeaturedItemCard extends StatelessWidget {
  const FeaturedItemCard({
    super.key,
    required this.foodType,
    required this.image,
    required this.priceRange,
    required this.press,
    required this.title,
  });

  final String foodType, image, priceRange, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
      color: const Color(0xFF010F07).withOpacity(0.64),
      fontWeight: FontWeight.normal,
    );
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF010F07),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    priceRange,
                    style: textStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: SmallDot(),
                  ),
                  Text(foodType, style: textStyle)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mayfield Bakery & Cafe",
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          const PriceRangeAndFoodtype(
            foodType: ["Chinese", "American", "Deshi food"],
          ),
          const SizedBox(height: 8),
          const RatingWithCounter(rating: 4.3, numOfRating: 200),
          const SizedBox(height: 16),
          Row(
            children: [
              const DeliveryInfo(
                iconSrc: deliveryIconSvg,
                text: "Free",
                subText: "Delivery",
              ),
              const SizedBox(width: 16),
              const DeliveryInfo(
                iconSrc: clockIconSvg,
                text: "25",
                subText: "Minutes",
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Take away",
                  style: TextStyle(
                    color: Color(0xFF22A45D),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
    super.key,
    required this.iconSrc,
    required this.text,
    required this.subText,
  });

  final String iconSrc, text, subText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.string(
          iconSrc,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(
            Color(0xFF22A45D),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text.rich(
          TextSpan(
            text: "$text\n",
            style: Theme.of(context).textTheme.labelLarge,
            children: [
              TextSpan(
                text: subText,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PriceRangeAndFoodtype extends StatelessWidget {
  const PriceRangeAndFoodtype({
    super.key,
    this.priceRange = "\$\$",
    required this.foodType,
  });

  final String priceRange;
  final List<String> foodType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(priceRange, style: Theme.of(context).textTheme.bodyMedium),
        ...List.generate(
          foodType.length,
              (index) => Row(
            children: [
              buildSmallDot(),
              Text(foodType[index],
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Padding buildSmallDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SmallDot(),
    );
  }
}

class SmallDot extends StatelessWidget {
  const SmallDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}

class RatingWithCounter extends StatelessWidget {
  const RatingWithCounter({
    super.key,
    required this.rating,
    required this.numOfRating,
  });

  final double rating;
  final int numOfRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toString(),
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: const Color(0xFF010F07).withOpacity(0.74)),
        ),
        const SizedBox(width: 8),
        SvgPicture.string(
          ratingIconSvg,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(
            Color(0xFF22A45D),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text("$numOfRating+ Ratings",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: const Color(0xFF010F07).withOpacity(0.74))),
      ],
    );
  }
}

const ratingIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M12 17L8.59634 18.7894C8.18897 19.0036 7.68511 18.8469 7.47094 18.4396C7.38566 18.2774 7.35623 18.0916 7.38721 17.9109L8.03725 14.1209L5.28364 11.4368C4.95407 11.1155 4.94733 10.5879 5.26858 10.2584C5.3965 10.1271 5.56412 10.0417 5.74548 10.0154L9.55088 9.46243L11.2527 6.01415C11.4564 5.60144 11.9561 5.43199 12.3688 5.63568C12.5331 5.71679 12.6662 5.84981 12.7473 6.01415L14.4491 9.46243L18.2545 10.0154C18.7099 10.0816 19.0255 10.5044 18.9593 10.9599C18.933 11.1413 18.8476 11.3089 18.7163 11.4368L15.9627 14.1209L16.6128 17.9109C16.6906 18.3645 16.3859 18.7953 15.9323 18.8731C15.7517 18.9041 15.5659 18.8747 15.4036 18.7894L12 17Z" fill="#010F07"/>
</svg>
''';

const deliveryIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12ZM12.0422 4.5C11.6049 4.5 11.2505 4.85444 11.2505 5.29167V6.38655C11.1896 6.39982 11.1288 6.41399 11.0681 6.42908C10.5649 6.55408 10.1131 6.75158 9.71257 7.02158C9.31207 7.29158 8.9886 7.63658 8.74214 8.05658C8.49569 8.47658 8.37246 8.98158 8.37246 9.57158C8.37246 10.0516 8.45204 10.4591 8.61121 10.7941C8.77038 11.1291 8.9809 11.4141 9.24276 11.6491C9.50462 11.8841 9.80242 12.0766 10.1362 12.2266C10.4699 12.3766 10.8114 12.5066 11.1605 12.6166C11.5199 12.7266 11.8408 12.8291 12.1232 12.9241C12.4056 13.0191 12.6418 13.1241 12.8318 13.2391C13.0218 13.3541 13.1681 13.4816 13.2708 13.6216C13.3735 13.7616 13.4248 13.9316 13.4248 14.1316C13.4248 14.3416 13.3838 14.5216 13.3016 14.6716C13.2194 14.8216 13.1091 14.9416 12.9704 15.0316C12.8318 15.1216 12.6701 15.1866 12.4852 15.2266C12.3004 15.2666 12.1104 15.2866 11.9153 15.2866C11.484 15.2866 11.0501 15.1791 10.6137 14.9641C10.1772 14.7491 9.82553 14.4816 9.55853 14.1616L7.83333 15.8716C8.31598 16.3616 8.92185 16.7391 9.65096 17.0041C10.1711 17.1931 10.7043 17.3147 11.2505 17.3689V18.7083C11.2505 19.1456 11.6049 19.5 12.0422 19.5H12.0803C12.5175 19.5 12.8719 19.1456 12.8719 18.7083V17.324C13.074 17.2906 13.2737 17.2465 13.471 17.1916C13.9742 17.0516 14.4209 16.8366 14.8112 16.5466C15.2014 16.2566 15.512 15.8891 15.7431 15.4441C15.9741 14.9991 16.0896 14.4716 16.0896 13.8616C16.0896 13.3316 15.9818 12.8891 15.7662 12.5341C15.5505 12.1791 15.2784 11.8816 14.9498 11.6416C14.6212 11.4016 14.2566 11.2091 13.8561 11.0641C13.4556 10.9191 13.0706 10.7866 12.7009 10.6666C12.4441 10.5866 12.2131 10.5091 12.0077 10.4341C11.8023 10.3591 11.6252 10.2766 11.4763 10.1866C11.3274 10.0966 11.2144 9.99158 11.1374 9.87158C11.0604 9.75158 11.0219 9.60158 11.0219 9.42158C11.0219 9.21158 11.0707 9.03908 11.1682 8.90408C11.2658 8.76908 11.3864 8.65908 11.5302 8.57408C11.674 8.48908 11.8357 8.43158 12.0154 8.40158C12.1951 8.37158 12.3723 8.35658 12.5468 8.35658C12.8857 8.35658 13.2374 8.43908 13.602 8.60408C13.9665 8.76908 14.2618 8.99158 14.4877 9.27158L16.1667 7.54658C15.684 7.11658 15.1218 6.79158 14.48 6.57158C13.9347 6.38467 13.3987 6.27716 12.8719 6.24904V5.29167C12.8719 4.85444 12.5175 4.5 12.0803 4.5H12.0422Z" fill="#010F07"/>
</svg>
''';

const clockIconSvg =
'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M4 12C4 16.4183 7.58172 20 12 20C16.4183 20 20 16.4183 20 12C20 7.58172 16.4183 4 12 4C7.58172 4 4 7.58172 4 12ZM12.0422 7.11111H11.9671C11.7349 7.11111 11.5418 7.28991 11.524 7.52147L11.1393 12.5227C11.1229 12.7352 11.2598 12.9294 11.4655 12.9855L15.5712 14.1053C15.6003 14.1132 15.6304 14.1172 15.6605 14.1172C15.848 14.1172 16 13.9653 16 13.7778V13.5913C16 13.4318 15.9145 13.2845 15.7761 13.2054L12.8889 11.5556L12.4845 7.51133C12.4617 7.28413 12.2706 7.11111 12.0422 7.11111Z" fill="#010F07"/>
</svg>
''';

const shareIconSvg =
'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M7.62683 13.6939C7.6272 13.7341 7.62753 13.7697 7.62753 13.8006C7.62753 13.9503 7.62676 14.1578 7.62596 14.3719C7.62512 14.5999 7.62424 14.8354 7.62424 15.0163H7.74443C7.97199 15.0163 8.17547 14.8667 8.25435 14.6414L8.25437 14.6414C8.92315 12.731 9.86818 11.5708 11.0894 11.1607C11.9413 10.8746 12.879 10.7862 14.1953 10.748V13.7028C14.1953 13.8474 14.247 13.9866 14.3401 14.0927C14.5441 14.3252 14.888 14.3392 15.1083 14.1238L19.8257 9.51233C19.8373 9.50103 19.8484 9.4892 19.859 9.47688C20.0607 9.24216 20.044 8.87926 19.8216 8.66632L15.1042 4.14884C15.0042 4.05306 14.874 4 14.7389 4C14.4387 4 14.1953 4.25691 14.1953 4.57383V7.54677C12.1221 7.64403 10.3885 7.85731 9.23015 9.08696C7.6001 10.8174 7.62014 12.9747 7.62683 13.6939ZM11.176 5.46295C11.176 5.04039 10.8515 4.69784 10.4511 4.69784H6.89939C5.2981 4.69784 4 6.06804 4 7.75827V16.9396C4 18.6298 5.2981 20 6.89939 20H15.5976C17.1989 20 18.497 18.6298 18.497 16.9396V15.4094C18.497 14.9868 18.1724 14.6442 17.7721 14.6442C17.3718 14.6442 17.0473 14.9868 17.0473 15.4094V16.9396C17.0473 17.7847 16.3982 18.4698 15.5976 18.4698H6.89939C6.09875 18.4698 5.4497 17.7847 5.4497 16.9396V7.75827C5.4497 6.91316 6.09875 6.22806 6.89939 6.22806H10.4511C10.8515 6.22806 11.176 5.88551 11.176 5.46295Z" fill="#010F07"/>
</svg>
''';

const searchIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M11.1667 17C7.945 17 5.33333 14.3883 5.33333 11.1667C5.33333 7.94502 7.945 5.33334 11.1667 5.33334C14.3883 5.33334 17 7.94502 17 11.1667C17 12.6897 16.4163 14.0764 15.4605 15.1153L18.4226 18.0774C18.748 18.4029 18.748 18.9305 18.4226 19.2559C18.0971 19.5814 17.5695 19.5814 17.2441 19.2559L14.1616 16.1735C13.2862 16.6983 12.2617 17 11.1667 17ZM11.1667 15.3333C13.4678 15.3333 15.3333 13.4679 15.3333 11.1667C15.3333 8.86549 13.4678 7.00001 11.1667 7.00001C8.86547 7.00001 6.99999 8.86549 6.99999 11.1667C6.99999 13.4679 8.86547 15.3333 11.1667 15.3333Z" fill="#010F07"/>
</svg>
''';
