# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/policy_ocr'

RSpec.describe PolicyOcr do
  include PolicyOcr

  let(:input_file) { 'input.txt' }
  let(:output_file) { 'output.txt' }

  context 'extract_digit' do
    it 'extracts a digit from entry lines' do
      entry_lines = [
        ' _ | ||_|',
        '     |  |',
        ' _  _||_ '
      ]
      expect(extract_digit(entry_lines, 0)).to eq(' _     _ ')
    end
  end

  context 'convert_and_write_ocr_to_file' do
    it 'converts and writes OCR digits to a file' do
      input_lines = %w[123 ERR]
      allow(File).to receive(:write)
      expect { convert_and_write_ocr_to_file(input_lines, output_file) }.not_to raise_error
    end
  end

  context 'read_input_entries' do
    it 'reads and groups input entries from a file' do
      allow(File).to receive(:readlines).and_return(['entry1', 'entry2', '', 'entry3'])
      expect(read_input_entries(input_file)).to eq([['entry1', 'entry2', '', 'entry3']])
    end
  end

  context 'process_entries' do
    it 'processes entries and returns processed results' do
      allow(self).to receive(:process_entry).and_return('123', 'ERR', '456')
      entries = [['entry1'], ['entry2'], ['entry3']]
      expect(process_entries(entries)).to eq(%w[123 ERR 456])
    end
  end

  context 'determine_status' do
    it 'returns ILL status for invalid policy number' do
      expect(determine_status('invalid')).to eq('ILL')
    end

    it 'returns ERR status for valid policy number with incorrect checksum' do
      allow(self).to receive(:calculate_checksum).and_return(false)
      expect(determine_status('123456789')).to eq('ERR')
    end

    it 'returns empty status for valid policy number with correct checksum' do
      allow(self).to receive(:calculate_checksum).and_return(true)
      expect(determine_status('123456789')).to eq('')
    end
  end
end
