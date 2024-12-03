require "pry"

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

def is_p1_safe?(changes)
  return true if (changes.all? { |ch| ch.positive? } || changes.all? { |ch| ch.negative? }) &&
    changes.all? { |ch| ch.abs >= 1 && ch.abs <= 3 }

  false
end

def first_problem_index(changes, report)
  changes.each_with_index do |v, i|
    prev_changes = changes[0...i]

    return i if v.abs > 3 || v.abs < 1

    next if prev_changes == []

    if prev_changes.all?(&:positive?)
      return i if v.negative?
    elsif prev_changes.all?(&:negative?)
      return i if v.positive?
    end
  end
end

def is_safe?(report)
  changes = build_changes(report)

  if is_p1_safe?(changes)
    puts "Safe with no changes: report: #{report}, changes: #{changes}"
    return true
  end

  index = first_problem_index(changes, report)

  report_1 = report.dup
  report_2 = report.dup
  report_3 = report.dup

  report_1.delete_at(index)
  report_2.delete_at(index + 1)
  report_3.delete_at(index - 1)
  changes_1 = build_changes(report_1)
  changes_2 = build_changes(report_2)
  changes_3 = build_changes(report_3)

  if is_p1_safe?(changes_1)
    puts "Changes 1 SAFE: report: #{report}, changes: #{changes}, changes_1: #{changes_1}"
    return true
  end
  if is_p1_safe?(changes_2)
    puts "Changes 2 SAFE: report: #{report}, changes: #{changes}, changes_2: #{changes_2}"
    return true
  end
  if is_p1_safe?(changes_3)
    puts "Changes 3 SAFE: report: #{report}, changes: #{changes}, changes_3: #{changes_3}"
    return true
  end

  puts "UNSAFE: report: #{report}, changes: #{changes}"
  false
end

def main
  reports = parse_input

  safety_arr = reports.map { |r| is_safe?(r) }

  puts safety_arr.count(true)
end

main
