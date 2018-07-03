{
  webserver =
    { config, pkgs, ... }:
    {
      deployment.targetEnv = "virtualbox";
      deployment.virtualbox.memorySize = 1024;
      deployment.virtualbox.vcpu = 2;
    };
}
