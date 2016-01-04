require "rails_helper"

RSpec.describe TicketType, type: :model do
  before (:each) do
    @ticket_type = FactoryGirl.create(:ticket_type)
    @user_ticket = FactoryGirl.create(:user_ticket, ticket_type: @ticket_type)
  end

  describe "#sold" do
    it "returns the number of ticket sold" do
      expect(@ticket_type.sold).to eql 1
    end
  end

  describe "#total_amount_sold" do
    it "returns the amount of ticket sold" do
      expect(@ticket_type.total_amount_sold).to eql 9.99
    end
  end

  describe "#tickets_left" do
    it "returns the number of ticket unsold" do
      expect(@ticket_type.tickets_left).to eql 0
    end
  end






end
#   def sold
#     user_tickets.size
#   end
# 1   def total_amount_sold
#     sold * price.to_f
#   end
# 1   def tickets_left
#     quantity - sold
#   end