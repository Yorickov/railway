require 'modules/validation'

describe Validation do
  before(:context) do
    class User
      include Validation

      validate :name, :presence

      def initialize(name)
        @name = name
        validate!
      end
    end
  end

  it 'presence' do
    @user = User.new('John')
    expect(@user.valid?).to be_truthy

    expect { User.new('   ') }
      .to raise_error(ArgumentError, 'You must input smth.')
  end
end
