{ pkgs, ... }:

let
  # Here we define a specific Python environment.
  # We use python311 and specify a list of packages to install with it.
  # This creates a self-contained Python environment managed by Nix.
  python-with-packages = pkgs.python311.withPackages (ps: with ps; [
    # Jupyter and its kernel are essential for notebooks.
    jupyter
    ipykernel

    # Common libraries for data analysis and machine learning.
    # You can add or remove packages here as needed.
    pandas
    numpy
    matplotlib
    scikit-learn
    seaborn
  ]);
in
{
  # We use the stable-24.05 channel for reproducible package versions.
  channel = "stable-24.05";

  # We install our custom Python environment, a fast search tool, and bash completion.
  packages = [
    python-with-packages
    pkgs.ripgrep # A fast search tool used by language servers to improve performance.
    pkgs.bash-completion # Improves terminal auto-completion.
    pkgs.pyright # A performant language server for fast autocompletion and code analysis.
  ];

  # These VS Code extensions provide excellent support for Python and Jupyter.
  idx = {
    extensions = [
      "ms-python.python"
      "ms-toolsai.jupyter"
    ];
  };
}
