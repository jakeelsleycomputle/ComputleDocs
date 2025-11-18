---
description: >-
  This document provides a comprehensive overview of the Computle Client
  architecture, including service interactions, network configuration, and
  system comp
---

# Computle Client: Application Architecture

### Overview

The Computle Client is a cross-platform desktop application that provides secure remote access to virtual workstations. It operates as part of a distributed system comprising multiple backend services that handle authentication, Point-to-Point tunnel management, and machine assignment.

#### Core Components

| Component              | Purpose                                   |
| ---------------------- | ----------------------------------------- |
| **Computle Client**    | Desktop application for Windows and macOS |
| **Auth System**        | User authentication and tenant management |
| **WireGuard Manager**  | Point-to-Point configuration management   |
| **Assignment Manager** | Machine-to-user assignment tracking       |
| **Computle Portal**    | Web-based administration interface        |

***

### System Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    COMPUTLE CLIENT                       │
│  ┌─────────────────────────────────────────────────┐   │
│  │  Electron Application (main.js)                  │   │
│  │  - Window management                             │   │
│  │  - IPC handlers                                  │   │
│  │  - Protocol handlers (computle-vdi://)           │   │
│  └─────────────────────────────────────────────────┘   │
│                         │                               │
│  ┌─────────────────────────────────────────────────┐   │
│  │  Services Layer                                   │   │
│  │  - Authentication    - WireGuard management      │   │
│  │  - Connectivity      - Telemetry                 │   │
│  │  - DCV/RDP/TGX       - Logging                   │   │
│  └─────────────────────────────────────────────────┘   │
│                         │                               │
│  ┌─────────────────────────────────────────────────┐   │
│  │  Tunnel Service (.NET Background Service)        │   │
│  │  - REST API (Port 28982)                         │   │
│  │  - WireGuard interface management                │   │
│  │  - DNS resolution                                │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                  BACKEND SERVICES                        │
├─────────────────────────────────────────────────────────┤
│  Auth System        │  WireGuard Manager                │
│  auth.computle.com  │  wg.computle.com                  │
│  Port: 443 (HTTPS)  │  Port: 443 (HTTPS)                │
├─────────────────────────────────────────────────────────┤
│  Assignment Manager │  Computle Portal                  │
│  Internal service   │  portal.computle.com              │
│  Port: 3002         │  Port: 443 (HTTPS)                │
└─────────────────────────────────────────────────────────┘
```

***

### Network Configuration

#### Ports and Endpoints

**Client-Side Services**

| Service            | Port  | Protocol | Purpose                 |
| ------------------ | ----- | -------- | ----------------------- |
| Tunnel Service API | 28982 | HTTP     | Local tunnel management |

**Backend Services**

| Service           | Endpoint                      | Purpose                            |
| ----------------- | ----------------------------- | ---------------------------------- |
| Auth System       | `https://auth.computle.com`   | Authentication and user management |
| WireGuard Manager | `https://wg.computle.com`     | VPN configuration management       |
| Computle Portal   | `https://portal.computle.com` | Web administration                 |

**WireGuard Point-to-Point Tunnel**

| Parameter            | Default Value    |
| -------------------- | ---------------- |
| Server Port          | 51820 (UDP)      |
| DNS                  | 1.1.1.1, 8.8.8.8 |
| MTU                  | 1420             |
| Persistent Keepalive | 25 seconds       |

***

### Tunnel Service API

The Tunnel Service runs as a background service and provides a local REST API for tunnel management.

#### Endpoints

| Endpoint             | Method | Authentication | Description            |
| -------------------- | ------ | -------------- | ---------------------- |
| `/health`            | GET    | None           | Health check           |
| `/api/tunnel/status` | GET    | API Key        | Get tunnel status      |
| `/api/tunnel/start`  | POST   | API Key        | Start WireGuard tunnel |
| `/api/tunnel/stop`   | POST   | API Key        | Stop WireGuard tunnel  |
| `/api/tunnel/reload` | POST   | API Key        | Reload configuration   |
| `/api/tunnel/paths`  | GET    | API Key        | Get service paths      |

#### Authentication

The Tunnel Service uses API key authentication via the `X-API-Key` header. The API key is automatically generated on first run.

**API Key Location:**

* **macOS**: `/Library/Application Support/Computle/2025.3.0-Tunnel/api_key.txt`
* **Windows**: `C:\Users\Public\Documents\Computle\2025.3.0-Tunnel\api_key.txt`

***

### Authentication Flow

Computle Client supports two authentication methods:

#### Microsoft Entra ID (Primary)

1. User initiates login via the client
2. Microsoft OAuth popup opens in the desktop application
3. User authenticates with Microsoft credentials
4. Client receives authorization code
5. Code exchanged for Microsoft access token
6. Token sent to Auth System for validation
7. Auth System returns Computle JWT token
8. Client stores session for subsequent requests

#### Magic Link Authentication

1. User enters email address
2. Auth System generates secure magic link token
3. Email sent to user with authentication link
4. User clicks link to approve authentication
5. Client polls for approval status
6. Once approved, JWT token is returned
7. Client stores session for subsequent requests

#### Token Management

* **Token Expiry**: 90 days (configurable per tenant)
* **Storage**: Secure IPC-accessible storage
* **Validation**: Tokens validated against tenant-specific JWT secrets

***

### WireGuard **Point-to-Point Tunnel** Integration

#### Configuration Flow

1. **Authentication**: User authenticates with Computle Client
2. **Configuration Request**: Client requests VPN config from WireGuard Manager
3. **Config Generation**: Server generates client configuration with allocated IP
4. **Config Storage**: Configuration saved to local filesystem
5. **Tunnel Start**: Client instructs Tunnel Service to start VPN
6. **DNS Resolution**: Tunnel Service resolves server endpoint
7. **Connection**: WireGuard tunnel established

#### Configuration Storage

**macOS:**

```
/Library/Application Support/Computle/2025.3.0-Client/token/ComputleManagedTunnel.conf
```

**Windows:**

```
C:\Users\Public\Documents\Computle\2025.3.0-Client\token\ComputleManagedTunnel.conf
```

#### WireGuard Configuration Format

```ini
[Interface]
PrivateKey = <client_private_key>
Address = <allocated_ip>/32
DNS = 1.1.1.1, 8.8.8.8
MTU = 1420

[Peer]
PublicKey = <server_public_key>
AllowedIPs = <site_allowed_ips>
Endpoint = <server_endpoint>:<port>
PersistentKeepalive = 25
```

#### Platform-Specific Implementation

**macOS:**

* Uses `wg-quick` tool from Homebrew
* Requires administrator privileges (sudo)
* Dynamic `utun` interface allocation

**Windows:**

* Uses WireGuard system driver
* Managed via Windows Service
* Requires elevated privileges for tunnel operations

***

### Machine Assignment

#### Assignment Workflow

1. **Administrator assigns machine** via Computle Portal
2. **Assignment stored** in Assignment Manager database
3. **User authenticates** with Computle Client
4. **Client queries** assigned machine details
5. **Connection details returned** (IP, port, connection method)
6. **User connects** via RDP, TGX, or DCV

#### Connection Methods

| Method  | Description                        | Port   |
| ------- | ---------------------------------- | ------ |
| **RDP** | Remote Desktop Protocol            | 3389   |
| **TGX** | High-performance graphics protocol | Varies |
| **DCV** | NICE DCV interactive streaming     | Varies |

***

### Service Communication

#### Auth System Integration

The Auth System (`auth.computle.com`) handles all authentication and authorization:

**Key Endpoints:**

* `POST /api/auth/microsoft` - Microsoft token exchange
* `POST /api/auth/request` - Request magic link
* `GET /api/auth/status/:token` - Check auth status
* `GET /api/auth/token/:token` - Retrieve JWT
* `POST /api/auth/validate` - Validate JWT token

#### WireGuard Manager Integration

The WireGuard Manager (`wg.computle.com`) manages VPN configurations:

**Key Endpoints:**

* `GET /api/configs` - Get user configurations
* `GET /api/configs/mode` - Check operation mode (on-demand/legacy)
* `POST /api/configs/create-on-demand` - Create new configuration
* `POST /api/configs/:id/checkout` - Reserve configuration
* `POST /api/configs/:id/checkin` - Release configuration

#### Assignment Manager Integration

The Assignment Manager tracks machine assignments:

**Key Endpoints:**

* `GET /api/machines/my` - Get user's assigned machine
* `GET /api/machines` - List tenant machines (admin)
* `POST /api/assignments/assign` - Assign machine to user
* `POST /api/assignments/unassign` - Remove assignment

***

### Security Features

#### Transport Security

* All external communications use HTTPS/TLS
* WireGuard tunnel provides encrypted VPN connection
* Local Tunnel Service API bound to localhost only

#### Authentication Security

* JWT tokens with tenant-specific secrets
* WebAuthn/FIDO2 support for hardware security keys
* MFA support (TOTP authenticator apps)
* Magic link tokens expire after 15 minutes

#### Tunnel Service Security

* API key authentication for all management endpoints
* Health check endpoint available without authentication
* Keys auto-generated using cryptographic random bytes
* Service runs with minimal required privileges

#### Configuration Security

* VPN configurations encrypted at rest (AES-256-CBC)
* Private keys never transmitted in plaintext
* Configuration cleanup on tunnel stop

***

### Diagnostics and Monitoring

#### Connectivity Testing

The client includes built-in diagnostic tools:

* **Ping Test**: ICMP ping with latency measurement
* **DNS Resolution**: Domain name lookup verification
* **Port Connectivity**: TCP port availability check
* **HTTP Request**: HTTPS endpoint validation

#### Logging

**Client Logs:**

* Location varies by platform (see file structure above)
* Structured logging with timestamps
* Includes connection events, errors, and diagnostics

**Tunnel Service Logs:**

* File-based logging with size rotation (10MB limit)
* Includes tunnel state changes and API requests
* Separate log files for service and tunnel operations

#### Telemetry Events

| Event           | Description               |
| --------------- | ------------------------- |
| `app_start`     | Application launched      |
| `app_close`     | Application closed        |
| `button_click`  | UI interaction            |
| `logs_uploaded` | Diagnostic logs submitted |

***

### Deep Linking

Computle Client supports deep linking via the `computle-vdi://` protocol handler.

#### URL Format

```
computle-vdi://connect?type=<protocol>&dns=<hostname>&bypass=<boolean>
```

#### Parameters

| Parameter | Values              | Description             |
| --------- | ------------------- | ----------------------- |
| `type`    | `dcv`, `rdp`, `tgx` | Connection protocol     |
| `dns`     | hostname            | Target machine DNS name |
| `bypass`  | `true`, `false`     | Bypass VPN requirement  |

#### Example

```
computle-vdi://connect?type=dcv&dns=workstation-01.internal&bypass=false
```

***

### Error Handling and Recovery

#### Tunnel Auto-Recovery

The Tunnel Service monitors connection health and automatically recovers from failures:

* **Health Monitoring**: 30-second interval status checks
* **Failure Detection**: 3 consecutive failures trigger restart
* **Exponential Backoff**: Increasing delays between retry attempts
* **DNS Retries**: Up to 5 attempts with exponential backoff

#### Connection Resilience

* Automatic reconnection on network changes
* Persistent keepalive maintains NAT traversal
* Configuration preserved across service restarts
* Graceful degradation on partial failures

***

### Multi-Tenant Architecture

Computle operates as a multi-tenant system with complete data isolation:

#### Tenant Isolation

* Each tenant has dedicated JWT secrets
* Configurations filtered by tenant ID
* Separate VPN sites per tenant
* Machine assignments scoped to tenant

#### Site Management

Sites represent physical or logical data center locations:

* Each site has unique WireGuard server configuration
* Tenants mapped to available sites
* IP ranges allocated per site
* High availability support per site

***

### Version Information

| Component        | Current Version   |
| ---------------- | ----------------- |
| Computle Client  | 3.0.8             |
| Tunnel Service   | .NET 9.0          |
| Protocol Handler | `computle-vdi://` |

***

### Additional Resources

* [Computle Client Installation Guide](https://docs.computle.com)
* [Troubleshooting Guide](https://docs.computle.com)
* [Administrator Portal Guide](https://docs.computle.com)

For support, please contact your account manager.
