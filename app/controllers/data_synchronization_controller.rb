class DataSynchronizationController < ApplicationController
  include DataSyncConcern
  before_action :shop_domain

  def all
    update_sync_status
    synchronize_old_data(:customers, :customers_create_job, @shop)
    synchronize_old_data(:products, :products_create_job, @shop)
    synchronize_old_data(:orders, :orders_create_job, @shop)

    redirect_to dashboard_index_path(shop: @shop_domain, sync_notice: 'syncing')
  end

  def product
    synchronize_old_data(:products, :products_create_job, @shop)

    redirect_to descriptions_path(shop: @shop_domain, notice: 'Syncing Products. You should see the products in a while')
  end

  private

  def update_sync_status
    @shop.update(data_sync_status: 'syncing')
  end
end