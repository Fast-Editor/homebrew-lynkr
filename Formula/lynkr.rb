class Lynkr < Formula
  desc "Self-hosted LLM gateway and tier-routing proxy for AI coding tools"
  homepage "https://github.com/Fast-Editor/Lynkr"
  url "https://registry.npmjs.org/lynkr/-/lynkr-9.14.8.tgz"
  sha256 "f197eb856aa49862990a6c35996e510c1bf57881126c9a6b8bccf3cf3b537df2"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/lynkr/latest"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lynkr --version")
  end
end
