*** Settings ***
Documentation       Testing secret vault from the Cloud

Library             RPA.Robocorp.Vault


*** Tasks ***
Get secrets & show with Robocorp
    ${secret} =    RPA.Robocorp.Vault.Get Secret    gmail
    Log    ${secret}['email']
    Log    ${secret}['pass']
