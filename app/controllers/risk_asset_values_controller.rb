class RiskAssetValuesController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved
  before_filter :ensure_admin  
  
  
  def new
    @asset_value = RiskAssetValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @asset_value }
    end
  end

  def edit
    @asset_value = RiskAssetValue.find(params[:id])
  end

  def create
    @asset_value = RiskAssetValue.new(params[:risk_asset_value])
    @asset_value.risk_configuration = current_risk_configuration
    respond_to do |format|
      if @asset_value.save
        format.html { redirect_to(current_risk_configuration, :notice => 'Asset value was successfully created.') }
        format.json  { render :json => @asset_value, :status => :created, :location => @asset_value }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @asset_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @asset_value = RiskAssetValue.find(params[:id])

    respond_to do |format|
      if @asset_value.update_attributes(params[:risk_asset_value])
        format.html { redirect_to(current_risk_configuration, :notice => 'Asset value was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @asset_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @asset_value = RiskAssetValue.find(params[:id])
    @asset_value.destroy

    respond_to do |format|
      format.html { redirect_to(current_risk_configuration) }
      format.json  { head :ok }
    end
  end
end
