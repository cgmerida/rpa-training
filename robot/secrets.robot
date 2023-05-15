*** Settings ***
Documentation       Testing secret vault from the Cloud

Library             RPA.Robocorp.Vault


*** Tasks ***
Get secrets & show with Robocorp
    ${secret} =    RPA.Robocorp.Vault.Get Secret    Gmail
    # Get Secret is case sensitive
    Log    ${secret}['email']
    Log    ${secret}['pass']
