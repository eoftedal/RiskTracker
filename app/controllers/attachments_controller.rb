class AttachmentsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_approved  


  def show
    @attachment = Attachment.find(params[:id])
    send_file @attachment.file.path(params[:style]), :type => @attachment.file_content_type, :disposition => 'attachment'
  end


  def create
    @attachment = Attachment.new(params[:attachment])
    @attachment.user = current_user

    @attachment_link = AttachmentLink.new()
    @attachment_link.attachment = @attachment
    @attachment_link.user = current_user
    @attachment_link.risk = current_risk

    respond_to do |format|
      if @attachment.save
        if @attachment_link.save
          format.html  { redirect_to(project_risk_path(current_project, current_risk), :notice => "Attachment added") }
        else
          format.html  { redirect_to(project_risk_path(current_project, current_risk), :notice => @attachment_link.errors) }
        end
      else
        format.html  { redirect_to(project_risk_path(current_project, current_risk), :notice => @attachment.errors) }
      end
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.attachment_links.select{|l| l.risk == current_risk}.destroy
    if (@attachment.attachment_links.count == 0) then
        @attachment.destroy
    end
    respond_to do |format|
      format.html  { redirect_to(project_risk_path(current_project, current_risk), :notice => "Attachment removed") }
    end
  end
end
