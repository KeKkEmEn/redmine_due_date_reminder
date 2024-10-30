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

  # Method to handle issue edits
  def self.issue_edit(recipient_user, issue, journal = nil)
    # Ensure the recipient_user is valid
    recipients = recipient_user.try(:mail)
    
    return if recipients.blank?  # Exit if no recipient is found

    # Assuming 'journal' holds some details about the issue changes
    subject = "Issue ##{issue.id} has been updated"
    
    mail(to: recipients, subject: subject) do |format|
      format.text do
        changes = journal&.details || "No changes were made."
        render plain: "The following changes were made to issue ##{issue.id}: #{changes}"
      end
    end
  end
end
