{
  # additions
  additions = final: prev: import ../packages final;
  todoist-cli = final: prev: {
    todoist = prev.todoist.overrideAttrs (oldAttrs: {
      patches = [./todoist.patch];
    });
  };

  changedetection = final: prev: {
    changedetection-io = prev.changedetection-io.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [prev.python3.pkgs.extruct];
    });
  };
}
