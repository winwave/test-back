# frozen_string_literal: true

class ConvertorService < ApplicationService
  AZ_ARRAY = ('A'..'Z').to_a
  AZ_LENGTH = AZ_ARRAY.length

  def pseudo_to_decimal(pseudo)
    decimal_value = 0
    pseudo.split('').each_with_index do |letter, index|
      power = pseudo.length - index - 1
      decimal_value += letter_to_decimal(letter) * (AZ_LENGTH**power)
    end

    decimal_value
  end

  def decimal_to_pseudo(number)
    pseudo = []
    while number > 0
      index = (number % AZ_LENGTH) - 1
      pseudo << AZ_ARRAY[index]
      number /= AZ_LENGTH
    end

    pseudo.reverse.join
  end

  def letter_to_decimal(letter)
    AZ_ARRAY.index(letter) + 1
  end
end
