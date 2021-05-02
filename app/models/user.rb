# frozen_string_literal: true

class User < ApplicationRecord
  REGEXP_PSEUDO = /\A[A-Z]+\z/.freeze
  PSEUDO_LENGTH = 3

  validates :pseudo, length: { is: PSEUDO_LENGTH }, format: { with: REGEXP_PSEUDO }

  def generate_new_pseudo
    decimal_index = DecimalSearchService.call
    pseudo = ConvertorService.decimal_to_pseudo(decimal_index)

    update(pseudo: pseudo, decimal_index: decimal_index)
  end

  def generate_decimal_index
    decimal_index = ConvertorService.pseudo_to_decimal(self.pseudo)

    update(decimal_index: decimal_index)
  end
end
