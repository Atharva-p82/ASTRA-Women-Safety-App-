import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../models/guardian.dart';

class GuardianCard extends StatefulWidget {
  final Guardian guardian;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;

  const GuardianCard({
    super.key,
    required this.guardian,
    this.onEdit,
    this.onDelete,
    this.showActions = true,
  });

  @override
  State<GuardianCard> createState() => _GuardianCardState();
}

class _GuardianCardState extends State<GuardianCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDark = themeProvider.isDark;
        
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [Colors.grey.shade900, Colors.grey.shade50]
                    : [Colors.white, Colors.pink.shade50.withOpacity(0.4)],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _isHovering
                    ? (isDark ? Colors.pink.shade600 : Colors.pink.shade300)
                    : (isDark
                        ? Colors.grey.shade700.withOpacity(0.4)
                        : Colors.pink.shade200.withOpacity(0.6)),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovering
                      ? Colors.pink.shade200.withOpacity(0.4)
                      : (isDark
                          ? Colors.black.withOpacity(0.2)
                          : Colors.pink.shade100.withOpacity(0.2)),
                  blurRadius: _isHovering ? 12 : 8,
                  offset: Offset(0, _isHovering ? 4 : 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Avatar with gradient - larger and more prominent
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [Colors.pink.shade700, Colors.purple.shade900]
                            : [Colors.pink.shade400, Colors.purple.shade500],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade300.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        widget.guardian.name[0].toUpperCase(),
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 18),
                  
                  // Guardian info - expanded section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name with better typography
                        Text(
                          widget.guardian.name,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: isDark ? Colors.grey.shade100 : Colors.grey.shade900,
                            letterSpacing: 0.3,
                          ),
                        ),
                        
                        SizedBox(height: 6),
                        
                        // Phone with icon and styled background
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.green.shade900.withOpacity(0.25)
                                : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark
                                  ? Colors.green.shade700.withOpacity(0.3)
                                  : Colors.green.shade200,
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.phone,
                                size: 13,
                                color: isDark ? Colors.green.shade400 : Colors.green.shade700,
                              ),
                              SizedBox(width: 6),
                              Text(
                                widget.guardian.phone,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.green.shade300 : Colors.green.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(width: 12),
                  
                  // Action buttons - beautiful styled
                  if (widget.showActions)
                    Row(
                      children: [
                        // Edit button
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.blue.shade900.withOpacity(0.2)
                                : Colors.blue.shade50,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? Colors.blue.shade700.withOpacity(0.3)
                                  : Colors.blue.shade200,
                              width: 0.8,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: widget.onEdit,
                              customBorder: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 8),
                        
                        // Delete button
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.red.shade900.withOpacity(0.2)
                                : Colors.red.shade50,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? Colors.red.shade700.withOpacity(0.3)
                                  : Colors.red.shade200,
                              width: 0.8,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: widget.onDelete,
                              customBorder: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.delete_outline,
                                  color: isDark ? Colors.red.shade300 : Colors.red.shade700,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
