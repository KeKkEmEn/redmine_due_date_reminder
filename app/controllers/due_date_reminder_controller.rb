class DueDateReminderController < ApplicationController
 before_action :find_issue, only: [:send_reminder]
 before_action :authorize, only: [:send_reminder]
 skip_before_action :authorize, only: [:send_reminder]
    
def send_reminder
  @issue = Issue.find(params[:id])
  recipient_user = @issue.assigned_to || @issue.author

  if recipient_user
    # Check if the issue has a journal (if needed)
    journal = @issue.journals.last if @issue.respond_to?(:journals)

    # Pass recipient and issue to mailer, add journal if necessary
    Mailer.issue_edit(recipient_user, @issue, journal).deliver_now
    redirect_to @issue, notice: 'Reminder sent successfully!'
  else
    redirect_to @issue, alert: 'No recipient found for this reminder. Please assign the issue to a user first.'
  end
end

    private
  
    def find_issue
      @issue = Issue.find(params[:id])
    end
  end
  
