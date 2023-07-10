require 'rails_helper'

RSpec.describe "subscriptions/edit", type: :view do
  let(:subscription) {
    Subscription.create!()
  }

  before(:each) do
    assign(:subscription, subscription)
  end

  it "renders the edit subscription form" do
    render

    assert_select "form[action=?][method=?]", subscription_path(subscription), "post" do
    end
  end
end
