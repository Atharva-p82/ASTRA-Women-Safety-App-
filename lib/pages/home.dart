// {// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../providers/user_provider.dart';
// import '../providers/guardian_provider.dart';
// import '../providers/alert_provider.dart';
// import '../providers/theme_provider.dart';
// import '../widgets/animated_background.dart';
// import '../widgets/alert_mode_toggle.dart';
// import '../widgets/quick_actions_bar.dart';
// import '../widgets/i_am_guardian_section.dart';
// import '../layout/app_drawer.dart';
// import '../layout/app_header.dart';
// import '../widgets/sos_button.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final guardianProvider =
//           Provider.of<GuardianProvider>(context, listen: false);
//       guardianProvider.loadGuardians();
//       guardianProvider.loadIAmGuardianOf();
//     });
//   }

//   void _handleAlertPress(BuildContext context) {
//     try {
//       final alertProvider = Provider.of<AlertProvider>(context, listen: false);
//       alertProvider.triggerAlert();
//       alertProvider.confirmAlert();
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('SOS sent! Guardians notified.'),
//             backgroundColor: Colors.red.shade600,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Emergency alert sent successfully.'),
//             backgroundColor: Colors.red.shade600,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer3<GuardianProvider, ThemeProvider, AlertProvider>(
//       builder: (context, guardianProvider, themeProvider, alertProvider, _) {
//         final bool isAlert = alertProvider.isAlertModeOn == true;
//         return Scaffold(
//           drawer: AppDrawer(),
//           appBar: AppHeader(title: "Home"),
//           body: Stack(
//             children: [
//               AnimatedBackground(
//                 isDark: themeProvider.isDark,
//                 child: SafeArea(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(height: 10),
//                           Text(
//                             "Welcome, ${Provider.of<UserProvider>(context).userName ?? 'User'}",
//                             style: GoogleFonts.montserrat(
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                               color: themeProvider.isDark
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "Your safety is our priority",
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               color: themeProvider.isDark
//                                   ? Colors.grey.shade400
//                                   : Colors.grey.shade600,
//                             ),
//                           ),
//                           SizedBox(height: 32),
//                           SOSButton(
//                             onPressed: () => _handleAlertPress(context),
//                             isDark: themeProvider.isDark,
//                           ),
//                           SizedBox(height: 24),
//                           AlertModeToggle(),
//                           SizedBox(height: 24),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: EdgeInsets.symmetric(horizontal: 4),
//                             child: Text(
//                               "My Guardians",
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: themeProvider.isDark
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           guardianProvider.guardians.isEmpty
//                               ? Container(
//                                   padding: EdgeInsets.symmetric(vertical: 20),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     color: themeProvider.isDark
//                                         ? Colors.grey.shade900
//                                         : Colors.grey.shade100,
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "No guardians added yet",
//                                       style: TextStyle(
//                                         color: themeProvider.isDark
//                                             ? Colors.grey.shade400
//                                             : Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: NeverScrollableScrollPhysics(),
//                                   itemCount: guardianProvider.guardians.length.clamp(0, 2),
//                                   itemBuilder: (context, i) {
//                                     final guardian =
//                                         guardianProvider.guardians[i];
//                                     return Container(
//                                       margin: EdgeInsets.only(bottom: 8),
//                                       padding: EdgeInsets.all(12),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: themeProvider.isDark
//                                             ? Colors.grey.shade900
//                                             : Colors.white,
//                                         border: Border.all(
//                                           color: Colors.pink.shade200,
//                                           width: 1,
//                                         ),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           CircleAvatar(
//                                             backgroundColor: Colors.pink.shade200,
//                                             child: Text(
//                                               guardian.name[0].toUpperCase(),
//                                               style: TextStyle(
//                                                 color: Colors.pink.shade700,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(width: 12),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   guardian.name,
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: themeProvider.isDark
//                                                         ? Colors.white
//                                                         : Colors.black,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   guardian.phone,
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: themeProvider.isDark
//                                                         ? Colors.grey.shade400
//                                                         : Colors.grey.shade600,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           IconButton(
//                                             icon: Icon(Icons.edit, color: Colors.blue),
//                                             onPressed: () => Navigator.pushNamed(
//                                               context,
//                                               '/edit_guardian',
//                                               arguments: guardian,
//                                             ),
//                                           ),
//                                           IconButton(
//                                             icon: Icon(Icons.delete, color: Colors.red),
//                                             onPressed: () async {
//                                               try {
//                                                 await guardianProvider
//                                                     .deleteGuardian(guardian.id);
//                                                 if (mounted) {
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(SnackBar(
//                                                     content: Text(
//                                                         '${guardian.name} removed successfully'),
//                                                     backgroundColor: Colors.green,
//                                                   ));
//                                                 }
//                                               } catch (e) {
//                                                 if (mounted) {
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(SnackBar(
//                                                     content: Text(
//                                                         'Failed to remove guardian'),
//                                                     backgroundColor: Colors.red,
//                                                   ));
//                                                 }
//                                               }
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                           SizedBox(height: 24),
//                           IAmGuardianSection(),
//                           SizedBox(height: 24),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: EdgeInsets.symmetric(horizontal: 4),
//                             child: Text(
//                               "Quick Actions",
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: themeProvider.isDark
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           QuickActionsBar(),
//                           SizedBox(height: 24),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Red translucent overlay for alert mode
//               if (isAlert)
//                 IgnorePointer(
//                   child: AnimatedOpacity(
//                     opacity: 0.75,
//                     duration: Duration(milliseconds: 350),
//                     child: Container(
//                       color: Colors.red.withOpacity(0.45),
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                   ),
//                 )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/guardian_provider.dart';
import '../providers/alert_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/animated_background.dart';
import '../widgets/quick_actions_bar.dart';
import '../widgets/i_am_guardian_section.dart';
import '../widgets/empty_guardians_card.dart';
import '../widgets/guardian_card.dart';
import '../layout/app_drawer.dart';
import '../layout/app_header.dart';
import '../widgets/sos_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final guardianProvider =
          Provider.of<GuardianProvider>(context, listen: false);
      guardianProvider.loadGuardians();
    });
  }

  void _handleAlertPress(BuildContext context) {
    final alertProvider = Provider.of<AlertProvider>(context, listen: false);
    alertProvider.triggerAlert();
    alertProvider.confirmAlert();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SOS Alert Triggered'),
          backgroundColor: Colors.red.shade600,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<GuardianProvider, ThemeProvider, AlertProvider>(
      builder: (context, guardianProvider, themeProvider, alertProvider, _) {
        final bool isAlert = alertProvider.isAlertModeOn == true;
        
        return Scaffold(
          drawer: AppDrawer(),
          appBar: AppHeader(title: "Home"),
          body: Stack(
            children: [
              AnimatedBackground(
                isDark: themeProvider.isDark,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          
                          // Welcome Text
                          Text(
                            "Welcome, ${Provider.of<UserProvider>(context).userName ?? 'User'}",
                            style: GoogleFonts.montserrat(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          
                          SizedBox(height: 8),
                          
                          Text(
                            "Your safety is our priority",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: themeProvider.isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                          
                          SizedBox(height: 32),
                          
                          // SOS Button
                          SOSButton(
                            onPressed: () => _handleAlertPress(context),
                            isDark: themeProvider.isDark,
                          ),
                          
                          SizedBox(height: 32),
                          
                          // My Guardians Section
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              "My Guardians",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.isDark
                                    ? Colors.white
                                    : Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 16),
                          
                          // Guardians List or Empty State
                          guardianProvider.guardians.isEmpty
                              ? EmptyGuardiansCard(
                                  title: 'No Guardians Yet',
                                  message: 'Add trusted contacts who will be alerted in emergencies',
                                  icon: Icons.shield_outlined,
                                  onAddPressed: () {
                                    Navigator.pushNamed(context, '/add_guardian');
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: guardianProvider.guardians.length.clamp(0, 2),
                                  itemBuilder: (context, i) {
                                    final guardian = guardianProvider.guardians[i];
                                    return GuardianCard(
                                      guardian: guardian,
                                      onEdit: () => Navigator.pushNamed(
                                        context,
                                        '/edit_guardian',
                                        arguments: guardian,
                                      ),
                                      onDelete: () async {
                                        // Show confirmation dialog
                                        final confirmed = await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Remove Guardian'),
                                            content: Text(
                                              'Are you sure you want to remove ${guardian.name}?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, true),
                                                child: Text(
                                                  'Remove',
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirmed == true) {
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
                                          } catch (e) {
                                            if (mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Failed to remove guardian'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                          
                          SizedBox(height: 24),
                          
                          // I Am Guardian Of Section
                          IAmGuardianSection(),
                          
                          SizedBox(height: 24),
                          
                          // Quick Actions Section
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              "Quick Actions",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.isDark
                                    ? Colors.white
                                    : Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 16),
                          
                          QuickActionsBar(),
                          
                          SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Red translucent overlay for alert mode
              if (isAlert)
                IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: 0.75,
                    duration: Duration(milliseconds: 350),
                    child: Container(
                      color: Colors.red.withOpacity(0.45),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
