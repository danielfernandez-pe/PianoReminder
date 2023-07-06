# Runs before xcode cloud runs the xcodebuild command
#!/bin/sh

brew install mint
mint bootstrap -m ../Mintfile
