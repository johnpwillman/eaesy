# Eaesy

Eaesy is a gem for quickly encrypting and decrypting a string value using the AES 256 CBC algorithm. All encrypted values and initialization vectors are string-representations of binary values for ease of use.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eaesy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eaesy

## Usage

### Encrypt a string

Without existing Initialization Vector

```ruby
eaesy = Eaesy::Cipher.new('YOUR_ENCRYPTION_KEY')
enc_hash = eaesy.encrypt('SOME_STRING')
encrypted_text = enc_hash[:encrypted_secret]
initialization_vector = enc_hash[:iv]
```

With existing Initialization Vector

```ruby
eaesy = Eaesy::Cipher.new('YOUR_ENCRYPTION_KEY')
enc_hash = eaesy.encrypt('SOME_STRING', initialization_vector)
encrypted_text = enc_hash[:encrypted_secret]
```

>Don't forget to store the initialization vector for later decrypting!

### Decrypt a previously encrypted value

```ruby
eaesy = Eaesy::Cipher.new('YOUR_ENCRYPTION_KEY')
decrypted_text = eaesy.decrypt(encrypted_text, initialization_vector)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johnpwillman/eaesy.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
