= Introduction: The FamCloud Project

A private, multi-home, family-resilient cloud for sharing files, photos, and documents across multiple households.

== General Concept

The goal of FamCloud is to create a private cloud that connects several family homes. It allows for easy sharing of common files (photos, videos, documents) while ensuring that personal data remains completely private and secure.

The system is designed for high redundancy and easy maintenance, using peer-to-peer replication to ensure that important data exists in multiple locations.

=== Key Features

#table(
  columns: (auto, 1fr),
  align: (left, left),
  [*Feature*], [*Benefit*],
  [Multi-Home Redundancy], [Data is replicated across houses, ensuring offline access and backup.],
  [Cross-Platform Support], [Works on Android, iPhone, Windows, Mac, and Linux.],
  [Encrypted Private Folders], [Personal data can be backed up securely without being visible to others.],
  [Seamless Family Sharing], [Easily share files with specific family groups.],
  [Media Streaming], [Stream videos, music, and photos directly to TVs and mobile devices.],
  [Automatic Mobile Uploads], [Automatically back up photos and videos from phones.],
  [User-Friendly Interface], [Simple web and mobile apps for non-technical family members.],
  [File Versioning & Trash], [Recover accidentally deleted or modified files.],
)

== How to Explain FamCloud to Family

The key is to use simple analogies.

#table(
  columns: (auto, 1fr),
  align: (left, left),
  [*Audience*], [*Key Message / Analogy*],
  [Non-technical Parents], ["It's like our own private Google Drive for the family. Your photos, videos, and documents are automatically shared with the right people."],
  [Extended Family], ["You have access to specific shared folders. Nothing else is visible to you."],
  [Tech-savvy Brother], ["It's a Dockerized stack. Syncthing handles peer-to-peer file replication, and Nextcloud provides the user-friendly interface. Private folders are encrypted on remote nodes."],
  [Media/TV User], ["You can watch our family videos or see photos on the TV through a media server, just like a local NAS."],
)

== Daily Usage Example

#enum(
  start: 1,
  [You take photos on your Android phone. They are automatically uploaded to your server.],
  [You move the photos into the `core_family/` shared folder.],
  [Syncthing automatically replicates the new photos to your brother's and parents' servers.],
  [Your parents can now stream those photos to their TV using the Jellyfin media server.],
  [Your personal documents remain on your server, but a private, encrypted backup is replicated to your parents' server, unreadable by anyone but you.],
)