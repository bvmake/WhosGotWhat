require "securerandom"
class Invitation < ActiveRecord::Base

  attr_accessible :contact, :network

  before_validation :generate_token, :on => :create

  belongs_to :sender, :class_name => "User"

  has_one :recipient, :class_name => "User", :inverse_of => :invitation

  validates_presence_of :contact, :token, :network

  validates_presence_of :recipient

  validates_uniqueness_of :contact, :scope => :network, :message => "has already been invited", :unless => Proc.new { |ir| ir.contact.nil? && ir.network.nil? }


  class << self
    def networks
      %w(email)
    end
  end

  validates_inclusion_of :network, :in => networks
  validates_presence_of :state

  scope :email_invites, where("network" => "email")

  scope :next_batch_of, lambda { |count| pending.order("created_at asc").limit(count) }

  state_machine :state, :initial => :waitlist do

    state :accepted
    state :pending
    state :waitlist

    event :invite do
      transition :waitlist => :pending
    end

    event :accept do
      transition :pending => :accepted
    end

    before_transition :pending => :accepted do |invitation|
      invitation.accepted_at = Time.now
    end

  end

  state_machine.states.each do |state|
    next unless state
    scope state.value, where(:state => state.value)
  end


  def is_email?
    network == "email"
  end


  def recipient_email
    recipient.email
  end


  def recipient_first_name
    recipient.first_name
  end


  def send_invitation(signup_url)
    InvitationMailer.invitation_email(self,signup_url).deliver rescue logger.info("Invitation Email: Needs email implementation")
  end


  def send_waitlist_email
    InvitationMailer.waitlist_email(self).deliver rescue logger.info("Waitlist Email: Needs email implementation")
  end

private

  def generate_token
    # http://bitly.com/sPKZkO
    self.token ||= (97 + rand(25)).chr + SecureRandom.hex(20)
  end
end
