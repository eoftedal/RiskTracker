class RiskConfigurationsController < ApplicationController
  # GET /risk_configurations
  # GET /risk_configurations.xml
  def index
    @risk_configurations = RiskConfiguration.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @risk_configurations }
    end
  end

  # GET /risk_configurations/1
  # GET /risk_configurations/1.xml
  def show
    @risk_configuration = RiskConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk_configuration }
    end
  end

  # GET /risk_configurations/new
  # GET /risk_configurations/new.xml
  def new
    @risk_configuration = RiskConfiguration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_configuration }
    end
  end

  # GET /risk_configurations/1/edit
  def edit
    @risk_configuration = RiskConfiguration.find(params[:id])
  end

  # POST /risk_configurations
  # POST /risk_configurations.xml
  def create
    @risk_configuration = RiskConfiguration.new(params[:risk_configuration])

    respond_to do |format|
      if @risk_configuration.save
		create_defaults(RiskLevel, @risk_configuration)
		create_defaults(RiskProbability, @risk_configuration)
		create_defaults(RiskConsequence, @risk_configuration)
		
        format.html { redirect_to(@risk_configuration, :notice => 'Risk configuration was successfully created.') }
        format.xml  { render :xml => @risk_configuration, :status => :created, :location => @risk_configuration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create_defaults(itemspec, config) 
	default_values = [["High", 100], ["Medium", 50], ["Low", 10]]
	default_values.each do |name, weight|
		item = itemspec.new
		item.name = name
		item.weight = weight
		item.risk_configuration = config
		item.save
	end
  end
  
  # PUT /risk_configurations/1
  # PUT /risk_configurations/1.xml
  def update
    @risk_configuration = RiskConfiguration.find(params[:id])

    respond_to do |format|
      if @risk_configuration.update_attributes(params[:risk_configuration])
        format.html { redirect_to(@risk_configuration, :notice => 'Risk configuration was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_configurations/1
  # DELETE /risk_configurations/1.xml
  def destroy
    @risk_configuration = RiskConfiguration.find(params[:id])
    @risk_configuration.destroy

    respond_to do |format|
      format.html { redirect_to(risk_configurations_url) }
      format.xml  { head :ok }
    end
  end
end
