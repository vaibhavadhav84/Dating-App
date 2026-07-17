// lib/features/date_planning/presentation/pages/date_planning_page.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/primary_button.dart';

class DatePlanningPage extends StatefulWidget {
  const DatePlanningPage({super.key});

  @override
  State<DatePlanningPage> createState() => _DatePlanningPageState();
}

class _DatePlanningPageState extends State<DatePlanningPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<_VenueItem> _restaurants = [
    _VenueItem(name: 'La Bella Italia', cuisine: 'Italian', rating: 4.8, distance: '0.8 km', imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200'),
    _VenueItem(name: 'Sakura Garden', cuisine: 'Japanese', rating: 4.6, distance: '1.2 km', imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200'),
    _VenueItem(name: 'The Rooftop', cuisine: 'International', rating: 4.9, distance: '2.0 km', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=200'),
    _VenueItem(name: 'Spice Route', cuisine: 'Indian', rating: 4.5, distance: '1.5 km', imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200'),
  ];

  static const List<_VenueItem> _activities = [
    _VenueItem(name: 'Sunset Kayaking', cuisine: 'Outdoor', rating: 4.9, distance: '3.0 km', imageUrl: 'https://images.unsplash.com/photo-1526492839500-3e59d2a83c5a?w=200'),
    _VenueItem(name: 'Pottery Class', cuisine: 'Art', rating: 4.7, distance: '1.8 km', imageUrl: 'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=200'),
    _VenueItem(name: 'Salsa Night', cuisine: 'Dance', rating: 4.8, distance: '2.2 km', imageUrl: 'https://images.unsplash.com/photo-1545959570-a94084071b5d?w=200'),
    _VenueItem(name: 'Rock Climbing', cuisine: 'Sport', rating: 4.6, distance: '4.1 km', imageUrl: 'https://images.unsplash.com/photo-1522163182402-834f871fd851?w=200'),
  ];

  static const List<_VenueItem> _coffeeShops = [
    _VenueItem(name: 'Artisan Brew', cuisine: 'Specialty Coffee', rating: 4.9, distance: '0.3 km', imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=200'),
    _VenueItem(name: 'Blue Bottle', cuisine: 'Coffee', rating: 4.7, distance: '0.9 km', imageUrl: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=200'),
    _VenueItem(name: 'The Study', cuisine: 'Café', rating: 4.8, distance: '1.1 km', imageUrl: 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=200'),
    _VenueItem(name: 'Morning Ritual', cuisine: 'Coffee & Brunch', rating: 4.6, distance: '1.6 km', imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=200'),
  ];

  static const List<_VenueItem> _movies = [
    _VenueItem(name: 'Cinépolis IMAX', cuisine: 'Action / Sci-Fi', rating: 4.8, distance: '2.3 km', imageUrl: 'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=200'),
    _VenueItem(name: 'AMC Classic', cuisine: 'Romance / Drama', rating: 4.5, distance: '1.7 km', imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=200'),
    _VenueItem(name: 'Alamo Drafthouse', cuisine: 'Comedy', rating: 4.9, distance: '3.1 km', imageUrl: 'https://images.unsplash.com/photo-1542204165-65bf26472b9b?w=200'),
    _VenueItem(name: 'Drive-In Cinema', cuisine: 'All Genres', rating: 4.7, distance: '5.0 km', imageUrl: 'https://images.unsplash.com/photo-1534684686641-05569203ecca?w=200'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: AppConstants.dateCategories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<_VenueItem> _getItems(int tabIndex) {
    return switch (tabIndex) {
      0 => _restaurants,
      1 => _activities,
      2 => _coffeeShops,
      _ => _movies,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Plan a Date', style: AppTextStyles.headingSmall),
        backgroundColor: AppColors.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: AppTextStyles.labelMedium
              .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary),
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          tabs: AppConstants.dateCategories
              .map((c) => Tab(text: c))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          AppConstants.dateCategories.length,
          (tabIndex) => _VenueList(items: _getItems(tabIndex)),
        ),
      ),
    );
  }
}

class _VenueList extends StatelessWidget {
  final List<_VenueItem> items;
  const _VenueList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) => _VenueCard(item: items[index]),
    );
  }
}

class _VenueCard extends StatelessWidget {
  final _VenueItem item;
  const _VenueCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [AppColors.pinkShadow],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              item.imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (context, e, s) => Container(
                width: 110,
                height: 110,
                color: AppColors.secondary,
                child:
                    const Icon(Icons.restaurant, color: AppColors.primary, size: 36),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: AppTextStyles.labelLarge,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(item.cuisine,
                    style: AppTextStyles.bodySmall,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFFFA726), size: 16),
                    const SizedBox(width: 4),
                    Text('${item.rating}',
                        style: AppTextStyles.labelMedium.copyWith(
                            fontWeight: FontWeight.w600)),
                    const SizedBox(width: 10),
                    const Icon(Icons.location_on_rounded,
                        color: AppColors.primary, size: 14),
                    const SizedBox(width: 2),
                    Text(item.distance,
                        style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  label: 'Book Now',
                  height: 36,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => _DateBookingSheet(item: item),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateBookingSheet extends StatefulWidget {
  final _VenueItem item;
  const _DateBookingSheet({required this.item});

  @override
  State<_DateBookingSheet> createState() => _DateBookingSheetState();
}

class _DateBookingSheetState extends State<_DateBookingSheet> {
  String _selectedDate = 'Today';
  String _selectedTime = '8:30 PM';
  String _selectedCompanion = 'Aanya';

  final List<String> _dates = ['Today', 'Tomorrow', 'Saturday', 'Sunday'];
  final List<String> _times = ['6:00 PM', '7:30 PM', '8:30 PM', '9:30 PM'];
  final List<Map<String, String>> _companions = [
    {'name': 'Aanya', 'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80'},
    {'name': 'Elena', 'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80'},
    {'name': 'Riya', 'avatar': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80'},
    {'name': 'Neha', 'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Plan a Date Night',
            style: AppTextStyles.headingSmall.copyWith(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          const SizedBox(height: 2),
          Text(
            'Invite someone special to ${widget.item.name}',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          Text(
            'SELECT COMPANION',
            style: AppTextStyles.labelSmall.copyWith(color: Colors.black45, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 72,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _companions.length,
              itemBuilder: (context, index) {
                final companion = _companions[index];
                final isSelected = _selectedCompanion == companion['name'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCompanion = companion['name']!),
                  child: Container(
                    margin: const EdgeInsets.only(right: 14),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(companion['avatar']!),
                            ),
                            if (isSelected)
                              Positioned(
                                bottom: -2,
                                right: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.check, color: Colors.white, size: 10),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          companion['name']!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? AppColors.primary : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'SELECT DATE',
            style: AppTextStyles.labelSmall.copyWith(color: Colors.black45, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _dates.map((d) {
              final isSelected = _selectedDate == d;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDate = d),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        d,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text(
            'SELECT TIME',
            style: AppTextStyles.labelSmall.copyWith(color: Colors.black45, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _times.map((t) {
              final isSelected = _selectedTime == t;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTime = t),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        t,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              _showConfirmationDialog(context);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  'Send Date Invite',
                  style: const TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 48),
            ),
            const SizedBox(height: 20),
            const Text(
              'Date Invite Sent! 📅',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Your request to meet $_selectedCompanion at ${widget.item.name} on $_selectedDate, $_selectedTime has been sent.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Great!', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class _VenueItem {
  final String name;
  final String cuisine;
  final double rating;
  final String distance;
  final String imageUrl;

  const _VenueItem({
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.distance,
    required this.imageUrl,
  });
}
