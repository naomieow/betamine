import betamine/protocol/encoder
import gleam/bytes_tree.{type BytesTree}

pub const default_chunk = [
  default_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
  default_empty_chunk_section,
]

pub type ChunkSection {
  ChunkSection(
    block_count: Int,
    block_states: PalettedContainer,
    biomes: PalettedContainer,
  )
}

pub const default_chunk_section = ChunkSection(
  4096,
  PalettedContainer(SingleValued(1), []),
  PalettedContainer(SingleValued(0), []),
)

pub const default_empty_chunk_section = ChunkSection(
  0,
  PalettedContainer(SingleValued(0), []),
  PalettedContainer(SingleValued(0), []),
)

pub fn encode_section(tree: BytesTree, section: ChunkSection) {
  tree
  |> encoder.short(section.block_count)
  |> encode_paletted_container(section.block_states)
  |> encode_paletted_container(section.biomes)
}

pub type PalettedContainer {
  PalettedContainer(palette: Palette, data: List(Int))
}

fn encode_paletted_container(
  tree: BytesTree,
  paletted_container: PalettedContainer,
) {
  case paletted_container.palette {
    SingleValued(id) -> {
      tree
      // Bits per entry
      |> encoder.byte(0)
      |> encoder.var_int(id)
      |> encoder.var_int(0)
    }
    Indirect(_) -> todo as "Indirect palettes not implemented"
    Direct -> todo as "Direct palettes not implemented"
  }
}

pub type Palette {
  SingleValued(id: Int)
  Indirect(ids: List(Int))
  Direct
}
