cask "agentawake" do
  version "1.0.3"
  sha256 "d46502051e4d058d0d9287a8492074612738a519aa7abb4cdb71fd915bbb4d12"

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
