# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/main'

RSpec.describe MainApp do
  let(:app) { MainApp.new }

  describe '#main' do
    context 'when given valid input' do
      it 'processes entries and writes output' do
        input_file = 'spec/fixtures/sample_test.txt'
        output_file = 'policy_results.txt'
        entries = [
          ['123456789', '', '', ''],
          ['987654321', '', '', '']
        ]
        processed_entries = %w[123456789 987654321]

        expect(File).to receive(:readlines).with(input_file).and_return(entries.flatten)
        expect(app).to receive(:process_entries).with(entries).and_return(processed_entries)
        expect(app).to receive(:write_output).with(processed_entries, output_file)

        app.main(input_file, output_file)
      end
    end

    context 'when input contains invalid entries' do
      it 'handles invalid entries and processes remaining entries' do
        input_file = 'spec/fixtures/sample_test.txt'
        output_file = 'policy_results.txt'
        entries = [
          ['123456789', '', '', ''],
          ['987654321', '', '', ''],
          ['1234x6789', '', '', ''],
          ['543210987', '', '', '']
        ]
        processed_entries = ['123456789', '987654321', '?23456789', '543210987']

        expect(File).to receive(:readlines).with(input_file).and_return(entries.flatten)
        expect(app).to receive(:process_entries).with(entries).and_return(processed_entries)
        expect(app).to receive(:write_output).with(processed_entries, output_file)

        app.main(input_file, output_file)
      end
    end

    context 'when input is empty' do
      it 'does not process anything and writes an empty output' do
        input_file = 'spec/fixtures/empty_test.txt'
        output_file = 'policy_results.txt'
        entries = []

        expect(File).to receive(:readlines).with(input_file).and_return(entries)
        expect(app).to receive(:write_output).with([], output_file)

        app.main(input_file, output_file)
      end
    end
  end
end
