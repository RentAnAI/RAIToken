#!/usr/bin/python3

from brownie import accounts,GPURentalMarketplace


def main():
    account=accounts.load('rai_deploy')
    return GPURentalMarketplace.deploy('from':account)