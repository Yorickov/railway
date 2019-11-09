require 'modules/validation'

describe Validation do
  before(:context) do
    class User
      include Validation

      @@users = ['Dan']

      validate :name, :presence
      validate :name, :format, /^[a-z0-9\- ]+$/i
      validate :base, :type, Symbol

      def self.all
        @@users
      end

      def initialize(name, base)
        @name = name
        @base = base
        validate!
      end
    end
  end

  it 'presence' do
    @user = User.new('John', :usa)
    expect(@user.valid?).to be_truthy

    expect { User.new('   ', :usa) }
      .to raise_error(ArgumentError, 'You must input smth.')
  end

  it 'format' do
    @user = User.new('Pete', :usa)
    expect(@user.valid?).to be_truthy

    expect { User.new('a_q', :usa) }
      .to raise_error(ArgumentError, 'Invalid format')
  end

  it 'type' do
    @user = User.new('Sam', :usa)
    expect(@user.valid?).to be_truthy

    expect { User.new('xor', 'usa') }
      .to raise_error(TypeError, 'wrong type')
  end
end
