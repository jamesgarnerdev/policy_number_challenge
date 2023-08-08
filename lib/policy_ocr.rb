# frozen_string_literal: true

require_relative 'ocr_converter'
require_relative 'policy_checker'

# Module for OCR conversion and policy checking.
module PolicyOcr
  include OcrConverter
  include PolicyChecker

  INPUT_LINE_COUNT = 4
  DIGIT_ROW_LENGTH = 3
  POLICY_NUMBER_TOTAL_SIZE = 27
  OCR_TO_DIGITS = {
    ' _ | ||_|' => '0',
    '     |  |' => '1',
    ' _  _||_ ' => '2',
    ' _  _| _|' => '3',
    '   |_|  |' => '4',
    ' _ |_  _|' => '5',
    ' _ |_ |_|' => '6',
    ' _   |  |' => '7',
    ' _ |_||_|' => '8',
    ' _ |_| _|' => '9'
  }.freeze

  def read_input_entries(input_file)
    File.readlines(input_file).map(&:chomp).each_slice(INPUT_LINE_COUNT).to_a
  end

  def process_entries(entries)
    entries.map { |entry| process_entry(entry) }
  end

  def write_output(output_lines, output_file)
    convert_and_write_ocr_to_file(output_lines, output_file)
  end

  private

  def extract_digit(entry_lines, index)
    digit_row = ''
    DIGIT_ROW_LENGTH.times do |row|
      digit_row += entry_lines[row][index, DIGIT_ROW_LENGTH]
    end
    digit_row
  end

  def convert_and_write_ocr_to_file(input_lines, output_file)
    output_lines = input_lines.map do |line|
      if %w[ERR ILL AMB].include?(line)
        line
      else
        convert_to_ocr(line)
      end
    end

    File.write(output_file, output_lines.join("\n"))
  end

  def process_entry(entry)
    policy_number = parse_entry(entry)
    status = determine_status(policy_number)
    %w[ERR ILL].include?(status) ? guess_policy_number(policy_number) : policy_number.to_s
  end

  def determine_status(policy_number)
    valid = valid_policy_number?(policy_number)
    return 'ILL' unless valid

    return 'ERR' unless calculate_checksum(policy_number)

    ''
  end

  def parse_entry(entry_lines)
    extract_policy_number(entry_lines, OCR_TO_DIGITS)
  end

  def extract_policy_number(entry_lines, digits)
    policy_number = ''
    (0..(POLICY_NUMBER_TOTAL_SIZE - 1)).step(DIGIT_ROW_LENGTH) do |i|
      digit = extract_digit(entry_lines, i)
      policy_number += digits[digit] || '?'
    end
    policy_number
  end
end
