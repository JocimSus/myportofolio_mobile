import 'package:material_ui/material_ui.dart';
import 'package:portfolio_mobile/screens/login.dart';
import 'package:portfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

/// Ensures the user is authenticated, pushing [LoginScreen] when needed.
Future<bool> ensureLoggedIn(BuildContext context) async {
  if (context.read<AuthState>().isLoggedIn) {
    return true;
  } else {
    final loggedIn = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    return loggedIn ?? false;
  }
}
