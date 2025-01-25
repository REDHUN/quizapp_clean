import 'package:flutter/material.dart';

import 'shimmer_widget.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          floating: true,
          title: ShimmerWidget.rectangular(height: 30, width: 120),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildWelcomeSectionShimmer(),
              const SizedBox(height: 24),
              _buildQuickActionsShimmer(),
              const SizedBox(height: 24),
              _buildPopularQuizzesShimmer(),
              const SizedBox(height: 24),
              _buildLeaderboardShimmer(),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSectionShimmer() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ShimmerWidget.circular(
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerWidget.rectangular(
                    width: 150,
                    height: 24,
                  ),
                  SizedBox(height: 8),
                  ShimmerWidget.rectangular(
                    width: 100,
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: const [
              Expanded(
                child: ShimmerWidget.rectangular(
                  height: 60,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ShimmerWidget.rectangular(
                  height: 60,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsShimmer() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: List.generate(
        4,
        (index) => const ShimmerWidget.rectangular(
          height: 120,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildPopularQuizzesShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerWidget.rectangular(
          width: 150,
          height: 24,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => Container(
              width: 160,
              margin: const EdgeInsets.only(right: 16),
              child: const ShimmerWidget.rectangular(
                height: 200,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerWidget.rectangular(
          width: 120,
          height: 24,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    ShimmerWidget.circular(
                      width: 45,
                      height: 45,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ShimmerWidget.rectangular(
                        height: 20,
                      ),
                    ),
                    SizedBox(width: 16),
                    ShimmerWidget.rectangular(
                      width: 60,
                      height: 30,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
