# frozen_string_literal: true

class Bmakelib < Formula
  desc "It is a minimalist standard library for writing Makefiles"
  homepage "https://github.com/bahmanm/bmakelib"
  url "https://github.com/bahmanm/bmakelib/releases/download/v0.4.2/bmakelib-0.4.2.tar.gz"
  sha256 "19a1aa3b012847352cff2f01a910c6a6a70418cfddb83d10588939aee2b88cd2"
  license "Apache-2.0"

  depends_on "bash" => [:build, :test]
  depends_on "make" => [:build, :test]
  depends_on "perl" => [:build, :test]

  depends_on "bash"
  depends_on "make"
  depends_on "perl"

  def install
    ENV["PATH"] = ENV["HOMEBREW_PREFIX"] + "/opt/make/libexec/gnubin:" + ENV["PATH"]
    system "echo $PATH"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    mktemp("bmakelib") do
      File.write(
        "Makefile",
        [
          "include bmakelib/bmakelib.mk",
          "PHONY:echo-version",
          "echo-version:",
          "\t@echo $(bmakelib.VERSION)",
        ].join("\n"),
      )
      ENV["PATH"] = "#{prefix}/opt/make/libexec/gnubin:" + ENV["PATH"]
      assert_equal "0.4.1", shell_output("make -I ${HOMEBREW_PREFIX}/include echo-version").strip
    end
  end
end
