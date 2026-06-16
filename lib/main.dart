import 'package:flutter/material.dart';

void main() => runApp(const GigiApp());

class GigiApp extends StatelessWidget {
  const GigiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gigi Tasks',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 0.0;
  final List<Map> tasks = [
    {"title": "Quick Survey: Phone Brand", "pay": 35, "time": "2 min"},
    {"title": "Tag 8 product photos", "pay": 50, "time": "4 min"},
    {"title": "Listen + Type 30sec audio", "pay": 75, "time": "6 min"},
  ];

  void completeTask(int pay) {
    setState(() => balance += pay);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('+$pay KES! New balance: $balance KES'), duration: Duration(seconds: 2))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gigi Tasks - Work From Home')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Colors.green[100],
            child: Column(
              children: [
                const Text('Your Wallet', style: TextStyle(fontSize: 16)),
                Text('$balance KES', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, i) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.task_alt, color: Colors.green),
                  title: Text(tasks[i]['title']),
                  subtitle: Text('Est: ${tasks[i]['time']}'),
                  trailing: ElevatedButton(
                    onPressed: () => completeTask(tasks[i]['pay']),
                    child: Text('${tasks[i]['pay']} KES'),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('M-Pesa withdraw unlocks in v2 with Daraja API'))
              ),
              icon: const Icon(Icons.monetization_on),
              label: const Text('Withdraw to M-Pesa', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(55), backgroundColor: Colors.green),
            ),
          )
        ],
      ),
    );
  }
}
