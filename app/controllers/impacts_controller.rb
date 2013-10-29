class ImpactsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved

  # GET /impacts/new
  # GET /impacts/new.json
  def new
    @impact = Impact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @impact }
    end
  end

  # GET /impacts/1/edit
  def edit
    @impact = Impact.find(params[:id])
  end

  # POST /impacts
  # POST /impacts.json
  def create
    @impact = Impact.new(params[:impact])
	@impact.risk_configuration = current_risk_configuration
    respond_to do |format|
      if @impact.save
        format.html { redirect_to(current_risk_configuration, :notice => 'Impact was successfully created.') }
        format.json  { render :json => @impact, :status => :created, :location => @impact }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @impact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /impacts/1
  # PUT /impacts/1.json
  def update
    @impact = Impact.find(params[:id])

    respond_to do |format|
      if @impact.update_attributes(params[:impact])
        format.html { redirect_to(current_risk_configuration, :notice => 'Impact was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @impact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /impacts/1
  # DELETE /impacts/1.json
  def destroy
    @impact = Impact.find(params[:id])
    @impact.destroy

    respond_to do |format|
      format.html { redirect_to(current_risk_configuration, :notice => 'Impact was removed') }
      format.json  { head :ok }
    end
  end
end
