import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 25,
        leading: const SizedBox(),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B263B), Color(0xFF415A77)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/pp_beast.jpg"),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "woi",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "MR BEASSSSTTTTTT",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30),
                // Welcome text
                const Text(
                  "Welcome to",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                const Text(
                  "QR Scanner & Generator",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                // Feature buttons
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      BuildButton(
                        icon: Icons.qr_code_2,
                        label: "Create",
                        iconColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 52, 192, 187),
                        onTap: () {
                          Navigator.pushNamed(context, '/create');
                        },
                      ),
                      BuildButton(
                        icon: Icons.qr_code_scanner,
                        label: "Scan",
                        iconColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 139, 126, 194),
                        onTap: () {
                          Navigator.pushNamed(context, '/scan');
                        },
                      ),
                      BuildButton(
                        icon: Icons.send_rounded,
                        label: "Send",
                        iconColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 172, 25, 191),
                        onTap: () {},
                      ),
                      BuildButton(
                        icon: Icons.print,
                        label: "Print",
                        iconColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 67, 188, 58),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildButton extends StatelessWidget {
  const BuildButton({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              backgroundColor,
              backgroundColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 50,
            ),
            const SizedBox(height: 15),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
