require "pry"

REGEX = /mul\((\d*),(\d*)\)/

def parse_input
  input = ""

  File.open("input.txt").each do |line|
    input << line
  end

  input
end

def main
  input = parse_input
  tuples = input.scan(REGEX)

  puts tuples.map { |t| t[0].to_i * t[1].to_i }.sum
end

main
