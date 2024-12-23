{
  # additions
  additions = final: prev: import ../packages final;
  todoist-cli = final: prev: {
    todoist = prev.todoist.overrideAttrs (oldAttrs: {
      patches = [./todoist.patch];
    });
  };
}
