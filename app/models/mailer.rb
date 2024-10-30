# plugins/redmine_due_date_reminder/app/models/mailer.rb
class DueDateReminderMailer < Mailer
  # Method to send the due date reminder
  def send_reminder(issue, recipient_user)
    recipients = recipient_user.try(:mail)
    
    return if recipients.blank?  # Exit if no recipient is found

    mail(to: recipients, subject: "Reminder: Issue ##{issue.id} is due soon") do |format|
      format.text { render plain: "This is a reminder that issue ##{issue.id} is due on #{issue.due_date}." }
    end
  end

  # Adjusted issue_edit method to accept only two parameters
  def self.issue_edit(recipient_user, issue)
    # Ensure the recipient_user is valid
    recipients = recipient_user.try(:mail)
    
    return if recipients.blank?  # Exit if no recipient is found

    # Assuming 'journal' is no longer necessary in this method
    subject = "Issue ##{issue.id} has been updated"

    mail(to: recipients, subject: subject) do |format|
      format.text do
        render plain: "The following changes were made to issue ##{issue.id}."
      end
    end
  end
end
