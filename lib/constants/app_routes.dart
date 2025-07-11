
class AppRoutes {
  // Auth & onboarding
  static const entry            = '/';
  static const login            = '/login';
  static const register         = '/register';
  static const welcome          = '/welcome';

  // Home + tabs
  static const homeProfile         = '/home/profile';
  static const homeVolunteering    = '/home/volunteering';
  static const homeNews            = '/home/news';

  // Details
  static const volunteering        = '/volunteering/:id';
  static const news                = '/news/:id';

  static const homeProfileEdit     = '/home/profile/edit';
}

class RouteNames {
  static const entry                = 'EntryScreen';
  static const login                = 'LoginScreen';
  static const register             = 'RegisterScreen';
  static const welcome              = 'WelcomeScreen';
  static const profileTab           = 'ProfileTab';
  static const volunteeringTab      = 'VolunteeringTab';
  static const newsTab              = 'NewsTab';
  static const volunteeringDetails  = 'VolunteeringDetailsScreen';
  static const newsDetail           = 'NewsDetailScreen';
  static const unknownTab           = 'UnkownTab';
}
