import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FrostedScaffold(
      appBar: FrostedAppBar(title: 'Composants Frosted UI'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            const SectionTitle(title: 'Boutons Standard'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FrostedElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                FrostedTextButton(onPressed: () {}, child: const Text('Text')),
                FrostedOutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const SectionTitle(title: 'Boutons avec Icônes'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FrostedElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier'),
                ),
                FrostedTextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  label: const Text('Favoris'),
                ),
                FrostedOutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter'),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const SectionTitle(title: 'Contrôles'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(4, (index) {
                return FrostedControlButton(
                  text: '${index + 1}',
                  onPressed: () {},
                );
              }),
            ),

            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FrostedIconButton(icon: Icons.settings, onPressed: () {}),
                FrostedIconButton(
                  icon: Icons.favorite,
                  onPressed: () {},
                  backgroundColor: Colors.pink.withOpacity(0.1),
                  color: Colors.pink,
                ),
                FrostedIconButton(
                  icon: Icons.edit,
                  onPressed: () {},
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 32),
            const SectionTitle(title: 'Boutons Menu'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FrostedMenuButton(label: 'Standard', onPressed: () {}),
                FrostedMenuButton(
                  label: 'Sélectionné',
                  onPressed: () {},
                  isSelected: true,
                ),
                FrostedMenuButton(
                  icon: Icons.edit,
                  label: 'Étiquette',
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),
            const SectionTitle(title: 'Actions Flottantes'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FrostedFloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  child: const Icon(Icons.add),
                ),
                FrostedFloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.edit),
                ),
                FrostedFloatingActionButton.extended(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Créer'),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const SectionTitle(title: 'Dialogues'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FrostedElevatedButton(
                  onPressed: () {
                    FrostedDialog.show(
                      context: context,
                      title: const Text('Confirmation'),
                      content: const Text(
                          'Voulez-vous vraiment effectuer cette action ?'),
                      actions: [
                        FrostedTextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                        FrostedElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Confirmer'),
                        ),
                      ],
                    );
                  },
                  child: const Text('Ouvrir Dialogue'),
                ),
                FrostedElevatedButton(
                  onPressed: () {
                    FrostedDialog.show(
                      context: context,
                      title: const Text('Information'),
                      content: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Voici quelques informations importantes :'),
                          SizedBox(height: 12),
                          Text('• Premier point d\'information'),
                          Text('• Deuxième point d\'information'),
                          Text('• Troisième point d\'information'),
                        ],
                      ),
                      actions: [
                        FrostedElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Compris'),
                        ),
                      ],
                    );
                  },
                  child: const Text('Dialogue Info'),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            const SectionTitle(title: 'Bottom Sheets'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FrostedElevatedButton(
                  onPressed: () {
                    FrostedBottomSheet.show(
                      context: context,
                      title: 'Paramètres',
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.dark_mode),
                            title: const Text('Thème sombre'),
                            trailing: Switch(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.notifications),
                            title: const Text('Notifications'),
                            trailing: Switch(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(height: 16),
                          FrostedElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Fermer'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Bottom Sheet Simple'),
                ),
                FrostedElevatedButton(
                  onPressed: () {
                    FrostedBottomSheet.show(
                      context: context,
                      title: 'Choisir une option',
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 5,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.circle, color: Colors.primaries[index]),
                            title: Text('Option ${index + 1}'),
                            subtitle: Text('Description de l\'option ${index + 1}'),
                            onTap: () => Navigator.pop(context, index),
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Bottom Sheet Liste'),
                ),
              ],
            ),
            
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
