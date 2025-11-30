// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../providers/guardian_provider.dart';
// import '../providers/theme_provider.dart';

// class IAmGuardianSection extends StatelessWidget {
//   const IAmGuardianSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<GuardianProvider, ThemeProvider>(
//       builder: (context, guardianProvider, themeProvider, _) {
//         final guardiansFor = guardianProvider.IAmGuardianOf;

//         return Container(
//           margin: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'I Am Guardian Of',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color:
//                       themeProvider.isDark ? Colors.white : Colors.black,
//                 ),
//               ),
//               SizedBox(height: 12),
//               if (guardiansFor.isEmpty)
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: themeProvider.isDark
//                         ? Colors.grey.shade900
//                         : Colors.grey.shade100,
//                   ),
//                   child: Center(
//                     child: Text(
//                       'No one yet',
//                       style: TextStyle(
//                         color: themeProvider.isDark
//                             ? Colors.grey.shade400
//                             : Colors.grey.shade600,
//                       ),
//                     ),
//                   ),
//                 )
//               else
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: guardiansFor.length.clamp(0, 2),
//                   itemBuilder: (context, index) {
//                     final person = guardiansFor[index];
//                     return Container(
//                       margin: EdgeInsets.only(bottom: 8),
//                       padding: EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: themeProvider.isDark
//                             ? Colors.grey.shade900
//                             : Colors.white,
//                         border: Border.all(
//                           color: Colors.purple.shade200,
//                           width: 1,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.purple.shade200,
//                             child: Text(
//                               person.name[0].toUpperCase(),
//                               style: TextStyle(
//                                 color: Colors.purple.shade700,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   person.name,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: themeProvider.isDark
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                 ),
//                                 if (person.phone.isNotEmpty)
//                                   Text(
//                                     person.phone,
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: themeProvider.isDark
//                                           ? Colors.grey.shade400
//                                           : Colors.grey.shade600,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class IAmGuardianSection extends StatelessWidget {
  const IAmGuardianSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Since "IAmGuardianOf" is not implemented, we use an empty list as placeholder
    final List guardiansFor = [];

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I Am Guardian Of',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              if (guardiansFor.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: themeProvider.isDark
                        ? Colors.grey.shade900
                        : Colors.grey.shade100,
                  ),
                  child: Center(
                    child: Text(
                      'No one yet',
                      style: TextStyle(
                        color: themeProvider.isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: guardiansFor.length.clamp(0, 2),
                  itemBuilder: (context, index) {
                    final person = guardiansFor[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: themeProvider.isDark
                            ? Colors.grey.shade900
                            : Colors.white,
                        border: Border.all(
                          color: Colors.purple.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.purple.shade200,
                            child: Text(
                              person.name[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: themeProvider.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                if (person.phone.isNotEmpty)
                                  Text(
                                    person.phone,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: themeProvider.isDark
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
