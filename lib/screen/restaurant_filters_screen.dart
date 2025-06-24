import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Filters"),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Categories(),
              SizedBox(height: 16),
              Dietaries(),
              SizedBox(height: 16),
              PriceRange(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class Dietaries extends StatefulWidget {
  const Dietaries({super.key});

  @override
  State<Dietaries> createState() => _DietariesState();
}

class _DietariesState extends State<Dietaries> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: "Dietary",
          // When press the clean all
          press: () {},
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 10,
            children: List.generate(
              demoDietaries.length,
                  (index) => ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(56, 40),
                  backgroundColor: index == 1
                      ? const Color(0xFF22A45D)
                      : const Color(0xFF868686),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(demoDietaries[index]["title"]),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Map<String, dynamic>> demoDietaries = [
    {"title": "Any", "isActive": false},
    {"title": "Vegetarian", "isActive": false},
    {"title": "Vegan", "isActive": false},
    {"title": "Gluten-Free", "isActive": false},
  ];
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: "Categories",
          press: () {},
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            children: List.generate(
              demoCategories.length,
                  (index) => ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(56, 40),
                  backgroundColor: index == 2
                      ? const Color(0xFF22A45D)
                      : const Color(0xFF868686),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(demoCategories[index]["title"]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.press,
  });

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          GestureDetector(
            onTap: press,
            child: Text(
              "Clear all".toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF010F07).withOpacity(0.64),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Demo data categories
List<Map<String, dynamic>> demoCategories = [
  {"title": "All", "isActive": false},
  {"title": "Brunch", "isActive": false},
  {"title": "Dinner", "isActive": false},
  {"title": "Burgers", "isActive": true},
  {"title": "Chinese", "isActive": false},
  {"title": "Pizza", "isActive": false},
  {"title": "Salads", "isActive": false},
  {"title": "Soups", "isActive": false},
  {"title": "Breakfast", "isActive": false},
];

class PriceRange extends StatelessWidget {
  const PriceRange({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: "Price Range",
          press: () {},
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 16),
              ...List.generate(
                // For demo i'm using length 5
                5, // Price limit
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: RoundedButton(
                    index: index,
                    isActive: index == 2, // for demo just select 3rd item
                    press: () {},
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.isActive = false,
    required this.index,
    required this.press,
  });

  final bool isActive;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: isActive ? const Color(0xFF22A45D) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(
                color: isActive
                    ? const Color(0xFF22A45D)
                    : const Color(0xFF868686).withOpacity(0.1)),
          ),
        ),
        onPressed: press,
        child: Text(
          "\$" * (index + 1),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: isActive ? Colors.white : const Color(0xFF010F07),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
