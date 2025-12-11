import 'package:flutter/material.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/string_utils.dart';

/// Profile card widget displaying user information
class ProfileCardWidget extends StatelessWidget {
  final UserProfile? currentUser;
  final bool isActuallyAnonymous;

  const ProfileCardWidget({
    super.key,
    required this.currentUser,
    required this.isActuallyAnonymous,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
        child: Builder(
          builder: (context) {
            final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
            final textColor = isDarkTheme ? Colors.white : Colors.black;
            final subtitleColor = isDarkTheme ? Colors.white70 : Colors.black87;
            final avatarBgColor = isDarkTheme
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.1);
            final badgeBgColor = isDarkTheme
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.1);
            final badgeBorderColor = isDarkTheme
                ? Colors.white.withOpacity(0.3)
                : Colors.black.withOpacity(0.2);

            return Column(
              children: [
                // Profile Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: avatarBgColor,
                  child: Text(
                    isActuallyAnonymous
                        ? 'M'
                        : StringUtils.getInitials(currentUser?.name ?? 'U'),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // User Info
                Text(
                  isActuallyAnonymous
                      ? 'Misafir Kullanıcı'
                      : currentUser?.name ?? 'Kullanıcı',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                if (!isActuallyAnonymous && currentUser?.email != null)
                  Text(
                    currentUser?.email ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: subtitleColor,
                    ),
                  ),
                const SizedBox(height: 16),
                // Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: badgeBorderColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        color: textColor,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isActuallyAnonymous ? 'Misafir' : 'Aktif Üye',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
