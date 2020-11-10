FactoryBot.define do
  factory(:checkout) do
    session { {} }
    order { order }
  end
end
