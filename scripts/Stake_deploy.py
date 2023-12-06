#!/usr/bin/python3

from brownie import accounts,Staking_Contract


def main():
    account=accounts.load('rai_deploy')
    return Staking_Contract.deploy('0x275bb39d916b67a5b53afaa41549de6a3cc976bc',1000*10**18,{"from": account})