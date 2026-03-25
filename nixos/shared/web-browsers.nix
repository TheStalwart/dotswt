# Define Web Browser packages and settings

{ pkgs, ... }:

{
  # Firefox is The Default on Linux,
  # but its tab/session management is very basic.
  # Tab groups will survive the window being closed,
  # but new tabs (ctrl+T) are created outside of the tab group,
  # so when i want to open a travel plan
  # and add a couple extra tabs to research later,
  # i have to remember to pin the new tabs to the group manually.
  programs.firefox = {
    enable = true;

    # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
    # https://mozilla.github.io/policy-templates/
    preferences = {
      "browser.shell.checkDefaultBrowser" = false;
      "general.autoScroll" = true;
    };
  };

  environment.systemPackages =
    with pkgs;
    [
      # Firefox-based power-user browser, inspired by Vivaldi.
      # Has robust workspace management feature,
      # but they feel weird when trying to open multiple workspaces
      # and move tabs between them, because they're separate FF sessions.
      # Opening multiple windows in the same workspace is even worse,
      # since accidentally closing one of the workspace windows
      # essentially deletes the tabs from the workspace.
      floorp-bin

      # Chrome-based power-user browser.
      # Has extra features like RSS reader and Calendar.
      # Yet to properly test, but i'd like to move away from Chromium-based
      # due to hostile upstream that insists on nerfing ad blockers.
      # It's also proprietary, so any bugs present might be left unfixed for years.
      # Unless its calendar is substantially better than Thunderbird,
      # i don't want to switch from one dumpster fire (Edge) to another.
      vivaldi
      vivaldi-ffmpeg-codecs
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      # Reasons i'm not using Microsoft Edge as my default browser on Linux:
      # - The reason i'm using Edge in the first place, Workspace sync:
      #   - Before March 2026, was unreliable, i saw workspaces revert to an older state multiple times, losing tabs
      #   - Since March 2026, Workspace feature is not available on Linux
      # - Some tooltips are presented as normal windows and trigger relayout in tiling window managers
      # - Dragging and dropping tabs between windows is broken
      # - Disabling title bar with vertical tabs causes some buttons to overlap
      # - x86_64 only, no arm64 build for Raspberry Pi
      microsoft-edge
    ];

  # Set default browser to Ablaze Floorp
  # https://unix.stackexchange.com/questions/379632/how-to-set-the-default-browser-in-nixos
  # *.desktop files for installed apps are in /run/current-system/sw/share/applications/
  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.floorp-bin}/bin/floorp";
  xdg.mime.defaultApplications = {
    "text/html" = "floorp.desktop";
    "x-scheme-handler/http" = "floorp.desktop";
    "x-scheme-handler/https" = "floorp.desktop";
    "x-scheme-handler/about" = "floorp.desktop";
    "x-scheme-handler/unknown" = "floorp.desktop";
  };
}
