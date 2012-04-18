class RiskProbabilitiesController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved  

  # GET /risk_probabilities/new
  # GET /risk_probabilities/new.json
  def new
    @risk_probability = RiskProbability.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @risk_probability }
    end
  end

  # GET /risk_probabilities/1/edit
  def edit
    @risk_probability = RiskProbability.find(params[:id])
  end

  # POST /risk_probabilities
  # POST /risk_probabilities.json
  def create
    @risk_probability = RiskProbability.new(params[:risk_probability])
	@risk_probability.risk_configuration = current_risk_configuration
    respond_to do |format|
      if @risk_probability.save
        format.html { redirect_to(current_risk_configuration, :notice => 'Risk probability was successfully created.') }
        format.json  { render :json => @risk_probability, :status => :created, :location => @risk_probability }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @risk_probability.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_probabilities/1
  # PUT /risk_probabilities/1.json
  def update
    @risk_probability = RiskProbability.find(params[:id])

    respond_to do |format|
      if @risk_probability.update_attributes(params[:risk_probability])
        format.html { redirect_to(current_risk_configuration, :notice => 'Risk probability was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @risk_probability.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_probabilities/1
  # DELETE /risk_probabilities/1.json
  def destroy
    @risk_probability = RiskProbability.find(params[:id])
    @risk_probability.destroy

    respond_to do |format|
      format.html { redirect_to(current_risk_configuration) }
      format.json  { head :ok }
    end
  end
end
