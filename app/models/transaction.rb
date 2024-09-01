class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', foreign_key: 'source_wallet_id', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', foreign_key: 'target_wallet_id', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :validate_amount
  validate :validate_source

  def validate_amount
    if source_wallet.balance < amount
      errors.add(:base, 'Insufficient amount')
    end
  end

  def validate_source
    if !source_wallet.present? || !target_wallet.present?
      errors.add(:base, 'Both source_wallet and target_wallet must be present')
    end
  end
end
