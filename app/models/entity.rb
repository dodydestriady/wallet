class Entity < ApplicationRecord
  self.inheritance_column = :entity_type
  has_secure_password
  has_one :wallet, as: :walletable
end
