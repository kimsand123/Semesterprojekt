
# To use this code, make sure you
#
#     import json
#
# and then, to convert JSON from a string, do
#
#     result = user_from_dict(json.loads(json_string))
#from django.db import models
#from typing import List

#class Entry:
#    key: str
#    value: str

#    def __init__(self, key: str, value: str) -> None:
#        self.key = key
#        self.value = value

#class EkstraFelter:
#    entry: List[Entry]

#class User(models.Model):
#    brugernavn: str
#    email: str
#    sidst_aktiv: int
#    campusnet_id: int
#    studeretning: str
#    fornavn: str
#    efternavn: str
#    adgangskode: str
#    ekstra_felter: EkstraFelter

#    def _str_(self, brugernavn: str, email: str, sidst_aktiv: int, campusnet_id: int, studeretning: str, fornavn: str, efternavn: str, adgangskode: str, ekstra_felter: EkstraFelter) -> None:
#        self.brugernavn = brugernavn
#        self.email = email
#        self.sidst_aktiv = sidst_aktiv
#        self.campusnet_id = campusnet_id
#        self.studeretning = studeretning
#        self.fornavn = fornavn
#        self.efternavn = efternavn
#        self.adgangskode = adgangskode
#        self.ekstra_felter = ekstra_felter


# Create your models here.
