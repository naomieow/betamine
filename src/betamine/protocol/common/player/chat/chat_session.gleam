import betamine/common/uuid
import betamine/protocol/common
import betamine/protocol/encoder
import gleam/bytes_tree

pub type ChatSession {
  ChatSession(
    id: uuid.Uuid,
    expires: Int,
    encoded_public_key: BitArray,
    public_key_signature: BitArray,
  )
}

pub fn encode(tree: bytes_tree.BytesTree, session: ChatSession) {
  tree
  |> common.encode_uuid(session.id)
  |> encoder.long(session.expires)
  |> encoder.byte_array(session.encoded_public_key)
  |> encoder.byte_array(session.public_key_signature)
}
