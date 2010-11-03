# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_findfile_session',
  :secret      => '65a36ccc76724e7fd22597a74fad0f931c3b6ee7186a36fb05016a49c214bae5e43cacfcecceee0ed6cfc9b45e0ed0bdcc9a7952b2a7869ec61a4f809f809d77'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
