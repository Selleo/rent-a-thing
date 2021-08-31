require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do
  describe "customer_confirmation" do
    let(:mail) { BookingMailer.customer_confirmation }

    it "renders the headers" do
      expect(mail.subject).to eq("Customer confirmation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "admin_confirmation" do
    let(:mail) { BookingMailer.admin_confirmation }

    it "renders the headers" do
      expect(mail.subject).to eq("Admin confirmation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
