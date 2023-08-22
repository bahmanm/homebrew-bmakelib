# frozen_string_literal: true

class Bmakelib < Formula
  desc "It is a minimalist standard library for writing Makefiles"
  homepage "https://github.com/bahmanm/bmakelib"
  url "https://github.com/bahmanm/bmakelib/releases/download/v0.4.3/bmakelib-0.4.3.tar.gz"
  sha256 "0b8fc6a39333147be53ac61b73c2a46c9b2e9591984eaf8a6af7be8c62261b2a"
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
      assert_equal "0.4.2", shell_output("make -I ${HOMEBREW_PREFIX}/include echo-version").strip
    end
  end
end
