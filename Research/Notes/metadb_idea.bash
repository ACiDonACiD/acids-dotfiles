# Add a project
meta-db add ./Code/ArchInstaller \
  --tag installer,bash,arch \
  --type project \
  --desc "Auto Arch installer prototype" \
  --hash $(sha1sum preinstall.sh | cut -d ' ' -f 1)

# Query by tag
meta-db find tag:arch

# Query by path
meta-db get ./Code/ArchInstaller

# Show human summary
meta-db summary ./Research/Nettle

