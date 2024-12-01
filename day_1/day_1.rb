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

def similarity_score(left_num, right_tally)
  left_num * right_tally.fetch(left_num, 0)
end

def main
  left, right = generate_lists

  distances = []
  similarity_scores = []
  left.length.times do |index|
    distances << distance(left[index], right[index])
    similarity_scores << similarity_score(left[index], right.tally)
  end

  puts "Sum of Distances: #{distances.sum}"
  puts "Sum of Similarity Scores: #{similarity_scores.sum}"
end

main
