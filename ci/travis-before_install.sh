# Pre-installation script for Linux/macOS CI on Travis

# Download files into the cache directory
maybe_download () {
  if [ ! -x $CACHE/$2 ]; then
    curl $1 --output $CACHE/$2 --remote-time --time-cond $CACHE/$2
  else
    curl $1 --output $CACHE/$2 --remote-time
  fi
  chmod +x $CACHE/$2
}

maybe_download $GAMSURL $GAMSFNAME
maybe_download $CONDAURL $CONDAFNAME


# Install R packages needed for testing
Rscript -e "install.packages(c('devtools', 'IRkernel'), lib = '$R_LIBS_USER')"
Rscript -e "devtools::install_dev_deps('rixmp')"

# Install graphiz on OS X (requires updating homebrew)
if [ `uname` = "Darwin" ];
then
  brew update
  brew install graphviz
fi
