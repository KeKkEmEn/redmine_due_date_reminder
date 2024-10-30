class DueDateReminderController < ApplicationController
    skip_before_action :authorize, only: [:send_reminder]
    before_action :find_issue, only: [:send_reminder]
    before_action :authorize, only: [:send_reminder]
  
    def send_reminder
      DueDateReminderMailer.send_reminder(@issue).deliver_now
      flash[:notice] = l(:notice_due_date_reminder_sent)
      redirect_to issue_path(@issue)
    end
  
    private
  
    def find_issue
      @issue = Issue.find(params[:id])
    end
  end
  
