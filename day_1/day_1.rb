def generate_lists
  left = []
  right = []
  File.open("input.txt").each do |line|
    thing = line.split("  ")
    thing = thing.map(&:chomp).map(&:strip).map(&:to_i)

    left << thing.first
    right << thing.last
  end

  left.sort!
  right.sort!

  [left, right]
end

def distance(left, right)
  (left - right).abs
end

def main
  left, right = generate_lists

  distances = []
  left.length.times do |index|
    distances << distance(left[index], right[index])
  end

  puts "Sum of Distances: #{distances.sum}"
end

main
