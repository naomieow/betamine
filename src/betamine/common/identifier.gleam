pub type Identifier =
  #(String, String)

pub fn get_prefix(identifier: Identifier) {
  identifier.0
}

pub fn get_suffix(identifier: Identifier) {
  identifier.1
}

pub fn to_string(identifier: Identifier) {
  get_prefix(identifier) <> ":" <> get_suffix(identifier)
}
