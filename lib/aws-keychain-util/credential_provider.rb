require 'keychain'

module AwsKeychainUtil
  class CredentialProvider
    include AWS::Core::CredentialProviders::Provider

    def initialize(item = 'AWS', keychain = nil)
      @item, @keychain = item, keychain
    end

    def get_credentials
      keychain = @keychain ? Keychain.open(@keychain) : Keychain.default
      item = keychain.generic_passwords.where(:label => @item).first
      {
        access_key_id: item.attributes[:account],
        secret_access_key: item.password
      }
    end
  end
end
