class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :credit_transactions, class_name: 'Transaction', foreign_key: :source_wallet_id, dependent: :destroy
  has_many :debit_transactions, class_name: 'Transaction', foreign_key: :target_wallet_id, dependent: :destroy

  def transactions
    Transaction.where('source_wallet_id = ? OR target_wallet_id = ?', id, id)
  end

  def balance
    debit = debit_transactions.sum(:amount)
    credit = credit_transactions.sum(:amount)

    debit - credit
  end
end
