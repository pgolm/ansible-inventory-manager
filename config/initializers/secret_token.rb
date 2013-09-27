# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
AnsibleWebInventory::Application.config.secret_key_base = 'dd5cf96537bb982629e7c67bbf4ac027393621ebadf5582ccd1d33ae4e7c909dec39ecc873d9b5f33f5d2e9fd91eab19b13994bec52c7383afc60b39096a021e'
