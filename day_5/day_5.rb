require "pry"

# Rules are tuples, [0] must come before [1]
# Updates are lists of integers to compare with the rules
def parse_input
  rules = []
  updates = []

  File.open("input.txt").each do |line|
    if line.include?("|")
      rules << line.split("|").map(&:chomp).map(&:to_i)
    elsif line.include?(",")
      updates << line.split(",").map(&:chomp).map(&:to_i)
    end
  end

  [rules, updates]
end

def is_valid?(rule, update)
  update.each do |num|
    if num == rule[0]
      return true
    elsif num == rule[1] && update.include?(rule[0])
      puts "Fail: Rule: #{rule}. Update: #{update}"
      return false
    end
  end

  true
end

# Brute force ¯\_(ツ)_/¯
def all_valid?(rules, update)
  rules.all? { |rule| is_valid?(rule, update) }
end

def main
  rules, updates = parse_input

  valid_updates = updates.map { |update| all_valid?(rules, update) ? update : nil }.compact

  total = valid_updates.map { |update| update[update.length / 2] }.sum

  puts total
end

main
