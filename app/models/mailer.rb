class DueDateReminderMailer < Mailer
  def self.issue_edit(recipient_user, issue, journal = nil)
end
  def send_reminder(issue)
    recipients = issue.assigned_to.try(:mail)
    mail(to: recipients, subject: "Reminder: Issue ##{issue.id} is due soon") do |format|
      format.text { render plain: "This is a reminder that issue ##{issue.id} is due on #{issue.due_date}." }
    end
  end
end
