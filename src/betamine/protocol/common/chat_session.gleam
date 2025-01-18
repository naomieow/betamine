import betamine/common/uuid
import betamine/protocol/encoder
import gleam/bytes_tree.{type BytesTree}

pub type ChatSession {
  ChatSession(
    id: uuid.Uuid,
    expires: Int,
    encoded_public_key: BitArray,
    public_key_signature: BitArray,
  )
}

pub fn encode(tree: BytesTree, session: ChatSession) {
  tree
  |> encoder.uuid(session.id)
  |> encoder.long(session.expires)
  |> encoder.byte_array(session.encoded_public_key)
  |> encoder.byte_array(session.public_key_signature)
}
