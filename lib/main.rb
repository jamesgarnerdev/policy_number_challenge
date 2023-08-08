# frozen_string_literal: true

require_relative 'policy_ocr'

# Define a class to encapsulate your main logic
class MainApp
  include PolicyOcr

  def main(input_file, output_file)
    entries = read_input_entries(input_file)
    processed_entries = process_entries(entries)
    write_output(processed_entries, output_file)
  end
end

app = MainApp.new
input_file = '../spec/fixtures/sample_test.txt'
output_file = 'policy_results.txt'
app.main(input_file, output_file)
