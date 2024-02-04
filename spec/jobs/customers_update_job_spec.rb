require 'rails_helper'

RSpec.describe CustomersUpdateJob, type: :job do
  let(:webhook) { eval(File.read('lib/shopify_data/customers_update.json')).with_indifferent_access }

  describe "#perform" do
    context "when webhook is present" do
      it "calls update_customer method with the webhook" do
        job = CustomersUpdateJob.new
        expect(job).to receive(:update_customer).with(webhook)
        job.perform(topic: "customer/update", shop_domain: "example.myshopify.com", webhook: webhook)
      end
    end

    context "when webhook is not present" do
      it "does not call update_customer method" do
        job = CustomersUpdateJob.new
        expect(job).not_to receive(:update_customer)
        job.perform(topic: "customer/update", shop_domain: "example.myshopify.com", webhook: nil)
      end
    end
  end

  describe ".handle" do
    let(:topic) { "customer/update" }
    let(:shop) { "example.myshopify.com" }

    it "enqueues the job with the correct parameters" do
      expect(CustomersUpdateJob).to receive(:perform_later).with(topic: topic, shop_domain: shop, webhook: webhook)
      CustomersUpdateJob.handle(topic: topic, shop: shop, body: webhook)
    end
  end
end
