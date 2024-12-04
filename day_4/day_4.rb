require "pry"

def parse_input
  input = []

  File.open("input.txt").each do |line|
    input << line.chomp.chars
  end

  input
end

def up(input, y, x)
  return false if y < 3

  if input[y][x] == "X" && input[y-1][x] == "M" && input[y-2][x] == "A" && input[y-3][x] == "S"
    return true
  end

  false
end

def down(input, y, x)
  return false if (input.length - y) < 4

  if input[y][x] == "X" && input[y+1][x] == "M" && input[y+2][x] == "A" && input[y+3][x] == "S"
    return true
  end

  false
end

def right(input, y, x)
  return false if (input[0].length - x) < 4

  if input[y][x] == "X" && input[y][x+1] == "M" && input[y][x+2] == "A" && input[y][x+3] == "S"
    return true
  end

  false
end

def left(input, y, x)
  return false if x < 3

  if input[y][x] == "X" && input[y][x-1] == "M" && input[y][x-2] == "A" && input[y][x-3] == "S"
    return true
  end

  false
end

def up_left(input, y, x)
  return false if x < 3 || y < 3

  if input[y][x] == "X" && input[y-1][x-1] == "M" && input[y-2][x-2] == "A" && input[y-3][x-3] == "S"
    return true
  end

  false
end

def up_right(input, y, x)
  return false if (input[0].length - x) < 4 || y < 3

  if input[y][x] == "X" && input[y-1][x+1] == "M" && input[y-2][x+2] == "A" && input[y-3][x+3] == "S"
    return true
  end

  false
end

def down_left(input, y, x)
  return false if (input.length - y) < 4 || (input.length - y) < 4 || x < 3

  if input[y][x] == "X" && input[y+1][x-1] == "M" && input[y+2][x-2] == "A" && input[y+3][x-3] == "S"
    return true
  end

  false
end

def down_right(input, y, x)
  return false if (input[0].length - x) < 4 || (input.length - y) < 4

  if input[y][x] == "X" && input[y+1][x+1] == "M" && input[y+2][x+2] == "A" && input[y+3][x+3] == "S"
    return true
  end

  false
end

def num_xmas(input, y, x)
  total = 0

  total += 1 if up(input, y, x)
  total += 1 if down(input, y, x)
  total += 1 if right(input, y, x)
  total += 1 if left(input, y, x)
  total += 1 if up_right(input, y, x)
  total += 1 if up_left(input, y, x)
  total += 1 if down_right(input, y, x)
  total += 1 if down_left(input, y, x)

  total
end

def main
  input = parse_input

  total = 0
  input.each_with_index do |a, y|
    a.each_with_index do |b, x|
      if b == "X"
        num = num_xmas(input, y, x)

        total += num
      end
    end
  end

  puts total
end

main
