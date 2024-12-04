require "pry"

def parse_input
  input = []

  File.open("input.txt").each do |line|
    input << line.chomp.chars
  end

  input
end

def up_left(input, y, x)
  if (input[y-1][x-1] == "M" && input[y+1][x+1] == "S") || (input[y-1][x-1] == "S" && input[y+1][x+1] == "M")
    return true
  end

  false
end

def up_right(input, y, x)
  if (input[y+1][x-1] == "M" && input[y-1][x+1] == "S") || (input[y+1][x-1] == "S" && input[y-1][x+1] == "M")
    return true
  end

  false
end

def is_xmas?(input, y, x)
  return false if y == 0 || x == 0 || y == input.length - 1 || x == input[0].length - 1

  up_left(input, y, x) && up_right(input, y, x)
end

def main
  input = parse_input

  total = 0
  input.each_with_index do |a, y|
    a.each_with_index do |b, x|
      if b == "A"
        total += 1 if is_xmas?(input, y, x)
      end
    end
  end

  puts total
end

main
