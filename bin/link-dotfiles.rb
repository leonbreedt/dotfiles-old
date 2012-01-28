#!/usr/bin/env ruby
# link dotfiles into $HOME

require 'pathname'
require 'optparse'

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"
  opts.separator "Options:"
  opts.on("-f", "--force", "Always replace existing files/links")
end
parser.parse!

def link(source, dest, force=false)
  if File.symlink?(dest) || File.exists?(dest)
    if force || File.symlink?(dest)
      puts "removing #{dest}"
      File.unlink(dest)
    end
  end
  if File.exists?(dest)
    abort("error: #{dest} already exists, and is not a symlink")
  end
  File.symlink(source, dest)
  puts "linked #{dest}"
end

dir = File.dirname(File.dirname(File.realpath(__FILE__)))
entries = Dir.entries(dir).reject{|e| e[0] == '.' || e == 'README'}
entries.each do |fn|
  source = File.join(dir, fn)
  dest = File.join(ENV['HOME'], ".#{fn}")
  link(source, dest)
end
