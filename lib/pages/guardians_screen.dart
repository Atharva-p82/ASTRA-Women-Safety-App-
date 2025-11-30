// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/guardian_provider.dart';
// import '../providers/theme_provider.dart';
// import '../layout/app_drawer.dart';
// import '../layout/app_header.dart';
// import '../widgets/animated_background.dart';

// class GuardiansScreen extends StatefulWidget {
//   const GuardiansScreen({super.key});

//   @override
//   State<GuardiansScreen> createState() => _GuardiansScreenState();
// }

// class _GuardiansScreenState extends State<GuardiansScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<GuardianProvider>(context, listen: false).loadGuardians();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<GuardianProvider, ThemeProvider>(
//       builder: (context, guardianProvider, themeProvider, _) {
//         return Scaffold(
//           drawer: AppDrawer(),
//           appBar: AppHeader(title: "My Guardians"),
//           body: AnimatedBackground(
//             isDark: themeProvider.isDark,
//             child: guardianProvider.guardians.isEmpty
//                 ? Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(24),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.group_add, size: 80, color: Colors.grey.shade300),
//                           SizedBox(height: 16),
//                           Text(
//                             "No guardians added yet.",
//                             style: TextStyle(
//                               color: themeProvider.isDark
//                                   ? Colors.grey.shade400
//                                   : Colors.grey.shade600,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "Add trusted contacts to keep you safe.",
//                             style: TextStyle(
//                               color: Colors.grey.shade500,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(height: 24),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.pink.shade400,
//                               foregroundColor: Colors.white,
//                             ),
//                             onPressed: () =>
//                                 Navigator.pushNamed(context, '/add_guardian'),
//                             child: Text("Add Your First Guardian"),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : RefreshIndicator(
//                     color: Colors.pink.shade400,
//                     onRefresh: () => guardianProvider.loadGuardians(),
//                     child: ListView.builder(
//                       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                       itemCount: guardianProvider.guardians.length,
//                       itemBuilder: (context, i) {
//                         final guardian = guardianProvider.guardians[i];
//                         return Card(
//                           margin: EdgeInsets.symmetric(vertical: 8),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 3,
//                           color: themeProvider.isDark
//                               ? Colors.grey.shade900
//                               : Colors.white,
//                           child: ListTile(
//                             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                             leading: CircleAvatar(
//                               radius: 22,
//                               backgroundColor: Colors.pink.shade100,
//                               child: Text(
//                                 guardian.name[0].toUpperCase(),
//                                 style: TextStyle(
//                                   color: Colors.pink.shade400,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 22,
//                                 ),
//                               ),
//                             ),
//                             title: Text(
//                               guardian.name,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                                 color: themeProvider.isDark
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                             subtitle: Text(
//                               guardian.phone,
//                               style: TextStyle(
//                                 color: Colors.grey.shade600,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.edit, color: Colors.blue),
//                                   tooltip: "Edit",
//                                   onPressed: () =>
//                                       Navigator.pushNamed(
//                                         context,
//                                         '/edit_guardian',
//                                         arguments: guardian,
//                                       ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   tooltip: "Delete",
//                                   onPressed: () async {
//                                     try {
//                                       await guardianProvider.deleteGuardian(guardian.id);
//                                       if (mounted) {
//                                         ScaffoldMessenger.of(context).showSnackBar(
//                                           SnackBar(
//                                             content: Text('${guardian.name} removed successfully'),
//                                             backgroundColor: Colors.green,
//                                           ),
//                                         );
//                                       }
//                                     } catch (e) {
//                                       if (mounted) {
//                                         ScaffoldMessenger.of(context).showSnackBar(
//                                           SnackBar(
//                                             content: Text('Failed to remove guardian'),
//                                             backgroundColor: Colors.red,
//                                           ),
//                                         );
//                                       }
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () => Navigator.pushNamed(context, '/add_guardian'),
//             backgroundColor: Colors.pink.shade400,
//             child: Icon(Icons.add, color: Colors.white),
//           ),
//         );
//       },
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/guardian_provider.dart';
import '../providers/user_provider.dart';
import '../providers/theme_provider.dart';
import '../layout/app_drawer.dart';
import '../layout/app_header.dart';
import '../widgets/animated_background.dart';

class GuardiansScreen extends StatefulWidget {
  const GuardiansScreen({super.key});

  @override
  State<GuardiansScreen> createState() => _GuardiansScreenState();
}

class _GuardiansScreenState extends State<GuardiansScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load guardians for the currently authenticated user (if available)
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      Provider.of<GuardianProvider>(context, listen: false)
          .loadGuardians(userId: userProvider.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GuardianProvider, ThemeProvider>(
      builder: (context, guardianProvider, themeProvider, _) {
        return Scaffold(
          drawer: AppDrawer(),
          appBar: AppHeader(title: "My Guardians"),
          body: AnimatedBackground(
            isDark: themeProvider.isDark,
            child: guardianProvider.guardians.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group_add, size: 80, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          Text(
                            "No guardians added yet.",
                            style: TextStyle(
                              color: themeProvider.isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Add trusted contacts to keep you safe.",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade400,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, '/add_guardian'),
                            child: const Text("Add Your First Guardian"),
                          ),
                        ],
                      ),
                    ),
                  )
                : RefreshIndicator(
                    color: Colors.pink.shade400,
                    onRefresh: () => guardianProvider.loadGuardians(),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      itemCount: guardianProvider.guardians.length,
                      itemBuilder: (context, i) {
                        final guardian = guardianProvider.guardians[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          color: themeProvider.isDark
                              ? Colors.grey.shade900
                              : Colors.white,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.pink.shade100,
                              child: Text(
                                guardian.name[0].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            title: Text(
                              guardian.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: themeProvider.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              guardian.phone,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/edit_guardian', arguments: guardian),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    try {
                                      await guardianProvider.deleteGuardian(guardian.id);
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${guardian.name} removed successfully'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    } catch (_) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Failed to remove guardian'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/add_guardian'),
            backgroundColor: Colors.pink.shade400,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}
