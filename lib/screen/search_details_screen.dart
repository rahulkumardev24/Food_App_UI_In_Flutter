import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _showSearchResult = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void showResult() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showSearchResult = true;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text('Search', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              const SearchForm(),
              const SizedBox(height: 16),
              Text(
                _showSearchResult ? "Search Results" : "Top Restaurants",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _isLoading ? 2 : 5, //5 is demo length of your data
                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child:
                            _isLoading
                                ? const BigCardScalton()
                                : RestaurantInfoBigCard(
                                  // Images are List<String>
                                  images: demoBigImages..shuffle(),
                                  name: "McDonald's",
                                  rating: 4.3,
                                  numOfRating: 200,
                                  deliveryTime: 25,
                                  foodType: const [
                                    "Chinese",
                                    "American",
                                    "Deshi food",
                                  ],
                                  press: () {},
                                ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantInfoBigCard extends StatelessWidget {
  final List<String> images, foodType;
  final String name;
  final double rating;
  final int numOfRating, deliveryTime;
  final bool isFreeDelivery;
  final VoidCallback press;

  const RestaurantInfoBigCard({
    super.key,
    required this.name,
    required this.rating,
    required this.numOfRating,
    required this.deliveryTime,
    this.isFreeDelivery = true,
    required this.images,
    required this.foodType,
    required this.press,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pass list of images here
          BigCardImageSlide(images: images),
          const SizedBox(height: 8),
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          PriceRangeAndFoodtype(foodType: foodType),
          const SizedBox(height: 4),
          Row(
            children: [
              RatingWithCounter(rating: rating, numOfRating: numOfRating),
              const SizedBox(width: 8),
              SvgPicture.string(
                clockIconSvg,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  Theme.of(
                    context,
                  ).textTheme.bodyLarge!.color!.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "$deliveryTime Min",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SmallDot(),
              ),
              SvgPicture.string(
                deliveryIconSvg,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  Theme.of(
                    context,
                  ).textTheme.bodyLarge!.color!.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isFreeDelivery ? "Free" : "Paid",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCardScalton extends StatelessWidget {
  const BigCardScalton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AspectRatio(aspectRatio: 1.81, child: BigCardImageSlideScalton()),
        const SizedBox(height: 16),
        ScaltonLine(width: MediaQuery.of(context).size.width * 0.8),
        const SizedBox(height: 16),
        const ScaltonLine(),
        const SizedBox(height: 16),
        const ScaltonLine(),
      ],
    );
  }
}

class BigCardImageSlideScalton extends StatelessWidget {
  const BigCardImageSlideScalton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Row(
            children: List.generate(4, (index) => const DotIndicator()),
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.activeColor = const Color(0xFF22A45D),
    this.inActiveColor = const Color(0xFF868686),
  });

  final bool isActive;
  final Color activeColor, inActiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

class ScaltonLine extends StatelessWidget {
  const ScaltonLine({
    super.key,
    this.height = 15,
    this.width = double.infinity,
  });

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.black.withOpacity(0.08),
    );
  }
}

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        onChanged: (value) {
          // get data while typing
          // if (value.length >= 3) showResult();
        },
        onFieldSubmitted: (value) {
          if (_formKey.currentState!.validate()) {
            // If all data are correct then save data to out variables
            _formKey.currentState!.save();

            // Once user pree on submit
          } else {}
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your search query";
          }
          return null;
        },
        style: Theme.of(context).textTheme.labelLarge,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Search on foodly",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.string(
              searchIconSvg,
              colorFilter: const ColorFilter.mode(
                Color(0xFF868686),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const searchIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M11.1667 17C7.945 17 5.33333 14.3883 5.33333 11.1667C5.33333 7.94502 7.945 5.33334 11.1667 5.33334C14.3883 5.33334 17 7.94502 17 11.1667C17 12.6897 16.4163 14.0764 15.4605 15.1153L18.4226 18.0774C18.748 18.4029 18.748 18.9305 18.4226 19.2559C18.0971 19.5814 17.5695 19.5814 17.2441 19.2559L14.1616 16.1735C13.2862 16.6983 12.2617 17 11.1667 17ZM11.1667 15.3333C13.4678 15.3333 15.3333 13.4679 15.3333 11.1667C15.3333 8.86549 13.4678 7.00001 11.1667 7.00001C8.86547 7.00001 6.99999 8.86549 6.99999 11.1667C6.99999 13.4679 8.86547 15.3333 11.1667 15.3333Z" fill="#010F07"/>
</svg>
''';
