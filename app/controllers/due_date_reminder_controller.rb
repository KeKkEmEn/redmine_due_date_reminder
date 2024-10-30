class DueDateReminderController < ApplicationController
 before_action :find_issue, only: [:send_reminder]
 before_action :authorize, only: [:send_reminder]
 skip_before_action :authorize, only: [:send_reminder]
    
    def send_reminder
      DueDateReminderMailer.send_reminder(@issue).deliver_now
      flash[:notice] = l(:notice_due_date_reminder_sent)
      redirect_to issue_path(@issue)
      @issue = Issue.find(params[:id])

      # Try to get the assigned user; fallback to the author if none is assigned
      recipient_user = @issue.assigned_to || @issue.author

      # Check if recipient_user is available
      if recipient_user
        # Send the reminder email
        Mailer.deliver_due_date_reminder(recipient_user, @issue)
        redirect_to @issue, notice: 'Reminder sent successfully!'
      else
        # Show an error if no recipient is found
        redirect_to @issue, alert: 'No recipient found for this reminder. Please assign the issue to a user first.'
      end
    end
    private
  
    def find_issue
      @issue = Issue.find(params[:id])
    end
  end
  
