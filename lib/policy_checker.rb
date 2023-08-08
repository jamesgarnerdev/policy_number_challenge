# frozen_string_literal: true

# Module for OCR conversion and policy checking.
module PolicyChecker
  VALID_FORMAT = /^\d{9}$/.freeze
  DIGITS = '0123456789'

  def calculate_checksum(policy_number)
    digits = policy_number.chars.map(&:to_i).reverse
    checksum = digits.each_with_index.sum { |digit, index| (index + 1) * digit } % 11
    checksum.zero?
  end

  def valid_policy_number?(policy_number)
    policy_number.match?(VALID_FORMAT)
  end

  def guess_policy_number(policy_number)
    possible_corrections = generate_possible_corrections(policy_number)
    valid_corrections = possible_corrections.select { |correction| valid_policy_number?(correction) && calculate_checksum(correction) }

    if valid_corrections.empty?
      'ILL'
    elsif valid_corrections.count > 1
      'AMB'
    else
      valid_corrections.first
    end
  end

  private

  def generate_possible_corrections(policy_number)
    corrections = []

    (DIGITS.size - 1).times do |i|
      generate_corrections_for_digit(corrections, policy_number, DIGITS, policy_number[i], i)
    end

    corrections
  end

  def generate_corrections_for_digit(corrections, policy_number, digits, digit, index)
    digits.each_char do |replacement|
      next if digit == replacement

      new_number = policy_number.dup
      new_number[index] = replacement
      corrections << new_number
    end
  end
end
