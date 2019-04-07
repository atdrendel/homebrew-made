class SwiftSh < Formula
  desc "Scripting with easy zero-conf dependency imports"
  homepage "https://github.com/mxcl/swift-sh"
  url "https://github.com/mxcl/swift-sh/archive/1.10.0.tar.gz"
  sha256 "b09cecc5d2f7076ee836c7813217a71746a76281ccd0cfc2b7ab927763e4ab56"

  bottle :disabled
   
  def install
    args = ["swift", "build", 
      "--configuration", "release",
      "--disable-sandbox"]
    args += ["-Xswiftc", "-static-stdlib"] unless swift_abi_safe or OS.linux?

    system *args

    bin.install '.build/release/swift-sh'
    bin.install '.build/release/swift-sh-edit' if OS.mac?
  end

  def swift_abi_safe
    # Swift 5 is ABI safe since Xcode 10.2-beta3
    return false unless OS.mac?
    `swift --version` =~ /Swift version (\d+)\.\d+/
    $1.to_i >= 5
  end
end
