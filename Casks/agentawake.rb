cask "agentawake" do
  version "1.0.2"
  sha256 "eeaa64e1dc7b4c572b2da3f6e0236de023672a6e72486e70276377738c541032"

  url "https://github.com/seneralkan/agent-awake/releases/download/v#{version}/AgentAwake-#{version}.zip"
  name "AgentAwake"
  desc "Keeps the computer awake, even with the lid closed, while AI coding agents work"
  homepage "https://github.com/seneralkan/agent-awake"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "AgentAwake.app"

  uninstall early_script: {
              executable: "#{appdir}/AgentAwake.app/Contents/MacOS/AgentAwake",
              args:       ["--uninstall-hooks"],
            },
            quit:         "com.jarvis.AgentAwake",
            script:       {
              executable: "/usr/bin/pmset",
              args:       ["-a", "disablesleep", "0"],
              sudo:       true,
            },
            delete:       "/etc/sudoers.d/agentawake"

  zap trash: [
    "~/Library/Application Support/AgentAwake",
    "~/Library/Preferences/com.jarvis.AgentAwake.plist",
  ]

  caveats <<~EOS
    AgentAwake is not notarized yet, so macOS blocks the first launch.
    Allow it once with either:
      System Settings → Privacy & Security → Open Anyway
    or:
      xattr -dr com.apple.quarantine #{appdir}/AgentAwake.app

    Then click the moon in the menu bar and finish the two setup steps.
  EOS
end
