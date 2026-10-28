class Lynkr < Formula
  desc "Self-hosted LLM gateway and tier-routing proxy for AI coding tools"
  homepage "https://github.com/Fast-Editor/Lynkr"
  url "https://registry.npmjs.org/lynkr/-/lynkr-9.14.25.tgz"
  sha256 "9ff8af851be66555302f5109d23eda596f58fa01c695cc82265dd44559bf9ed1"
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
