{
  pkgs,
  ...
}:

{
  packages = with pkgs; [
    ruff
    basedpyright
    codecrafters-cli
    redis
  ];

  languages.python = {
    enable = true;
    venv.enable = true;
    uv = {
      enable = true;
      sync = {
        enable = true;
        allGroups = true;
      };
    };
  };

  scripts.dev = {
    description = "run pytest on file src change";
    exec = ''
      fd -tf | entr -c pytest
    '';
    packages = with pkgs; [
      fd
      entr
      python3Packages.pytest
    ];
  };

  # https://devenv.sh/basics/
  enterShell = ''
    echo "========================================="
    echo "| Available commands:                   |"
    echo "|   dev - run pytest on src file change |"
    echo "========================================="
  '';
}
