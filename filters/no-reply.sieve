require ["variables", "envelope", "imap4flags"];

# Define the tag you want to use to flag "no reply" emails
set "no_reply_tag" "NO REPLY";

# Create a rule to match emails sent from "no reply" addresses
if envelope :is "from" "no-reply@example.com" {
  # Flag the email with the specified tag
  addflag "${no_reply_tag}";
}
