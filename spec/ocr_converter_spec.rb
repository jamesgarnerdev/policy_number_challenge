# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/ocr_converter'

RSpec.describe OcrConverter do
  include OcrConverter

  describe '#convert_to_ocr' do
    it 'converts a digit to OCR representation' do
      expect(convert_to_ocr('0')).to eq(" _ \n| |\n|_|")
    end
  end

  describe '#convert_row' do
    it 'converts a row of digits to OCR representation' do
      digits = '123'
      expect(convert_to_ocr(digits)).to eq("    _  _ \n  | _| _|\n  ||_  _|")
    end

    it 'handles invalid digit' do
      row = '123'
      digits = {
        '1' => '    _  _ ',
        '2' => '  |  | _|',
        '3' => '  ||_  _|'
      }
      expected_ocr_row = '    _  _   | _| _|  ||_  _|'

      converted_ocr_row = convert_row(row, digits, 0)
      expect(converted_ocr_row).not_to eq(expected_ocr_row)
    end
  end
end
