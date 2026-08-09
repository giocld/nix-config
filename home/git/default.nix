{...}: {
  programs = {
    git = {
      enable = true;

      userEmail = "gio@localhost";
      userName = "gio";
    };

    git-credential-oauth = {
      enable = true;
    };

    lazygit = {
      enable = true;
    };
  };
}
