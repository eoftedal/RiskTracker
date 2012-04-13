class RiskLevelsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved  
  
  # GET /risk_levels/new
  # GET /risk_levels/new.xml
  def new
    @risk_level = RiskLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_level }
    end
  end

  # GET /risk_levels/1/edit
  def edit
    @risk_level = RiskLevel.find(params[:id])
  end

  # POST /risk_levels
  # POST /risk_levels.xml
  def create
    @risk_level = RiskLevel.new(params[:risk_level])
	@risk_level.risk_configuration = current_risk_configuration
    respond_to do |format|
      if @risk_level.save
        format.html { redirect_to(current_risk_configuration, :notice => 'Risk level was successfully created.') }
        format.xml  { render :xml => @risk_level, :status => :created, :location => @risk_level }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_levels/1
  # PUT /risk_levels/1.xml
  def update
    @risk_level = RiskLevel.find(params[:id])

    respond_to do |format|
      if @risk_level.update_attributes(params[:risk_level])
        format.html { redirect_to(current_risk_configuration, :notice => 'Risk level was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_levels/1
  # DELETE /risk_levels/1.xml
  def destroy
    @risk_level = RiskLevel.find(params[:id])
    @risk_level.destroy

    respond_to do |format|
      format.html { redirect_to(current_risk_configuration) }
      format.xml  { head :ok }
    end
  end
end
