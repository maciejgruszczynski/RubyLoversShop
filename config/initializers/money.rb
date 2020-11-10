MoneyRails.configure do |config|
  config.locale_backend = :currency
  config.default_currency = Money::Currency.new("PLN")
  config.include_validations = true
  config.no_cents_if_whole = false
end
