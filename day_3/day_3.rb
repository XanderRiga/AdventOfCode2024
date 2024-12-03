require "pry"

REGEX = /mul\((\d*),(\d*)\)/

def parse_input
  input = ""

  File.open("input.txt").each do |line|
    input << line
  end

  input
end

def next_lowest(current_val, list)
  list.each do |val|
    return val if val > current_val
  end

  nil
end

def relevant_spans(input)
  do_indices = input.enum_for(:scan, /(?=do\(\))/).map do
    Regexp.last_match.offset(0).first
  end
  do_indices.unshift(0)
  dont_indices = input.enum_for(:scan, /(?=don't\(\))/).map do
    Regexp.last_match.offset(0).first
  end

  relevant_spans = []
  current_val = 0
  while true
    break if current_val.nil?

    new_val = next_lowest(current_val, dont_indices)

    if new_val.nil?
      relevant_spans << [current_val, -1]
      break
    end

    relevant_spans << [current_val, new_val]

    current_val = next_lowest(new_val, do_indices)
  end

  relevant_spans
end

def valid_input(input)
  text = ""

  relevant_spans(input).each do |t|
    text << input[t[0]..t[1]]
  end

  text
end

def main
  input = valid_input(parse_input)

  binding.pry

  tuples = input.scan(REGEX)
  puts tuples.map { |t| t[0].to_i * t[1].to_i }.sum
end

main
