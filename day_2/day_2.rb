def parse_input
  reports = []

  File.open("input.txt").each do |line|
    reports << line.split(" ").map(&:to_i)
  end

  reports
end

def build_changes(report)
  changes = []
  report.each_with_index do |val, i|
    next if i == 0

    prev_val = report[i-1]

    changes << val - prev_val
  end

  changes
end

def is_safe?(report)
  changes = build_changes(report)

  # Check for all increasing or all decreasing
  return false unless changes.all? { |ch| ch.positive? } || changes.all? { |ch| ch.negative? }

  # Check all changes are within 1-3 difference
  return false unless changes.all? { |ch| ch.abs >= 1 && ch.abs <= 3 }

  true
end

def main
  reports = parse_input

  safety_arr = reports.map { |r| is_safe?(r) }

  puts safety_arr.count(true)
end

main
