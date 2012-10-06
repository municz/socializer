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

def parse_file(file, &block)
  File.read(file).lines.each_slice(2).map(&block)
end

class Quote < Struct.new(:author, :text); end

class Joke < Struct.new(:funnycity, :text); end

jokes = parse_file("jokes.txt") do |(funnycity, text)|
  Joke.new(funnycity.to_i, text)
end

quotes = parse_file("quotes.txt") { |args| Quote.new(*args) }

if count = options[:funniest]
  jokes = jokes.sort_by(&:funnycity).reverse.take(count.to_i)
end

if author = options[:author]
  quotes = quotes.find_all { |q| q.author == author }
end

if options[:quotes]
  quotes.each do |quote|
    puts quote.text
    puts "- #{quote.author}"
    puts
  end
end

if options[:jokes]
  jokes.each do |joke|
    puts joke.text
    puts
  end
end
