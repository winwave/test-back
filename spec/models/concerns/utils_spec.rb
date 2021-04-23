# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Utils do
  before(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.create_table :utils_tests
  end

  after(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.drop_table :utils_tests
  end

  class UtilsTest < ApplicationRecord
    include Utils
  end

  subject { UtilsTest.new }

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

  describe 'decimal_letter_to' do
    it "should return right decimal for the letter" do
      pseudo = subject.decimal_to_letter(3)

      expect(pseudo).to eq('C')
    end
  end

  describe 'binary_search' do
    it "should return right value available" do
      arr = [703, 704, 707, 709]
      value = subject.binary_search(arr)

      expect(value).to eq(705)
    end
  end
end
