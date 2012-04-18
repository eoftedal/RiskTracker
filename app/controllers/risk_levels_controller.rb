class RiskLevelsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved
  before_filter :ensure_admin  
  
  
  # GET /risk_levels/new
  # GET /risk_levels/new.json
  def new
    @risk_level = RiskLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @risk_level }
    end
  end

  # GET /risk_levels/1/edit
  def edit
    @risk_level = RiskLevel.find(params[:id])
  end

  # POST /risk_levels
  # POST /risk_levels.json
  def create
    @risk_level = RiskLevel.new(params[:risk_level])
	@risk_level.risk_configuration = current_risk_configuration
    respond_to do |format|
      if @risk_level.save
        format.html { redirect_to(current_risk_configuration, :notice => 'Risk level was successfully created.') }
        format.json  { render :json => @risk_level, :status => :created, :location => @risk_level }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @risk_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_levels/1
  # PUT /risk_levels/1.json
  def update
    @risk_level = RiskLevel.find(params[:id])

    respond_to do |format|
      if @risk_level.update_attributes(params[:risk_level])
        format.html { redirect_to(current_risk_configuration, :notice => 'Risk level was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @risk_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_levels/1
  # DELETE /risk_levels/1.json
  def destroy
    @risk_level = RiskLevel.find(params[:id])
    @risk_level.destroy

    respond_to do |format|
      format.html { redirect_to(current_risk_configuration) }
      format.json  { head :ok }
    end
  end
end
