class RiskConsequencesController < ApplicationController

  # GET /risk_consequences/new
  # GET /risk_consequences/new.xml
  def new
    @risk_consequence = RiskConsequence.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_consequence }
    end
  end

  # GET /risk_consequences/1/edit
  def edit
    @risk_consequence = RiskConsequence.find(params[:id])
  end

  # POST /risk_consequences
  # POST /risk_consequences.xml
  def create
    @risk_consequence = RiskConsequence.new(params[:risk_consequence])
	@risk_consequence.risk_configuration = current_risk_configuration
    respond_to do |format|
      if @risk_consequence.save
        format.html { redirect_to(current_risk_configuration, :notice => 'Risk consequence was successfully created.') }
        format.xml  { render :xml => @risk_consequence, :status => :created, :location => @risk_consequence }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_consequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_consequences/1
  # PUT /risk_consequences/1.xml
  def update
    @risk_consequence = RiskConsequence.find(params[:id])

    respond_to do |format|
      if @risk_consequence.update_attributes(params[:risk_consequence])
        format.html { redirect_to(@risk_consequence, :notice => 'Risk consequence was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_consequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_consequences/1
  # DELETE /risk_consequences/1.xml
  def destroy
    @risk_consequence = RiskConsequence.find(params[:id])
    @risk_consequence.destroy

    respond_to do |format|
      format.html { redirect_to(current_risk_configuration) }
      format.xml  { head :ok }
    end
  end
end
