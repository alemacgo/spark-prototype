
// To check if a library is compiled with CocoaPods you
// can use the `COCOAPODS` macro definition which is
// defined in the xcconfigs so it is available in
// headers also when they are imported in the client
// project.


// Debug build configuration
#ifdef DEBUG

  // Lookback
  #define COCOAPODS_POD_AVAILABLE_Lookback
  #define COCOAPODS_VERSION_MAJOR_Lookback 0
  #define COCOAPODS_VERSION_MINOR_Lookback 6
  #define COCOAPODS_VERSION_PATCH_Lookback 5

#endif
