class CommentsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved

  
	# POST
  def create
    @comment = Comment.build_from(current_risk, session[:user_id], params[:body])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => 'Comment was successfully added.') }
        format.json  { render :json => @comment, :status => :created, :location => current_risk }
      else
        format.html { redirect_to(project_risk_path(current_project, current_risk), :notice => @comment.errors) }
        format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT
  def update
    @risk = Risk.find(params[:id])

    respond_to do |format|
      if @risk.update_attributes(params[:risk])
        format.html { redirect_to(project_risk_path(current_project, @risk), :notice => 'Risk was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @risk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE
  def destroy
    @risk = Risk.find(params[:id])
    @risk.destroy

    respond_to do |format|
      format.html { redirect_to(current_project) }
      format.json  { head :ok }
    end
  end
end
