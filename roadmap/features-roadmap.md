# Features Roadmap

### 📅 Release Schedule

#### ⚡ Next 2 Weeks - Release Candidates

| **Product**      | **Computle Client v3 RC**                                                                                                                                    |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Platform**     | Windows                                                                                                                                                      |
| **Key Features** | <p>• Native Windows tunnel service<br>• Automatic WireGuard VPN setup<br>• Support for RDP, TGX, DCV protocols<br>• Secure credential storage with DPAPI</p> |

| **Product**      | **Computle Portal v1 RC**                                                                                                                                    |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Platform**     | Web-based                                                                                                                                                    |
| **Key Features** | <p>• User management dashboard<br>• Machine assignment interface<br>• <strong>Entra ID (Azure AD) integration</strong><br>• Microsoft SSO authentication</p> |

***

#### 🔄 4 Weeks - Directory Integration

| **Feature**      | **Entra ID Tenant Sync**                                                                                                                                   |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Description**  | Synchronize your entire Azure AD tenant                                                                                                                    |
| **Capabilities** | <p>• Auto-provision users from AD groups<br>• Group-based machine assignments<br>• Real-time directory sync<br>• MFA enforcement via Azure AD policies</p> |

***

#### 🍎 4 Weeks - macOS Support

| **Product**  | **Computle Client v3 for macOS**                                                                                                   |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| **Platform** | macOS 12+ (Intel & Apple Silicon)                                                                                                  |
| **Features** | <p>• Native macOS application<br>• Keychain credential storage<br>• WireGuard integration<br>• Same features as Windows client</p> |

***

#### 🎯 2 Months - Unified Control

| **Feature**          | **Legacy Control Panel Integration**                                                                                                                                          |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Goal**             | Merge all control panels into Computle Portal                                                                                                                                 |
| **New Capabilities** | <p>• Control machines directly from web<br>• Start/Stop/Restart machines<br>• Remote console access<br>• Real-time resource monitoring<br>• Unified management experience</p> |

***

#### 🚀 3 Months - Smart Assignment

| **Feature**      | **Machine Pools & Auto-Assignment**                                                                                                        |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **Description**  | Automatically assign users to available machines                                                                                           |
| **How It Works** | <p>• Create pools of similar machines<br>• Auto-assign based on AD groups<br>• Dynamic load balancing<br>• Session persistence options</p> |

***

#### 📦 4+ Months - Software Management

| **Feature**      | **Software Deployment Add-in**                                                                                                                                      |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Capabilities** | <p>• Deploy software to machine pools<br>• Package management system<br>• Version control &#x26; rollback<br>• Automated installation<br>• Compliance reporting</p> |

***

### 🔧 Current Features

#### Computle Portal v1

| **Category**        | **Features**                                                                                 |
| ------------------- | -------------------------------------------------------------------------------------------- |
| **Authentication**  | <p>• Magic link (email)<br>• Microsoft SSO<br>• Entra ID integration</p>                     |
| **User Management** | <p>• 3 role types: User, Admin, Tenant Admin<br>• User invitations<br>• Activity logging</p> |
| **Machine Control** | <p>• Assign machines to users<br>• Set connection methods<br>• Monitor status</p>            |

#### Computle Client v3

| **Category**    | **Features**                                                                           |
| --------------- | -------------------------------------------------------------------------------------- |
| **Platforms**   | <p>• Windows (RC ready)<br>• macOS (coming soon)<br>• Linux</p>                        |
| **Security**    | <p>• Automatic WireGuard VPN<br>• Encrypted credentials<br>• Secure tunnel service</p> |
| **Connections** | <p>• RDP (Windows)<br>• TGX<br>• DCV</p>                                               |
