class ContactInquiriesController < ApplicationController

  def new
    @inquiry = ContactInquiry.new
  end

  def create
    @inquiry = ContactInquiry.new(contact_inquiry_params)
    if @inquiry.save
      ContactEmail.receipt(@inquiry).deliver
      flash[:notice] = "Email successfully sent"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def contact_inquiry_params
    params.require(:contact_inquiry).permit(:first_name, :last_name,
      :email, :subject, :content)
  end
end
