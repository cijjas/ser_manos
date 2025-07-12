class AppRoutes {
  // Auth & onboarding
  static const entry            = '/';
  static const login            = '/login';
  static const register         = '/register';
  static const welcome          = '/welcome';

  static const homeProfile         = '/profile';
  static const homeVolunteering    = '/volunteering';
  static const homeNews            = '/news';

  static const volunteeringDetail  = '/volunteering/detail/:id';
  static const newsDetail          = '/news/detail/:id';

  static const homeProfileEdit     = '/profile/edit';
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
