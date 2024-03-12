import gleeunit
import gleeunit/should
import querystring

pub fn main() {
  gleeunit.main()
}

pub fn serialize_one_entry_test() {
  [#("test", querystring.One("1"))]
  |> querystring.serialize()
  |> should.equal("test=1")
}

pub fn serialize_multiple_entries_test() {
  [
    #("first_value", querystring.One("Toronto")),
    #("new_value", querystring.One("true")),
    #("another_value", querystring.One("1")),
  ]
  |> querystring.serialize()
  |> should.equal("first_value=Toronto&new_value=true&another_value=1")
}

pub fn serialize_one_entry_with_many_values_test() {
  [#("cities", querystring.Many(["Toronto", "Paris", "New-York"]))]
  |> querystring.serialize()
  |> should.equal("cities[]=Toronto&cities[]=Paris&cities[]=New-York")
}

pub fn serialize_multiple_entries_mixing_ones_and_manies_test() {
  [
    #("name", querystring.One("Chris")),
    #("moods", querystring.Many(["happy", "tired"])),
  ]
  |> querystring.serialize()
  |> should.equal("name=Chris&moods[]=happy&moods[]=tired")
}
