# frozen_string_literal: true

class Admins::ConfirmationsController < Devise::ConfirmationsController
  include Accessible
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
    if resource.errors.empty?
    Sidekiq::Client.enqueue(EmailWorker, 1, resource.email, "Registration successful", "Admin registration successfull after confirmation. \n\n Thanks for signing up and confirming")
    else # do nothing
    end
  end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    super(resource_name)
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    super(resource_name, resource)
  end
end
