require 'rails_helper'

RSpec.describe "subscriptions/show", type: :view do
  before(:each) do
    assign(:subscription, Subscription.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
