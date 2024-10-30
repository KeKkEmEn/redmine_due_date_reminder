class DueDateReminderController < ApplicationController
 before_action :find_issue, only: [:send_reminder]
 before_action :authorize, only: [:send_reminder]
 skip_before_action :authorize, only: [:send_reminder]
    
    def send_reminder
      DueDateReminderMailer.send_reminder(@issue).deliver_now
      flash[:notice] = l(:notice_due_date_reminder_sent)
      redirect_to issue_path(@issue)
     
      @issue = Issue.find(params[:id])

      recipient_user = @issue.assigned_to || @issue.author

      Mailer.deliver_due_date_reminder(recipient_user, @issue)

      redirect_to @issue, notice: 'Reminder sent successfully!'
    end
  
    private
  
    def find_issue
      @issue = Issue.find(params[:id])
    end
  end
  
