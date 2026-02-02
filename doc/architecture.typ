#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge

= Technical Architecture

This document outlines the technical topology, software stack, and data model for the NodeCloud project.

== Server Topology

The system is built on a distributed, multi-home topology. Each participating node runs its own independent server instance.

Nodes in the network are connected via peer-to-peer replication tunnels using Syncthing. Data is not stored on a central server but is replicated directly between the participating nodes based on folder-specific sharing rules. This decentralized approach ensures high redundancy, offline access, and fast local network speeds.

For a concrete example of how this can be implemented, see the included example.
#include "topology_example.typ"

== Technology Stack

#table(
  columns: (auto, auto, 1fr),
  align: (left, left, left),
  [*Component*], [*Purpose*], [*Notes*],
  [Syncthing], [Peer-to-peer file replication], [End-to-end encryption, folder-based access, cross-platform. The backbone of the system.],
  [Nextcloud], [User-friendly cloud interface], [Provides Web UI and mobile apps for file access, sharing, and media previews.],
  [Jellyfin], [Media server (optional)], [Streams videos/music to TVs and devices by reading replicated folders.],
  [Docker], [Containerized deployment], [Simplifies installation, updates, and service isolation.],
  [Samba / SMB], [LAN file access (optional)], [For Smart TVs or local devices that need direct network share access.],
  [TLS / HTTPS], [Secure remote access], [Used by Nextcloud to encrypt traffic.],
)

== Folder & Sharing Model

The folder structure dictates the sharing rules. Syncthing operates on a **Folder-Based Model** rather than a centralized permission system.

=== Core Concepts

- **Folder-Based Decentralization**: Permissions are defined at the root of a shared folder. If a device has access to a folder, it generally has access to everything inside it.
- **Peer-to-Peer Trust**: There is no central admin. Sharing requires explicit agreement between two nodes (devices) to sync a specific Folder ID.
- **Local Isolation**: Files not configured in Syncthing remain private to the local disk (e.g., `private_local/`).

=== Replication Capabilities

The architecture utilizes three distinct replication strategies:

1. **Standard Bidirectional Sync (`<->`)**: Full read/write access. Changes propagate immediately (e.g., `core_shared`).
2. **Encrypted Replication**: The source encrypts data before sending. The destination stores it without access to the contents, useful for untrusted backups (e.g., `private_encrypted`).
3. **Selective Topology**: Creating sub-networks by only pairing specific nodes for specific folders (e.g., `restricted_shared`).

=== Topology Visualization

#figure(
  diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0,0), "Node 1", radius: 2em, fill: blue.lighten(80%)),
    node((2,0), "Node 2", radius: 2em, fill: green.lighten(80%)),
    node((1,1.5), "Node 3", radius: 2em, fill: yellow.lighten(80%)),
    node((0, -1.5), "Node 4", radius: 2em, fill: red.lighten(80%)),
    edge((0,0), (2,0), "<->", label: "core_shared"),
    edge((2,0), (1,1.5), "<->", label: "core_shared"),
    edge((0,0), (1,1.5), "<->", label: "core_shared"),
    edge((0,0), (0,-1.5), "<->", label: "restricted_shared"),
    edge((2,0), (0,0), "->", label: "encrypted", bend: 40deg, stroke: (dash: "dashed")),
  ),
  caption: [Syncthing Replication Topology]
)

#table(
  columns: (auto, auto, 1fr),
  align: (left, left, left),
  [*Folder Name*], [*Shared With*], [*Purpose & Remarks*],
  [`core_shared/`], [Node 1 <-> Node 2 <-> Node 3], [Main shared files, photos, videos.],
  [`restricted_shared/`], [Node 1 <-> Node 4], [Files shared between specific nodes.],
  [`private_local/`], [Node 2 only], [Local personal files, not replicated anywhere.],
  [`private_encrypted/`], [Node 2 <-> Node 1], [Private backup. It is replicated to Node 1 but is #strong[encrypted] and unreadable by it.],
)

== File Access Protocols

#table(
  columns: (auto, 1fr),
  align: (left, left),
  [*Device / Use Case*], [*Access Method*],
  [Android / iPhone], [Nextcloud Mobile App (for browsing and auto-uploads)],
  [Mac / Windows / Linux], [Nextcloud Desktop Client (for folder synchronization)],
  [Smart TV], [SMB/Samba share or Jellyfin App],
  [Web Browser], [Nextcloud Web UI (via HTTPS)],
  [Trusted Devices Only], [Syncthing UI (for managing replication)],
)