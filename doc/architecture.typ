= Technical Architecture

This document outlines the technical topology, software stack, and data model for the FamCloud project.

== Server Topology

The system is built on a distributed, multi-home topology. Each participating household runs its own independent server instance, referred to as a "Node".

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

The folder structure dictates the sharing rules. Syncthing replicates these folders between specific nodes.

#table(
  columns: (auto, auto, 1fr),
  align: (left, left, left),
  [*Folder Name*], [*Shared With*], [*Purpose & Remarks*],
  [`core_family/`], [P <-> M <-> B], [Main family files, photos, videos.],
  [`parents_stepfamily/`], [P <-> S], [Files shared between parents and step-family.],
  [`private_local/`], [M only], [Your personal files, not replicated anywhere.],
  [`private_encrypted/`], [M <-> P], [Your private backup. It is replicated to P's server but is #strong[encrypted] and unreadable by them.],
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