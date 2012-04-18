class ChecklistsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved  


  def create
    @checklist = Checklist.new(params[:checklist])
    @checklist.risk = current_risk
    respond_to do |format|
      if @checklist.save
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => 'Checklist was successfully created.') }
        format.json  { render :json => @checklist, :status => :created }
      else
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => @checklist.errors) }
        format.json  { render :json => @checklist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @checklist = Checklist.find(params[:id])

    respond_to do |format|
      if @checklist.update_attributes(params[:checklist])
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => 'Checklist was successfully updated.') }
        format.json  { render :json => @checklist }
      else
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => @checklist.errors) }
        format.json  { render :json => @checklist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @checklist = Checklist.find(params[:id])
    @checklist.destroy

    respond_to do |format|
      format.html { redirect_to(project_risk_path(current_project, current_risk)) }
      format.json  { head :ok }
    end
  end
end
