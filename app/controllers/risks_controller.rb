class RisksController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved  

	def index
    @tag = params[:tag]    
    if (@tag) then
      @risks = current_project.risks.tagged_with(params[:tag])
    else 
      @risks = current_project.risks
    end
		respond_to do |format|
			format.html # show.html.erb
      format.json  { render :json => @risks }
		end
	end

  def tags
    render :json => current_project.risks.tag_counts.map{ |t| t.name }
  end

  # GET /risks/1
  # GET /risks/1.json
  def show
    @risk = Risk.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @risk }
    end
  end

  # GET /risks/new
  # GET /risks/new.json
  def new
    @risk = Risk.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @risk }
    end
  end

  # GET /risks/1/edit
  def edit
    @risk = Risk.find(params[:id])
  end

  # POST /risks
  # POST /risks.json
  def create
    @risk = Risk.new(params[:risk])
	  @risk.project = current_project
    respond_to do |format|
      if @risk.save
        format.html { redirect_to(project_risk_path(current_project, @risk), :notice => 'Risk was successfully created.') }
        format.json  { render :json => @risk, :status => :created}
      else
        format.html { render :action => "new" }
        format.json  { render :json => @risk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risks/1
  # PUT /risks/1.json
  def update
    @risk = Risk.find(params[:id])

    respond_to do |format|
      if @risk.update_attributes(params[:risk])
        format.html { redirect_to(project_risk_path(current_project, @risk), :notice => 'Risk was successfully updated.') }
        format.json  { render :json => @risk }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @risk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risks/1
  # DELETE /risks/1.json
  def destroy
    @risk = Risk.find(params[:id])
    @risk.destroy

    respond_to do |format|
      format.html { redirect_to(project_risks_path(current_project)) }
      format.json  { head :ok }
    end
  end
end
