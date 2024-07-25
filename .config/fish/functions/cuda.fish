function cuda
  echo '{
    pkgs ? import <nixpkgs> {
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
    },
  }:
  pkgs.mkShell {
    name = "cuda-env-shell";
    buildInputs = with pkgs; [
      git
      gitRepo
      gnupg
      autoconf
      curl
      procps
      gnumake
      util-linux
      m4
      gperf
      unzip
      cudatoolkit
      linuxPackages.nvidia_x11
      libGLU
      libGL
      xorg.libXi
      xorg.libXmu
      freeglut
      xorg.libXext
      xorg.libX11
      xorg.libXv
      xorg.libXrandr
      zlib
      ncurses5
      stdenv.cc
      binutils
      python3

      # Project requirements
      python3Packages.torch
      python3Packages.torchvision
      python3Packages.torchaudio
      python3Packages.torchsde
      python3Packages.einops
      python3Packages.transformers
      python3Packages.tokenizers
      python3Packages.sentencepiece
      python3Packages.safetensors
      python3Packages.aiohttp
      python3Packages.pyyaml
      python3Packages.pillow
      python3Packages.scipy
      python3Packages.tqdm
      python3Packages.psutil
      python3Packages.kornia
      python3Packages.soundfile
    ];

    shellHook = \'\'
      export CUDA_PATH=${pkgs.cudatoolkit}
      # export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib
      export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
      export EXTRA_CCFLAGS="-I/usr/include"
    \'\';
  }' > shell.nix
  nix-shell
end
