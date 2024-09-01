class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', foreign_key: 'source_wallet_id', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', foreign_key: 'target_wallet_id', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }

  def validate_transfer
    if amount < source_wallet.balance
      errors.add(:base, 'Insufficient funds')
    end
  end

  def validate_withdraw
    if source_wallet.nil? && target_wallet.nil?
      errors.add(:base, 'Either source_wallet or target_wallet must be present')
    elsif source_wallet.present? && target_wallet.present?
      errors.add(:base, 'Both source_wallet and target_wallet cannot be present')
    end
  end
end
