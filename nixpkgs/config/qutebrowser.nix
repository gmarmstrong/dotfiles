{ pkgs, config, ... }:
{
  xdg.configFile.qutebrowserConfig = {
    target = "qutebrowser/config.py";
    text = ''
      # Documentation:
      #   qute://help/configuring.html
      #   qute://help/settings.html

      config.set("editor.command", ['urxvt', '-e', 'nvim', '{}'])
      config.set("url.start_pages", "about:blank")
      config.set("url.default_page", "about:blank")
      config.set("fonts.monospace", "DejaVu Sans Mono")
      config.set("url.searchengines", {"DEFAULT": "https://www.google.com/search?q={}"})

      # Enable JavaScript
      # Type: Bool
      config.set('content.javascript.enabled', True, 'file://*')

      # Enable JavaScript
      # Type: Bool
      config.set('content.javascript.enabled', True, 'chrome://*/*')

      # Enable JavaScript.
      # Type: Bool
      config.set('content.javascript.enabled', True, 'qute://*/*')

      # Position of the tab bar.
      # Type: Position
      # Valid values: 'top', 'bottom', 'left', 'right'
      c.tabs.position = 'left'
    '';
  };
}
