# frozen_string_literal: true

class User < ApplicationRecord
  REGEXP_PSEUDO = /\A[A-Z]+\z/.freeze
  PSEUDO_LENGTH = 3

  include Utils

  validates :pseudo, length: { is: PSEUDO_LENGTH }, format: { with: REGEXP_PSEUDO }

  def find_decimal_index_available
    arr_dec = User.all.pluck(:decimal_index).sort
    if arr_dec.last < MIN_INDEX + arr_dec.length
      return MIN_INDEX + arr_dec.length
    end

    binary_search(arr_dec)
  end

  def create_new_pseudo
    decimal_index = find_decimal_index_available
    pseudo = decimal_to_pseudo(decimal_index)

    update(pseudo: pseudo, decimal_index: decimal_index)
  end

  def add_decimal_index(pseudo)
    decimal_index = pseudo_to_decimal(pseudo)

    update(decimal_index: decimal_index)
  end
end
