{
  sops = {
    age = {
      keyFile = "/var/lib/private/sops/age/keys.txt";
      generateKey = false;
      sshKeyPaths = [];
    };
    gnupg.sshKeyPaths = [];
  };
}
