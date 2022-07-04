#!/bin/bash
#
# This script creates a new user on the local system 
if [[ "${UID}" -ne 0 ]]
then
 echo 'Please run with sudo or as root.'
 exit 1
fi

#  MAke sure the script is being executed with superuser privileges

# get the username (login)
read -p 'Enter the username to create: ' USER_NAME

# Get the real name (contents for the description field_)
read -p 'Enter the name of the person or applcation that will be using  this account: ' COMMENT
 
# Get the password
read -p ' Enter the password to use for the account: ' PASSWORD

# Create the user with the password
useradd -c "${COMMENT}" -m ${USER_NAME} 

# Check to  see it the useradd command succeeded
if [[ "${?}" -ne 0 ]]
then 
 echo 'The account could not be created.'
 exit 1
fi

# Set the password
echo $PASSWORD | passwd --stdin $USER_NAME


# Force password change on first login.
if [[ "${?}" -ne 0 ]]
then 
 echo 'The password for the account could not be set.'
 exit 1
fi

# Force password change on first login. 
passwd -e $USER_NAME

# Display the username, password, and the host where the user was created
echo 
echo 'username:'
echo "${USER_NAME}" 
echo 
echo 'password: '
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
echo

exit 0

