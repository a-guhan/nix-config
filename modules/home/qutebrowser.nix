{ lib, pkgs, ... }:
let
  qutebrowser = pkgs.qutebrowser.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace qutebrowser/app.py \
        --replace-fail 'url = e.url()' \
          'url = e.url()
              if url.toLocalFile() == sys.argv[0] or os.path.basename(url.toLocalFile()) == ".qutebrowser-wrapped":
                  return True'
    '';
  });

  qutebrowserApp = pkgs.stdenvNoCC.mkDerivation {
    pname = "qutebrowser-app";
    version = qutebrowser.version;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/Applications/Qutebrowser.app/Contents/{MacOS,Resources}
      cat > $out/Applications/Qutebrowser.app/Contents/MacOS/qutebrowser <<'EOF'
      #!/bin/sh
      exec ${qutebrowser}/bin/qutebrowser "$@"
      EOF
      chmod +x $out/Applications/Qutebrowser.app/Contents/MacOS/qutebrowser

      cat > $out/Applications/Qutebrowser.app/Contents/Info.plist <<'EOF'
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>qutebrowser</string>
        <key>CFBundleIdentifier</key>
        <string>org.qutebrowser.qutebrowser</string>
        <key>CFBundleName</key>
        <string>qutebrowser</string>
        <key>CFBundleDisplayName</key>
        <string>qutebrowser</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleVersion</key>
        <string>${qutebrowser.version}</string>
      </dict>
      </plist>
      EOF
    '';
  };
in
{
  home.packages = [
    qutebrowser
    qutebrowserApp
  ];

  # Home Manager also exposes applications through its profile, but Spotlight
  # discovers a normal per-user Applications directory more reliably.
  home.file = {
    "Applications/Qutebrowser.app" = lib.mkIf pkgs.stdenv.isDarwin {
      source = "${qutebrowserApp}/Applications/Qutebrowser.app";
    };

    ".qutebrowser/config.py".text = ''
      config.load_autoconfig()

      config.set("colors.webpage.darkmode.enabled", True)
      config.set("colors.webpage.preferred_color_scheme", "dark")

      config.set("content.blocking.enabled", True)
      config.set("content.blocking.method", "adblock")
      config.set(
          "content.blocking.adblock.lists",
          [
              "https://easylist.to/easylist/easylist.txt",
              "https://easylist.to/easylist/easyprivacy.txt",
          ],
      )

      config.set(
          "url.searchengines",
          {
              "DEFAULT": "https://www.google.com/search?q={}",
              "google": "https://www.google.com/search?q={}",
          },
      )
      config.set("url.start_pages", ["https://www.google.com"])
    '';
  };
}
