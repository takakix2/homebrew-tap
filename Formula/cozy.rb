class Cozy < Formula
  desc "A Comfort First terminal editor and pager: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.33"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.33/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "36650eaec95e5bd1a745964d3722bb4df57d30e9372b42289da9852e19973eb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.33/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "684cb053c61a0092eaa493ce72c670933553946ed063e022bf9eb9da8f5a8281"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.33/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b69b972d5564cce73f0f28cd72fda4e2eb617ef12d2673dfb891307c87b4a4a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.33/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e7f8bd654c0a00bc97ed69157f8782bcefb123822a0ac77ef3a9f1f19c6a00da"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cozy", "czv"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cozy", "czv"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cozy", "czv"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cozy", "czv"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
