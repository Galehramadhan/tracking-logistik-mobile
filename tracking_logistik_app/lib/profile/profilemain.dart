import 'package:flutter/material.dart';

import 'package:tracking_logistik_app/profile/detail_profile.dart';
import 'kendaraan.dart';
import 'dokumen.dart';
import 'notifikasi.dart';
import 'bantuan.dart';
import 'tentang.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            //================ HEADER =================//

            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              decoration: const BoxDecoration(
                color: Color(0xff0A57D7),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              "Profil Admin",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        "assets/images/profile.png",
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Budi Santoso",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          "ID Admin",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        "ADMN00125",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "0812 3456 7890",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "budi@email.com",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            //================ MENU =================//

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          profileMenu(
                            context,
                            Icons.person_outline,
                            "Informasi Admin",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const DriverDetailPage(),
                                ),
                              );
                            },
                          ),

                          profileMenu(
                            context,
                            Icons.local_shipping_outlined,
                            "Kendaraan",
                            trailing: "B 1234 ABC",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const KendaraanPage(),
                                ),
                              );
                            },
                          ),

                          profileMenu(
                            context,
                            Icons.description_outlined,
                            "Dokumen",
                            trailing: "SIM / STNK",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const DokumenPage(),
                                ),
                              );
                            },
                          ),

                          profileMenu(
                            context,
                            Icons.notifications_none,
                            "Pengaturan Notifikasi",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const NotifikasiPage(),
                                ),
                              );
                            },
                          ),

                          profileMenu(
                            context,
                            Icons.help_outline,
                            "Bantuan",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const BantuanPage(),
                                ),
                              );
                            },
                          ),

                          profileMenu(
                            context,
                            Icons.info_outline,
                            "Tentang Aplikasi",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const TentangAplikasiPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                        
                          // TODO: Logout
                        },

                        icon: const Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        label: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          side: const BorderSide(
                            color: Colors.red,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileMenu(
    BuildContext context,
    IconData icon,
    String title, {
    String? trailing,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: Colors.blue,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailing != null)
                Text(
                  trailing,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(width: 5),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}