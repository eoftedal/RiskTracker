class ChecklistItemsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved  


  def create
    @checklist_item = ChecklistItem.new(params[:checklist_item])
    @checklist_item.checklist = current_checklist
    respond_to do |format|
      if @checklist_item.save
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => 'Checklist item was successfully created.') }
        format.json  { render :json => @checklist_item, :status => :created }
      else
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => @checklist_item.errors) }
        format.json  { render :json => @checklist_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @checklist_item = ChecklistItem.find(params[:id])

    respond_to do |format|
      if @checklist_item.update_attributes(params[:checklist_item])
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => 'Checklist item was successfully updated.') }
        format.json  { render :json => @checklist_item }
      else
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => @checklist_item.errors) }
        format.json  { render :json => @checklist_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @checklist_item = ChecklistItem.find(params[:id])
    @checklist_item.destroy

    respond_to do |format|
      format.html { redirect_to(project_risk_path(current_project, current_risk)) }
      format.json  { head :ok }
    end
  end
end
