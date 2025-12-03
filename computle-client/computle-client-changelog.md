# Changelog

All notable changes to the Computle Client will be documented in this file.

### \[3.0.8.3] - 2025-12-03

#### Fixed

* DCV disconnect monitoring now reliably detects disconnections on repeated connections
* Multi-monitor support now works correctly on Windows platforms
* Standardized DCV viewer arguments across all platforms for consistent behavior

### \[3.0.8] - 2025-11-11

#### Added

* Client now detects when you close the DCV viewer and terminates background processes automatically
* DCV launches automatically after successful login
* Client automatically detects when your machine assignment changes without requiring logout

#### Changed

* Timestamp-based log parsing for improved reliability across log rotations
* Machine assignment polling occurs every 5 seconds&#x20;

#### Fixed

* Enhancaes made to telemetry collection and log exports.

### \[3.0.7] - 2025-10-29

#### Added

* Enhanced diagnostics and telemetry for improved support experience
* Automatic network performance monitoring
* Bandwidth usage tracking
* Manual log collection via diagnostics page
* Command-line flag for immediate log collection on startup
* Intelligent VPN routing based on assigned machines

#### Fixed

* Network performance metrics accuracy
* Bandwidth tracking reliability on Windows
* Log collection completeness
* VPN tunnel reconnection behavior on logout
* Single sign-on tunnel connectivity
* Installation process reliability
* Certificate validation workflows
* Connection dialog stability

#### Security

* Updated dependencies to address security vulnerabilities
* Fixed CVE-2025-7783
* Enhanced tunnel service security

### \[3.0.6] - 2025-10-05

#### Fixed

* General bug fixes and installer improvements
* Diagnostic reporting reliability

### \[3.0.5] - 2025-07-06

#### Added

* Enhanced network diagnostics tools
* Helpful messaging for users with no machines assigned
* Improved diagnostic reporting

#### Changed

* Updated About page styling and branding
* Simplified version information display
* Improved diagnostics accuracy

#### Fixed

* Diagnostic tracking reliability
* Diagnostics page functionality
* Version display in settings

#### Removed

* Simplified diagnostics output for better clarity
* Streamlined diagnostics interface

### \[3.0.4] - 2025-07-05

#### Security

* Fixed critical security vulnerabilities
* Enhanced code protection

#### Changed

* Updated settings page with enhanced privacy disclosure
* Improved user messaging

### \[3.0.3] - 2025-07-04

#### Changed

* Updated application icon across all platforms
* Enhanced icon resolution support

### \[3.0.2] - 2025-06-15

#### Fixed

* Improved application startup performance
* Enhanced diagnostic reliability
* Optimized background services

### \[3.0.1] - 2025-06-15

#### Added

* Log collection functionality for better support
* Enhanced version tracking

#### Fixed

* Login flow reliability
* Authentication performance

### \[3.0.0] - 2025-06-17

#### Added

* View toggle for simplified or advanced machine list display
* Responsive window sizing
* Enhanced visual design for machine cards
* Improved user experience with automatic layout optimization
* Vertical layout for better readability

#### Changed

* Redesigned machine list interface for improved usability
* Simplified and modernized UI layout
* Refined typography and spacing throughout
* Optimized window sizing behavior
* Improved status information display

#### Fixed

* Window sizing and layout issues
* Interface padding and alignment
* Responsive design improvements

### \[Beta] - 2025-06-01 to 2025-06-16

#### Added

* Enterprise Single Sign-On authentication
* Multi-machine management interface
* Automatic secure VPN tunnel management
* Remote desktop connectivity
* System tray integration
* Automatic software updates
* Comprehensive settings and diagnostics
* Dynamic background images
* Network connectivity monitoring
* Cross-platform installer support
* Enhanced logging for support and troubleshooting

#### Changed

* Streamlined login experience
* Improved visual experience with curated backgrounds
* Simplified setup and onboarding process

#### Fixed

* VPN connection stability and reliability
* Connection management improvements
* Secure certificate handling
* Authentication flow reliability
* Platform-specific installation issues
* Installer process improvements

### \[Initial Release] - 2025-05-26

#### Added

* Initial application release
* Core application framework
* User interface foundation
* Logging and diagnostics infrastructure
* Secure connection support
* Background service architecture
