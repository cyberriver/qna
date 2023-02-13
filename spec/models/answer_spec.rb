require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question}
  it { should have_many(:links).dependent(:destroy) }
  
  it { should validate_presence_of :title}

  it { should accept_nested_attributes_for :links }
end
