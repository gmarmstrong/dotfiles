{ pkgs, config, ... }:

{
  programs.git = {
    enable = true; # "Whether to enable Git."
    userName = "gmarmstrong"; # "Default user name to use."
    userEmail = "guthrie.armstrong@gmail.com"; # "Default user email to use."

    signing = { # "Options related to signing commits using GnuPG."
      key = "100B37EAF2164C8B"; # "The default GPG signing key fingerprint."
      signByDefault = true; # "Whether commits should be signed by default."
    };

    # "Additional configuration to add."
    extraConfig = {
      core.editor = "${pkgs.neovim}/bin/nvim";
      commit.gpgsign = true;
      gpg.program = "${pkgs.gnupg}/bin/gpg";
      credential.helper = "cache";
    };

    # "List of paths that should be globally ignored."
    ignores = [
      "secring.*"
      ".ssh/id_rsa"
      ".ssh/id_rsa.pub"
      ".gnupg"
      "*.py[cod]"
      "*.pdf"
      "*.aux"
      "*.lof"
      "*.log"
      "*.lot"
      "*.fls"
      "*.out"
      "*.toc"
      "*.fmt"
      "*.fot"
      "*.cb"
      "*.cb2"
      "*.dvi"
      "*-converted-to.*"
      "*.fdb_latexmk"
      "*.synctex.gz"
      "*.bbl"
      "*.bcf"
      "*.blg"
      "*-blx.aux"
      "*-blx.bib"
      "*.run.xml"
      "*.nav"
      "*.pre"
      "*.snm"
      "*.vrb"
      "*.lol"
      ".fuse_hidden*"
      ".Trash-*"
      ".nfs*"
      "[._]*.s[a-v][a-z]"
      "[._]*.sw[a-p]"
      "[._]s[a-v][a-z]"
      "[._]sw[a-p]"
      "Session.vim"
      ".netrwhist"
      ".viminfo"
      "*~"
      "tags"
      "*.class"
      "*.log"
      "*.ctxt"
      ".mtj.tmp/"
      "*.jar"
      "*.war"
      "*.ear"
      "*.zip"
      "*.tar.gz"
      "*.rar"
      "hs_err_pid*"
      "target/"
      ".idea/"
      "*.iml"
    ];
  };
}
