import 'package:flutter/material.dart';

import 'order_details_screen.dart';

class AddToOrderScrreen extends StatefulWidget {
  const AddToOrderScrreen({super.key});

  @override
  State<AddToOrderScrreen> createState() => _AddToOrderScrreenState();
}

class _AddToOrderScrreenState extends State<AddToOrderScrreen> {
  // for demo we select 2nd one
  int choiceOfTopCookie = 1;

  int choiceOfBottomCookie = 1;

  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              backgroundColor: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.zero,
            ),
            child: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Info(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RequiredSectionTitle(title: "Choice of top Cookie"),
                    const SizedBox(height: 16),
                    ...List.generate(
                      choiceOfTopCookies.length,
                      (index) => RoundedCheckboxListTile(
                        isActive: index == choiceOfTopCookie,
                        text: choiceOfTopCookies[index],
                        press: () {
                          setState(() {
                            choiceOfTopCookie = index;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const RequiredSectionTitle(
                      title: "Choice of Bottom Cookie",
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(
                      choiceOfTopCookies.length,
                      (index) => RoundedCheckboxListTile(
                        isActive: index == choiceOfBottomCookie,
                        text: choiceOfTopCookies[index],
                        press: () {
                          setState(() {
                            choiceOfBottomCookie = index;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // // Num of item
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF22A45D),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                              shape: const CircleBorder(),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            numOfItems.toString().padLeft(2, "0"),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF22A45D),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                              shape: const CircleBorder(),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22A45D),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderDetailsScreen(),
                          ),
                        );
                      },
                      child: const Text("Add to Order (\$11.98)"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  List<String> choiceOfTopCookies = [
    "Choice of top Cookie",
    "Cookies and Cream",
    "Funfetti",
    "M and M",
    "Red Velvet",
    "Peanut Butter",
    "Snickerdoodle",
    "White Chocolate Macadamia",
  ];
}

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.33,
          child: Image.network(
            "https://i.postimg.cc/pLjj1p2m/Header-image.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cookie Sandwich",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "Shortbread, chocolate turtle cookies, and red velvet. 8 ounces cream cheese, softened.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              const PriceRangeAndFoodtype(
                foodType: ["Chinese", "American", "Deshi food"],
              ),
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
              Text(
                foodType[index],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
  const SmallDot({super.key});

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

class RoundedCheckboxListTile extends StatelessWidget {
  const RoundedCheckboxListTile({
    super.key,
    this.isActive = false,
    required this.press,
    required this.text,
  });

  final bool isActive;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                CircleCheckBox(isActive: isActive),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF010F07).withOpacity(0.84),
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class CircleCheckBox extends StatelessWidget {
  const CircleCheckBox({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 24,
      width: 24,
      padding: EdgeInsets.all(isActive ? 3 : 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              isActive
                  ? const Color(0xFF22A45D).withOpacity(0.54)
                  : const Color(0xFF868686).withOpacity(0.54),
          width: 0.8,
        ),
      ),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFF22A45D),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class RequiredSectionTitle extends StatelessWidget {
  const RequiredSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, maxLines: 1, style: Theme.of(context).textTheme.titleLarge),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEF9920).withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Text(
            "Required".toUpperCase(),
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: const Color(0xFFEF9920)),
          ),
        ),
      ],
    );
  }
}
