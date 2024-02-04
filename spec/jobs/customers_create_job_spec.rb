require 'rails_helper'

RSpec.describe CustomersCreateJob, type: :job do
  let(:webhook) { eval(File.read('lib/shopify_data/customers_create.json')).with_indifferent_access }

  describe "#perform" do
    context "when webhook is present" do
      it "calls create_customer method with the webhook" do
        job = CustomersCreateJob.new
        expect(job).to receive(:create_customer).with(webhook)
        job.perform(topic: "customer/create", shop_domain: "example.myshopify.com", webhook: webhook)
      end
    end

    context "when webhook is not present" do
      it "does not call create_customer method" do
        job = CustomersCreateJob.new
        expect(job).not_to receive(:create_customer)
        job.perform(topic: "customer/create", shop_domain: "example.myshopify.com", webhook: nil)
      end
    end
  end

  context ".handle" do
    let(:topic) { "customer/create" }
    let(:shop) { "example.myshopify.com" }

    it "enqueues the job with the correct parameters" do
      expect(CustomersCreateJob).to receive(:perform_later).with(topic: topic, shop_domain: shop, webhook: webhook)
      CustomersCreateJob.handle(topic: topic, shop: shop, body: webhook)
    end
  end
end
