class Cozy < Formula
  desc "A Comfort First terminal editor and pager: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.34"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.34/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "efa8c1a514e993fa3d762971936db93854fbae6af9afdaab359fb742ad543f69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.34/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "7b4d43b39b502fba9e7009b805f8f8b19649d31a4c0cb19505f8f4da5ed1bd01"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.34/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ede423313064156d06ea9c655dd5baeabbb525651d020f52e53ebe47884a3623"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.34/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "537bd84e2ee0625764a2f1f4378a017ea8a542579a59f986ec02fd7132e0455f"
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
