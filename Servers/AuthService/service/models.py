from django.db import models
# To use this code, make sure you
#
#     import json
#
# and then, to convert JSON from a string, do
#
#     result = user_from_dict(json.loads(json_string))

from typing import Any, List, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> List[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


class Entry:
    key: str
    value: str

    def __init__(self, key: str, value: str) -> None:
        self.key = key
        self.value = value

    @staticmethod
    def from_dict(obj: Any) -> 'Entry':
        assert isinstance(obj, dict)
        key = from_str(obj.get("key"))
        value = from_str(obj.get("value"))
        return Entry(key, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["key"] = from_str(self.key)
        result["value"] = from_str(self.value)
        return result


class EkstraFelter:
    entry: List[Entry]

    def __init__(self, entry: List[Entry]) -> None:
        self.entry = entry

    @staticmethod
    def from_dict(obj: Any) -> 'EkstraFelter':
        assert isinstance(obj, dict)
        entry = from_list(Entry.from_dict, obj.get("entry"))
        return EkstraFelter(entry)

    def to_dict(self) -> dict:
        result: dict = {}
        result["entry"] = from_list(lambda x: to_class(Entry, x), self.entry)
        return result


class User:
    brugernavn: str
    email: str
    sidst_aktiv: int
    campusnet_id: int
    studeretning: str
    fornavn: str
    efternavn: str
    adgangskode: str
    ekstra_felter: EkstraFelter

    def __init__(self, brugernavn: str, email: str, sidst_aktiv: int, campusnet_id: int, studeretning: str, fornavn: str, efternavn: str, adgangskode: str, ekstra_felter: EkstraFelter) -> None:
        self.brugernavn = brugernavn
        self.email = email
        self.sidst_aktiv = sidst_aktiv
        self.campusnet_id = campusnet_id
        self.studeretning = studeretning
        self.fornavn = fornavn
        self.efternavn = efternavn
        self.adgangskode = adgangskode
        self.ekstra_felter = ekstra_felter

    @staticmethod
    def from_dict(obj: Any) -> 'User':
        assert isinstance(obj, dict)
        brugernavn = from_str(obj.get("brugernavn"))
        email = from_str(obj.get("email"))
        sidst_aktiv = from_int(obj.get("sidstAktiv"))
        campusnet_id = int(from_str(obj.get("campusnetId")))
        studeretning = from_str(obj.get("studeretning"))
        fornavn = from_str(obj.get("fornavn"))
        efternavn = from_str(obj.get("efternavn"))
        adgangskode = from_str(obj.get("adgangskode"))
        ekstra_felter = EkstraFelter.from_dict(obj.get("ekstraFelter"))
        return User(brugernavn, email, sidst_aktiv, campusnet_id, studeretning, fornavn, efternavn, adgangskode, ekstra_felter)

    def to_dict(self) -> dict:
        result: dict = {}
        result["brugernavn"] = from_str(self.brugernavn)
        result["email"] = from_str(self.email)
        result["sidstAktiv"] = from_int(self.sidst_aktiv)
        result["campusnetId"] = from_str(str(self.campusnet_id))
        result["studeretning"] = from_str(self.studeretning)
        result["fornavn"] = from_str(self.fornavn)
        result["efternavn"] = from_str(self.efternavn)
        result["adgangskode"] = from_str(self.adgangskode)
        result["ekstraFelter"] = to_class(EkstraFelter, self.ekstra_felter)
        return result


def user_from_dict(s: Any) -> User:
    return User.from_dict(s)


def user_to_dict(x: User) -> Any:
    return to_class(User, x)

# Create your models here.
