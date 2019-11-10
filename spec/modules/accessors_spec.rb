require 'modules/accessors'

describe Accessors do
  before(:context) do
    class User
      extend Accessors

      attr_accessor_with_history :name, :surname
      strong_attr_accessor :id, Symbol
    end
  end

  it 'attr_accessor_with_history' do
    @user = User.new

    @user.name = 'John'
    @user.surname = 'Doe'
    @user.name = 'Sarah'

    expect(@user.name).to eql('Sarah')
    expect(@user.surname).to eql('Doe')
    expect(@user.name_history).to eql(%w[John])
  end

  it 'strong_attr_accessor' do
    @tester = User.new
    @tester.id = :Pete

    expect(@tester.id).to eql(:Pete)

    expect { @tester.id = 'Sam' }
      .to raise_error(TypeError, 'Wrong type')
  end
end
