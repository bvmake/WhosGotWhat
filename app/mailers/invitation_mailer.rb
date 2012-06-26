class InvitationMailer < ActionMailer::Base
  default from: "BVMake <bvmake@example.com>"

  def invitation_email(invitation,signup_url)
    setup_default_attachments
    @name = invitation.recipient_first_name
    @signup_url = signup_url
    mail :subject => "Invitation to BVMake Who's Got What",
         :to => invitation.recipient_email
    invitation.update_attribute :sent_at, Time.now
  end


  def waitlist_email(invitation)
    setup_default_attachments
    @name = invitation.recipient_first_name
    mail :subject => "Thanks for your interest in BVMake Who's Got What",
         :to => invitation.recipient_email
  end


end
