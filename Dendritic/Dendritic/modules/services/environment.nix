{ ... }:
{
  flake.modules.nixos.environment =
    { ... }:
    {
      # Global Environment Variables
      environment.sessionVariables = {
        HISTCONTROL = "ignoreboth";
        HISTSIZE = "1000";
        HISTFILESIZE = "2000";
        EDITOR = "vim";
        VISUAL = "vim";
        QML_IMPORT_PATH = "/usr/local/lib64/qt6/qml:\${QML_IMPORT_PATH:-}";
        NIXOS_OZONE_WL = "1";
        # export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
        # export GOROOT=/usr/lib64/go1.26.5/go
        # export GOPATH=$HOME/go
        # export PODMAN=/usr/local/bin/podman
      };

      # Append directory paths to the system-wide $PATH environment variable
      environment.profiles = [
        "/home/md/.cargo/bin"
        "/usr/local/sbin"
        "/home/md/awww/target/release/"
        # "/home/md/zig/zig-x86_64-linux-0.16.0/"
        # "/home/md/zls/"
        # "$GOPATH/bin"
        # "$PODMAN"
        # "/home/md/typst/typst-x86_64-unknown-linux-musl/"
        # "/home/md/nb/nb-7.25.2/"
      ];
    };
}
