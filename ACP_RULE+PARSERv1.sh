#!/bin/bash
#
#
# script to ingest FMC ACP json for access rules that were acquired by the API, the output is a line-by-line of the rule with IDS/FIR/Logging detail
# you can add any fields to the script to meet your requirements
#
#
# example of API entry point and ACP via UUID
#
#https://FMChostname/api/fmc_config/v1/domain/e276abec-e0f2-11e3-8169-6d9ed49b625f/policy/accesspolicies/2CF89BC0-4DF6-0ed3-0002-400895514069/accessrules?limit=100000000&expanded=true


# Prompt the user for a filename
read -rp "Enter the filename (with path if not in current directory): " filename


# Check if input is empty
if [[ -z "$filename" ]]; then
    echo "Error: No filename entered."
    exit 1
fi

# Check if the file exists
if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' does not exist."
    exit 1
fi

# Successfully stored filename in variable
echo "You entered: $filename"


jq -r '
  [ "ACP_NAME",  "Rule_Name","Action", "IPS","File","LogEnd"],
  (
    .items[]
    | select(.name?)
    | [
         (.metadata.accessPolicy.name // ""),

        .name,
        (.action // ""),
        (.ipsPolicy?.name // ""),
        (.filePolicy?.name // ""),
        (.logEnd // "")
      ]
  )
  | @csv
' $filename
