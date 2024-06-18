{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kubebuilder
    kubectl
    minikube
  ];
}
