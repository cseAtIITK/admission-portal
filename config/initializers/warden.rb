require Rails.root.join('lib/warden/strategies/password')

Warden::Strategies.add(:password, PasswordStrategy)
