require ["fileinto", "imap4flags", "envelope", "include"];

# Mark emails that fail DMARC
if header :contains "Authentication-Results" "dmarc=fail" {
  # Check for anti-spoofing checks
  if anyof(
    header :contains "Authentication-Results" "dkim=pass",
    header :contains "Authentication-Results" "spf=pass",
    header :contains "Authentication-Results" "arc=pass"
  ) {
    addFlag "AUTH-INCOMPLETE";
  } else {
    # No anti-spoofing setup
    addFlag "AUTH-FAIL";
    fileinto "Spam";
  }
}

# Put all mails that have been sent without TLS/SSL into the spam folder and apply the no TLS label
if header :is "x-pm-transfer-encryption" "none" {
    addFlag "NO TLS/SSL";
    fileinto "Spam";
}

# Check for mismatches between sender values
if anyof(
    # Sender domain does not match the expected domain
    not address :is :domain "from" "valianceresponse.org",
    # Reply-to domain does not match the expected domain
    exists "reply-to" :domain "valianceresponse.org",
    not header :is "reply-to" "valianceresponse.org"
) {
    # File into Spam and mark as Phishing
    addflag "PHISHING";
    fileinto "Spam";
    stop;
  
} elsif address :is :domain "from" "valianceresponse.org" {
    # File into Inbox
    fileinto "Inbox";
}
