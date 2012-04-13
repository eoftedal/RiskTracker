class RisksController < ApplicationController
  before_filter :ensure_signed_in

	def index
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => current_project.risks }
		end
	end

  # GET /risks/1
  # GET /risks/1.xml
  def show
    @risk = Risk.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk }
    end
  end

  # GET /risks/new
  # GET /risks/new.xml
  def new
    @risk = Risk.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk }
    end
  end

  # GET /risks/1/edit
  def edit
    @risk = Risk.find(params[:id])
  end

  # POST /risks
  # POST /risks.xml
  def create
    @risk = Risk.new(params[:risk])
	@risk.project = current_project
    respond_to do |format|
      if @risk.save
        format.html { redirect_to(project_risk_path(current_project, @risk), :notice => 'Risk was successfully created.') }
        format.xml  { render :xml => @risk, :status => :created, :location => @risk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risks/1
  # PUT /risks/1.xml
  def update
    @risk = Risk.find(params[:id])

    respond_to do |format|
      if @risk.update_attributes(params[:risk])
        format.html { redirect_to(project_risk_path(current_project, @risk), :notice => 'Risk was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risks/1
  # DELETE /risks/1.xml
  def destroy
    @risk = Risk.find(params[:id])
    @risk.destroy

    respond_to do |format|
      format.html { redirect_to(current_project) }
      format.xml  { head :ok }
    end
  end
end
