class Generators
  def cart_identifier
    SecureRandom.base58(8).upcase
  end
end
