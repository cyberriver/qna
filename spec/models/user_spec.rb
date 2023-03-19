require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of :email }
  it {should validate_presence_of :password } 
  
  it { should have_many(:comments).dependent(:destroy) }

  
  it { should validate_presence_of :provider }
  it { should validate_presence_of :uid }

end
