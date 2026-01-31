= NodeCloud Documentation

== General Concept

=== Objective
- Share files, videos, photos, and documents between multiple homes.
- Keep private folders truly private.
- Replicate important files for redundancy.
- Access files from Android, iPhone, Mac, Windows, Linux, TV.
- Stream media like a mini-CDN.
- Easy maintenance via Docker.

=== Topology
- Each person has their own server instance (Docker recommended).
  - *P* = Parents
  - *M* = You (Me)
  - *B* = Brother
  - *S* = Step-family
- *Mega-network 1*: P $arrow.l.r$ M $arrow.l.r$ B (Central family share)
- *Mega-network 2*: P $arrow.l.r$ S (Share with step-family)
- *Private folders*: Replicated only with encryption if necessary.

== Technology Stack

#table(
  columns: (auto, 1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Component*], [*Utility*], [*Remarks*],
  [Syncthing], [Peer-to-peer file replication], [End-to-end encryption, folder-based access, multi-platform],
  [Nextcloud], [User-friendly cloud interface], [Web, mobile; file access, sharing, media preview],
  [Jellyfin], [Media server (optional)], [Stream video/music to TV/devices, reads replicated folders],
  [Docker], [Containerized deployment], [Simplified install/update, service isolation],
  [Samba / SMB], [NAS-type LAN access], [Smart TVs or local devices, fast, optional],
  [TLS / HTTPS], [Access security], [Used by Nextcloud and WebDAV, encryption in transit],
  [Collabora / OnlyOffice], [In-browser document editing (optional)], [Real-time collaboration],
  [Nextcloud Flow/Tasks], [Automation & family productivity (optional)], [Reminders, workflows, shared tasks],
)

== Recommended Hardware per Home

#table(
  columns: (auto, 1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Equipment*], [*Utility*], [*Remarks*],
  [Small Server / NAS], [Main Host], [Raspberry Pi 4, Intel NUC, or mini-server is sufficient],
  [SSD/HDD], [Storage], [1 to 4 TB depending on video/photo volume],
  [Router / Internet], [WAN Access], [Required for remote access or VPN],
  [UPS (Optional)], [Electrical Safety], [Prevent corruption during outages],
  [Client Devices], [Android/iPhone, PC/Mac/Linux, TV], [To access files],
  [NAS Case (Optional)], [Extra Storage], [For private backups via Syncthing],
)

#quote(block: true)[Docker simplifies deployment and maintenance.]

== File Access Protocols

#table(
  columns: (auto, 1fr),
  inset: 10pt,
  align: horizon,
  [*Device / Usage*], [*Access Method*],
  [Android / iPhone], [Nextcloud App (upload and navigation)],
  [Mac / Windows / Linux], [Nextcloud Desktop Client (synchronization)],
  [TV], [SMB/Samba or Jellyfin App],
  [Web Browser], [Nextcloud Web UI (HTTPS)],
  [Private / Encrypted Folders], [Syncthing (Trusted devices only)],
)

#quote(block: true)[Syncthing replicates data but does not serve files directly to users.]

== Folder Model and Sharing

#table(
  columns: (auto, auto, 1fr),
  inset: 10pt,
  align: horizon,
  [*Folder*], [*Shared With*], [*Remarks*],
  [`core_family/`], [P $arrow.l.r$ M $arrow.l.r$ B], [Main family files, photos, videos],
  [`parents_stepfamily/`], [P $arrow.l.r$ S], [Step-family share],
  [`private_local/`], [M only], [Local personal files],
  [`private_encrypted/`], [M $arrow.l.r$ P], [Private backup; encrypted, unreadable by P],
)

- Moving a file from private $arrow$ family triggers automatic sharing.
- Private folders remain invisible and unreadable to others.

== Key Features and Benefits

#table(
  columns: (auto, 1fr),
  inset: 10pt,
  align: horizon,
  [*Feature*], [*Utility*],
  [Multi-home], [Redundancy, offline access in multiple locations],
  [Multi-platform support], [Android, iPhone, Windows, Mac, Linux],
  [Encrypted private folders], [Total security for personal data],
  [Family folders], [Easy sharing with access control],
  [Media streaming], [Videos, music, photos on TV and mobile devices],
  [Mobile auto-upload], [Automatic backup of photos and videos],
  [Web Interface & Apps], [Easy for all members, even non-technical],
  [Versioning & Trash], [Recovery of deleted or mistakenly modified files],
  [Collaborative Editing], [Real-time shared documents (optional)],
  [Docker Deployment], [Easy updates, service isolation],
)

== Limitations / Drawbacks

#table(
  columns: (auto, 1fr),
  inset: 10pt,
  align: horizon,
  [*Limitation*], [*Notes / Solutions*],
  [No global CDN], [Manual selection of the closest server],
  [Encrypted private files], [Cannot be streamed or shared remotely],
  [Legacy protocols (TFTP, etc.)], [Not supported, use SMB/HTTPS/WebDAV],
  [Conflict resolution], [Syncthing creates conflict copies on simultaneous edits],
  [Initial Setup], [Docker, SSL, Syncthing pairing may require technical config],
  [Bandwidth], [Large video uploads may saturate Internet, mitigated by LAN/Wi-Fi],
)

== Explanation for Different Audiences

#table(
  columns: (auto, 1fr),
  inset: 10pt,
  align: horizon,
  [*Audience*], [*Key Message / Analogy*],
  [Non-tech Parents], ["It's like Google Drive for the family. Photos, videos, and docs are automatically shared with the right people."],
  [Step-family], ["You only have access to specific folders. Nothing else is visible."],
  [Brother / Tech-savvy], ["Syncthing replicates files, Nextcloud provides the interface. Private folders remain encrypted."],
  [TV / Media User], ["You can watch videos or photos on TV via media server or network share, like a NAS."],
)

== Daily Usage Flow (Example)

+ Photos on Android $arrow$ auto-upload to `private_local/` or `core_family/`.
+ Move to shared folder $arrow$ Syncthing replicates to P & B.
+ Media streaming $arrow$ Jellyfin reads folder $arrow$ TV / Phone.
+ Private backup $arrow$ replicated encrypted to P, unreadable by others.
+ Document editing $arrow$ Nextcloud + OnlyOffice, collaboration possible.
+ Multi-device access $arrow$ offline work possible, mobile cache available.

== Best Practices

- Nextcloud for access, Syncthing for replication and redundancy.
- Keep private folders encrypted if replicated to family.
- Jellyfin + SMB for media streaming on TV.
- Nextcloud apps for auto-upload and offline access.
- Clear folder organization to avoid accidental sharing.

== Build Instructions

This project uses a containerized workflow to ensure reproducibility and consistency across different environments.

=== Prerequisites

*Podman* is required to run the build and development tasks.

*Ubuntu Installation:*
```bash
sudo apt-get update
sudo apt-get install -y podman
```

=== Building the Project

To build the project, including generating this documentation, run the following command from the project root:

```bash
make
```