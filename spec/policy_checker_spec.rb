# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/policy_checker'

RSpec.describe PolicyChecker do
  include PolicyChecker

  context 'calculate_checksum' do
    it 'returns true for valid checksum' do
      expect(calculate_checksum('123456789')).to be_truthy
    end

    it 'returns false for invalid checksum' do
      expect(calculate_checksum('123456788')).to be_falsy
    end
  end

  context 'valid_policy_number?' do
    it 'returns true for valid policy number' do
      expect(valid_policy_number?('123456789')).to be_truthy
    end

    it 'returns false for invalid policy number' do
      expect(valid_policy_number?('12345A789')).to be_falsy
    end
  end

  context 'guess_policy_number' do
    it 'returns "ILL" for no valid corrections' do
      expect(guess_policy_number('12A4?6789')).to eq('ILL')
    end

    it 'returns "AMB" for multiple valid corrections' do
      expect(guess_policy_number('444444444')).to eq('AMB')
    end

    it 'returns a valid correction for a single valid correction' do
      expect(guess_policy_number('12?456789')).to eq('123456789')
    end
  end

  context 'generate_possible_corrections' do
    it 'generates possible corrections for a policy number' do
      corrections = generate_possible_corrections('12A45678?')
      expect(corrections).to include('12045678?')
      expect(corrections).to include('12945678?')
    end
  end

  context 'generate_corrections_for_digit' do
    it 'generates corrections for a digit' do
      corrections = []
      generate_corrections_for_digit(corrections, '12?45678?', '0123456789', 'A', 2)
      expect(corrections).to include('12045678?')
      expect(corrections).to include('12945678?')
    end
  end
end
