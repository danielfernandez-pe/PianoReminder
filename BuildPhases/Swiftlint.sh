export PATH=/opt/homebrew/bin:${PATH}

if [ "${ENABLE_PREVIEWS}" = "YES" ]; then
  echo "Previews enabled, quitting to prevent 'preview paused'."
  exit 0;
fi


mint run swiftlint autocorrect
mint run swiftlint
