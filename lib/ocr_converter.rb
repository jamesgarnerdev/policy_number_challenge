# frozen_string_literal: true

# Module for OCR conversion and policy checking.
module OcrConverter
  OCR_DIGIT_COLUMN_LENGTH = 3
  DIGITS_TO_OCR = {
    '0' => " _ \n| |\n|_|",
    '1' => "   \n  |\n  |",
    '2' => " _ \n _|\n|_ ",
    '3' => " _ \n _|\n _|",
    '4' => "   \n|_|\n  |",
    '5' => " _ \n|_ \n _|",
    '6' => " _ \n|_ \n|_|",
    '7' => " _ \n  |\n  |",
    '8' => " _ \n|_|\n|_|",
    '9' => " _ \n|_|\n _|"
  }.freeze

  def convert_to_ocr(digit)
    ocr_digit = ''
    OCR_DIGIT_COLUMN_LENGTH.times do |row|
      ocr_digit += "#{convert_row(digit, DIGITS_TO_OCR, row)}\n"
    end
    ocr_digit.chomp
  end

  private

  def convert_row(digit, digits, row)
    digit.chars.map { |num| digits[num].split("\n")[row] }.join
  end
end
