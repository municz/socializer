#!/usr/bin/env ruby

require 'optparse'

options = {}

parser = OptionParser.new do |opts|
  opts.on("-j", "--jokes") { options[:jokes] = true }
  opts.on("-f", "--funniest COUNT") { |val| options[:funniest] = val }
  opts.on("-q", "--quotes") { options[:quotes] = true }
  opts.on("-a", "--author AUTHOR") { |val| options[:author] = val }
  opts.on("-s", "--share SERVICE") { |val| options[:share] = val }
  opts.on("-u", "--user USER") { |val| options[:user] = val }
end
parser.parse!

p options
