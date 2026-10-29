
import 'package:flutter/material.dart';

void main() {
  runApp(const NebulaApp());
}

const bg = Color(0xFF080A12);
const purple = Color(0xFF895CFF);
const blue = Color(0xFF38CFFF);

class NebulaApp extends StatelessWidget {
  const NebulaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEBULA MOUSE PRO',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  String profile = 'Free Fire';

  final List<Map<String, String>> keys = [
    {'key': 'W', 'action': 'Move Forward'},
    {'key': 'A', 'action': 'Move Left'},
    {'key': 'S', 'action': 'Move Backward'},
    {'key': 'D', 'action': 'Move Right'},
    {'key': 'SPACE', 'action': 'Jump'},
    {'key': 'E', 'action': 'Interact'},
  ];

  void addKey() {
    final keyInput = TextEditingController();
    final actionInput = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Key Mapping'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyInput,
              decoration: const InputDecoration(
                labelText: 'Keyboard key',
                hintText: 'Q',
              ),
            ),
            TextField(
              controller: actionInput,
              decoration: const InputDecoration(
                labelText: 'Action name',
                hintText: 'Skill',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (keyInput.text.trim().isEmpty ||
                  actionInput.text.trim().isEmpty) {
                return;
              }
              setState(() {
                keys.add({
                  'key': keyInput.text.trim().toUpperCase(),
                  'action': actionInput.text.trim(),
                });
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NEBULA MOUSE PRO',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            fontSize: 18,
          ),
        ),
        leading: const Icon(Icons.blur_on, color: blue, size: 30),
      ),
      body: IndexedStack(
        index: tab,
        children: [
          dashboard(),
          editor(),
          settings(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) {
          setState(() => tab = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.keyboard_alt_outlined),
            label: 'Mapping',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget dashboard() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF352064), Color(0xFF102A46)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: purple),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.mouse, size: 48, color: blue),
              SizedBox(height: 20),
              Text(
                'PLAY BEYOND LIMITS',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8),
              Text('Your gaming controls, your way.'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'DEVICE STATUS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.usb, color: blue, size: 32),
            title: Text('USB / OTG'),
            subtitle: Text('Device detection not implemented yet'),
            trailing: Icon(Icons.info_outline),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'GAME PROFILE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: profile,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(
              value: 'Free Fire',
              child: Text('Free Fire'),
            ),
            DropdownMenuItem(
              value: 'Mobile Legends',
              child: Text('Mobile Legends'),
            ),
            DropdownMenuItem(
              value: 'Roblox',
              child: Text('Roblox'),
            ),
            DropdownMenuItem(
              value: 'Custom',
              child: Text('Custom Profile'),
            ),
          ],
          onChanged: (value) {
            if (value != null) setState(() => profile = value);
          },
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: () => setState(() => tab = 1),
          icon: const Icon(Icons.tune),
          label: const Padding(
            padding: EdgeInsets.all(14),
            child: Text('OPEN KEYMAPPING'),
          ),
        ),
      ],
    );
  }

  Widget editor() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'KEYMAPPING EDITOR',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        Text('Profile: $profile', style: const TextStyle(color: blue)),
        const SizedBox(height: 20),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFF131827),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: purple),
          ),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.gamepad, size: 50, color: purple),
                SizedBox(height: 10),
                Text('MAPPING PREVIEW'),
                Text(
                  'Configuration preview only',
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(
              child: Text(
                'BUTTON MAPPINGS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton.filled(
              onPressed: addKey,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        ...keys.map(
          (item) => Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF352064),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(item['key']!),
                  ),
                ),
              ),
              title: Text(item['action']!),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() => keys.remove(item));
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Catatan: mapping di versi ini belum mengirim input ke game.',
          style: TextStyle(color: Colors.white54),
        ),
      ],
    );
  }

  Widget settings() {
    return const ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          'SETTINGS',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Icon(Icons.palette_outlined, color: blue),
            title: Text('Nebula Dark Theme'),
            subtitle: Text('Purple • Blue • Black'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.info_outline, color: blue),
            title: Text('About NEBULA MOUSE PRO'),
            subtitle: Text('Version 1.0.0'),
          ),
        ),
      ],
    );
  }
}
