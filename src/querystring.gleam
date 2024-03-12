//// querystring is a simple Gleam package that allow you to format
//// and manipulate query string

import gleam/io
import gleam/list
import gleam/string

/// A SerializedQueryString is just a string
///
pub type SerializedQueryString =
  String

/// A QueryStringKey is just a string, representing a possible value for a key
///
pub type QueryStringKey =
  String

/// A query parameter value is a string or a list of string
/// `One` represents a single value
/// `Many` represents a list of values
///
pub type QueryStringValue {
  One(String)
  Many(List(String))
}

/// Data structure representing a query string parsed by the library
/// Example:
/// `[#("myParam", querystring.One("value"))]`
/// `[#("myParam", querystring.Many(["value1", "value2"]))]`
///
pub type DeserializedQueryString =
  List(#(QueryStringKey, QueryStringValue))

pub fn main() {
  io.println("Hello from querystring!")
}

pub fn serialize(query_list: DeserializedQueryString) -> SerializedQueryString {
  query_list
  |> list.fold([], fn(serialized, entry) {
    let #(key, val) = entry

    let serialized_value = case val {
      One(raw_value) -> key <> "=" <> raw_value
      Many(raw_value) ->
        raw_value
        |> list.fold([], fn(serialized, item) {
          list.append(serialized, [key <> "[]=" <> item])
        })
        |> string.join("&")
    }

    list.append(serialized, [serialized_value])
  })
  |> string.join("&")
}
