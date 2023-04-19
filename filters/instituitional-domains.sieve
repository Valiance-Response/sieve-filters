require ["envelope", "imap4flags"];

# Define the tag you want to use to flag important emails
set "tag1" "Example 1";
set "tag2" "Example 2";

# Define a list of domains
set "domains1" "gc.ca" "canada.ca" "parl.gc.ca";
set "domains2" "mb.ca";

if envelope :matches "from" "*@%{domains1}" {
  # Flag the email with the specified tag
  addflag "${tag1}";
}

if envelope :matches "from" "*@%{military_domains}" {
  # Flag the email with the specified tag
  addflag "${tag2}";
}
