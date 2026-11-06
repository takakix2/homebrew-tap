class Cozy < Formula
  desc "A Comfort First terminal editor and pager: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.38"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.38/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "cb5b59c6630b6b8f3d337e6a99812456d545a9e3cef97b68c238882bea520ae8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.38/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "76aca9ceedbb8a0bcef80a1918da2bef4dee96ef9027c42469a66ed323d3510d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.38/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "242147e887788f012ee8fb5ee81bd3cfb4f6b7f701ec1efb5a77f22dfe9b7f6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.38/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2b6ea36237585bcde17b0c23d217a82674d4aa0a36f0915fdf9e91ca732587e"
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
