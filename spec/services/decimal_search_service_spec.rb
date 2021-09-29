# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DecimalSearchService do
  subject { described_class.new }
  describe 'call' do
    it "should find decimal index available" do
      User.create(pseudo: 'AAA', decimal_index: 703)
      dec_index = subject.send(:call)

      expect(dec_index).to_not eq(703)
    end
  end

  describe 'binary_search' do
    it "should return right value available" do
      arr = [703, 704, 707, 709]
      value = subject.send(:binary_search, arr)

      expect(value).to eq(705)
    end
  end
end
