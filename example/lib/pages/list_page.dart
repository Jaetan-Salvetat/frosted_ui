import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          FrostedSliverAppBar(
            expandedHeight: 180,
            pinned: true,
            floating: true,
            title: 'Exemple de Liste',
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
                tooltip: "Rechercher",
              ),
            ],
          ),

          // Liste d'éléments
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text('Élément ${index + 1}'),
                  subtitle: Text('Description de l\'élément ${index + 1}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  onTap: () {},
                );
              }, childCount: 30),
            ),
          ),
        ],
      ),
    );
  }
}
