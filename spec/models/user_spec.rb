# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }
  describe 'Validations' do
    it "is valid with valid attributes" do
      subject.pseudo = "AAA"

      expect(subject).to be_valid
    end

    it "is invalid with pseudo length greater then 3" do
      subject.pseudo = "AAAA"

      expect(subject).to_not be_valid
    end

    it "is invalid with pseudo has number" do
      subject.pseudo = "AA1"

      expect(subject).to_not be_valid
    end

    it "is invalid with pseudo has number" do
      subject.pseudo = "AA1"

      expect(subject).to_not be_valid
    end

    it "is invalid with pseudo has lowercase letter" do
      subject.pseudo = "AAa"

      expect(subject).to_not be_valid
    end

    it "is invalid with pseudo has special character" do
      subject.pseudo = "AA."

      expect(subject).to_not be_valid
    end
  end

  describe "methods" do
    it "should generate decimal index" do
      subject.pseudo = 'AAA'
      subject.generate_decimal_index

      expect(subject.decimal_index).to eq(703)
    end

    it "should generate new pseudo" do
      User.create(pseudo: 'AAA', decimal_index: 703)
      subject.generate_new_pseudo

      expect(subject.pseudo).to_not be_nil
    end
  end
end
