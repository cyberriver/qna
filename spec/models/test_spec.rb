require 'rails_helper'

RSpec.describe Test, type: :model do
  it { should have_many :questions}
  
  it { should validate_presence_of :title}
end
