# Table of contents

* [Welcome to Computle Docs](README.md)

## Installers

* [Installers](installers/installers.md)

## Computle Client

* [Computle Client v3 (Release Candidate)](computle-client/computle-client-v3-release-candidate/README.md)
  * [Computle Client: Entra ID](computle-client/computle-client-v3-release-candidate/computle-client-entra-id.md)
  * [Computle Client: Application Architecture](computle-client/computle-client-v3-release-candidate/computle-client-application-architecture.md)
* [Computle Client v3: Enterprise App Registration](computle-client/computle-client-v3-enterprise-app-registration.md)

## Onboarding

* [Computle - End User Guide](onboarding/computle-end-user-guide/README.md)
  * [iPad/Tablet](onboarding/computle-end-user-guide/ipad-tablet.md)
  * [Network Requirements](onboarding/computle-end-user-guide/network-requirements.md)
  * [Unattended Install](onboarding/computle-end-user-guide/unattended-install.md)
  * [Hardware](onboarding/computle-end-user-guide/hardware.md)
  * [End User Guide (Canary Release)](onboarding/computle-end-user-guide/end-user-guide-canary-release.md)
* [Administrator Guide](onboarding/administrator-guide/README.md)
  * [Computle Gateway for SMEs](onboarding/administrator-guide/computle-gateway-for-smes.md)
  * [Computle Device](onboarding/administrator-guide/computle-device.md)
  * [Machine Portal](onboarding/administrator-guide/machine-portal.md)
  * [Machine Assignment](onboarding/administrator-guide/machine-assignment.md)
  * [Billing Portal](onboarding/administrator-guide/billing-portal.md)
  * [Service Status](onboarding/administrator-guide/service-status.md)
  * [Virtual Machine Licensing and User Identification Requirements (Windows 11 Professional)](onboarding/administrator-guide/virtual-machine-licensing-and-user-identification-requirements-windows-11-professional.md)
* [Migrating to Computle](onboarding/migrating-to-computle/README.md)
  * [GPU Analyser](onboarding/migrating-to-computle/gpu-analyser.md)

## Troubleshooting

* [Streaming Agent](troubleshooting/streaming-agent/README.md)
  * [NICE DCV](troubleshooting/streaming-agent/nice-dcv/README.md)
    * [Unable To Connect](troubleshooting/streaming-agent/nice-dcv/unable-to-connect.md)
    * [Unable To Login](troubleshooting/streaming-agent/nice-dcv/unable-to-login.md)
    * [DCV Server Certificate Warning](troubleshooting/streaming-agent/nice-dcv/dcv-server-certificate-warning.md)
    * [DCV Server License Warning](troubleshooting/streaming-agent/nice-dcv/dcv-server-license-warning.md)
    * [USB Passthrough](troubleshooting/streaming-agent/nice-dcv/usb-passthrough.md)
    * [WebAuthn Redirection/FIDO Keys](troubleshooting/streaming-agent/nice-dcv/webauthn-redirection-fido-keys.md)
    * [No Username or Password Requested](troubleshooting/streaming-agent/nice-dcv/no-username-or-password-requested/README.md)
      * [Resolution and Quality](troubleshooting/streaming-agent/nice-dcv/no-username-or-password-requested/resolution-and-quality.md)
  * [Mechdyne TGX](troubleshooting/streaming-agent/mechdyne-tgx/README.md)
    * [Enable USB Redirection](troubleshooting/streaming-agent/mechdyne-tgx/enable-usb-redirection.md)
    * [Enable Microphone Input](troubleshooting/streaming-agent/mechdyne-tgx/enable-microphone-input.md)
* [Component Reinstallation](troubleshooting/component-reinstallation/README.md)
  * [Reinstall DCV Server](troubleshooting/component-reinstallation/reinstall-dcv-server.md)
  * [Reinstall NVIDIA](troubleshooting/component-reinstallation/reinstall-nvidia.md)
  * [Build Scripts](troubleshooting/component-reinstallation/build-scripts.md)
