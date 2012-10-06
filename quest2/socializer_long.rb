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

def parse_quotes
  ret = []
  File.read("quotes.txt").lines.each_with_index do |line, i|
    if i.even?
      ret << Quote.new(line.chomp, nil)
    else
      ret.last.text = line.chomp
    end
  end
  return ret
end

def parse_jokes
  ret = []
  File.read("jokes.txt").lines.each_with_index do |line, i|
    if i.even?
      ret << Joke.new(line.chomp, nil)
    else
      ret.last.text = line.chomp
    end
  end
  return ret
end

class Quote
  attr_accessor :author, :text

  def initialize(author, text)
    @author = author
    @text =  text
  end
end

class Joke
  attr_accessor :funnycity, :text

  def initialize(funnycity, text)
    @funnycity = funnycity
    @text = text
  end
end


jokes = parse_jokes
quotes = parse_quotes

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
