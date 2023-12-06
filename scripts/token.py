#!/usr/bin/python3

from brownie import Token, accounts


def main():
    return Token.deploy("RAI Token", "RAI", 18, 888000000*10**18, {'from': '0xE6D4CedEc39f792e834F9E7091F0b9536B14023d'})
