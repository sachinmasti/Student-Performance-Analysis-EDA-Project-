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

  # The only package we need to install directly is our custom Python environment.
  packages = [
    python-with-packages
  ];

  # These VS Code extensions provide excellent support for Python and Jupyter.
  idx = {
    extensions = [
      "ms-python.python"
      "ms-toolsai.jupyter"
    ];
  };
}