* [Third Party Applications](troubleshooting/third-party-applications/README.md)
  * [Twinmotion crashes when exporting high-resolution renders](troubleshooting/third-party-applications/twinmotion-crashes-when-exporting-high-resolution-renders.md)
  * [Intune/Entra ID and Computle, BitLocker](troubleshooting/third-party-applications/intune-entra-id-and-computle-bitlocker.md)

## Service Delivery

* [Service Delivery Architecture](service-delivery/service-delivery-architecture/README.md)
  * [Machine Plane](service-delivery/service-delivery-architecture/machine-plane.md)
  * [Telemetry and Monitoring at Computle](service-delivery/service-delivery-architecture/telemetry-and-monitoring-at-computle.md)
  * [Computle Gateway](service-delivery/service-delivery-architecture/computle-gateway.md)
  * [Network Plane](service-delivery/service-delivery-architecture/network-plane.md)
  * [IDAM Providers](service-delivery/service-delivery-architecture/idam-providers.md)
  * [Storage Providers](service-delivery/service-delivery-architecture/storage-providers.md)
  * [Computle Tunnel](service-delivery/service-delivery-architecture/computle-tunnel.md)
  * [Computle Broker](service-delivery/service-delivery-architecture/computle-broker.md)
* [Service Operations](service-delivery/service-operations/README.md)
  * [Shared Responsibility Model](service-delivery/service-operations/shared-responsibility-model.md)
  * [Security at Computle](service-delivery/service-operations/security-at-computle.md)
  * [Maintenance of Computle Infrastructure](service-delivery/service-operations/maintenance-of-computle-infrastructure.md)

## Reference architecture

* [Tenant-Level Configuration](reference-architecture/tenant-level-configuration/README.md)
  * [Network Access](reference-architecture/tenant-level-configuration/network-access/README.md)
    * [Tenant Defaults](reference-architecture/tenant-level-configuration/network-access/tenant-defaults/README.md)
      * [Computle Gateway](reference-architecture/tenant-level-configuration/network-access/tenant-defaults/computle-gateway/README.md)
        * [End User Guide](reference-architecture/tenant-level-configuration/network-access/tenant-defaults/computle-gateway/end-user-guide.md)
        * [Administration](reference-architecture/tenant-level-configuration/network-access/tenant-defaults/computle-gateway/administration.md)
    * [Tenant Options](reference-architecture/tenant-level-configuration/network-access/tenant-options/README.md)
      * [Custom Gateways](reference-architecture/tenant-level-configuration/network-access/tenant-options/custom-gateways/README.md)
        * [Traditional VPN](reference-architecture/tenant-level-configuration/network-access/tenant-options/custom-gateways/traditional-vpn.md)
        * [Zero Trust](reference-architecture/tenant-level-configuration/network-access/tenant-options/custom-gateways/zero-trust.md)
      * [Site-to-Site Connectivity](reference-architecture/tenant-level-configuration/network-access/tenant-options/site-to-site-connectivity/README.md)
        * [Cisco Meraki](reference-architecture/tenant-level-configuration/network-access/tenant-options/site-to-site-connectivity/cisco-meraki.md)
        * [WireGuard](reference-architecture/tenant-level-configuration/network-access/tenant-options/site-to-site-connectivity/wireguard.md)

## Corporate Governance&#x20;

* [Supply Chain Management](corporate-governance/supply-chain-management.md)
* [Standards](corporate-governance/standards/README.md)
  * [ISO 27001 Security Controls](corporate-governance/standards/iso-27001-security-controls.md)
  * [Vulnerability Disclosure Programme](corporate-governance/standards/vulnerability-disclosure-programme.md)
* [Computle Ethos](corporate-governance/computle-ethos/README.md)
  * [Our Approach to Engineering](corporate-governance/standards/our-approach-to-engineering.md)
* [Carbon Neutrality](corporate-governance/carbon-neutrality.md)

## Account Administration

* [Direct Debit Set Up](account-administration/direct-debit-set-up.md)
* [Viewing Your Invoices](account-administration/viewing-your-invoices.md)

## Roadmap

* [Features Roadmap](roadmap/features-roadmap.md)

## Validations

* [Entra ID Sync with On-Premise Active Directory: Validating Seamless File Share Access](validations/entra-id-sync-with-on-premise-active-directory-validating-seamless-file-share-access.md)
