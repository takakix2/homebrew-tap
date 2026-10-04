class Cozy < Formula
  desc "A Comfort First terminal editor and pager: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.35"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.35/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "aa3e1cfd49d0d3ae8c78be8a062a15a6d567a9a6139b38c386ca26a379f42029"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.35/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "3e8188c28e2d27172ebe55d57464959725ae318f1ecb16b6917261336e2026f8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.35/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8debf25a0abd6980af6ec8678d6ee9846ddeeaabbe1c5b22bc6b5935f745f227"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.35/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9b1d1ba870fe6b7d3f4db13bf2e5a7db14af46163dc47f37a2a93e60b4ad5a41"
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
