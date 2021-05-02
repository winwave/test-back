# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConvertorService do
  subject { described_class.new }

  describe 'pseudo_to_decimal' do
    it "should return right decimal" do
      decimal = subject.pseudo_to_decimal("AAA")

      expect(decimal).to eq(703)
    end
  end

  describe 'decimal_to_pseudo' do
    it "should return right pseudo" do
      pseudo = subject.decimal_to_pseudo(703)

      expect(pseudo).to eq("AAA")
    end
  end

  describe 'letter_to_decimal' do
    it "should return right decimal for the letter" do
      pseudo = subject.letter_to_decimal('C')

      expect(pseudo).to eq(3)
    end
  end
end
