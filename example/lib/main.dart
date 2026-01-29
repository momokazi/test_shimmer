import 'package:flutter/material.dart';
import 'package:reusable_shimmer/reusable_shimmer.dart';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: ShimmerExample()),
);

class ShimmerExample extends StatefulWidget {
  const ShimmerExample({super.key});

  @override
  State<ShimmerExample> createState() => _ShimmerExampleState();
}

class _ShimmerExampleState extends State<ShimmerExample> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reusable Shimmer'),
        actions: [
          Row(
            children: [
              const Text('Loading'),
              Switch(
                value: loading,
                onChanged: (v) => setState(() => loading = v),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Basic Text'),
          const Text(
            'Hello World',
          ).toShimmer(loading: loading, width: 100, height: 16),

          _sectionTitle('Circle Avatar'),
          const CircleAvatar(radius: 30).toShimmer(
            loading: loading,
            width: 60,
            height: 60,
            decoration: const BoxDecoration(shape: BoxShape.circle),
          ),

          _sectionTitle('List Tile (Complex)'),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('User Name'),
            subtitle: const Text('user@example.com'),
          ).toShimmer(
            loading: loading,
            width: double.infinity,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  Colors.white, // Need a base color for the skeleton container
            ),
          ),

          _sectionTitle('Skeleton Widget Direct Usage'),
          if (loading)
            const Row(
              children: [
                Skeleton(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                ),
                SizedBox(width: 10),
                Expanded(child: Skeleton(height: 20)),
              ],
            )
          else
            const Row(
              children: [
                Icon(Icons.check_circle, size: 50, color: Colors.green),
                SizedBox(width: 10),
                Text('Loaded Content'),
              ],
            ),

          _sectionTitle('Image Network Test'),
          Image.network(
            'https://picsum.photos/seed/ai/600/400',
            fit: BoxFit.cover,
          ).toShimmer(
            loading: loading,
            width: 280,
            height: 160,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          ),

          _sectionTitle('Grid of Images'),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.blue[100],
                child: const Center(child: Icon(Icons.image)),
              ).toShimmer(
                loading: loading,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
