// pub type Value {
//   // Entity
//   EntityBitMask(
//     on_fire: data_type.Boolean,
//     sneaking: data_type.Boolean,
//     sprinting: data_type.Boolean,
//     swimming: data_type.Boolean,
//     invisible: data_type.Boolean,
//     glowing: data_type.Boolean,
//     gliding: data_type.Boolean,
//   )
//   AirTicks(Int)
//   CustomName(option.Option(String))
//   CustomNameVisible(Bool)
//   Silent(Bool)
//   Weightless(Bool)
//   Pose(entity_pose.EntityPose)
//   PowderedSnowTicks(Int)
//   // Living Entity
//   LivingEntityBitMask(
//     hand_active: Bool,
//     active_hand: entity_hand.EntityHand,
//     spin_attacking: Bool,
//   )
//   Health(Float)
//   PotionEffectColor(List(Nil))
//   AmbientPotionEffect(Bool)
//   ArrowCount(Int)
//   BeeStingerCount(Int)
//   SleepingPosition(option.Option(vector3.Vector3(Float)))
//   // Player
//   AdditionalHearts(Float)
//   Score(Int)
//   ModelCustomization(player_model_customization.PlayerModelCustomization)
//   MainHand(entity_handedness.EntityHandedness)
//   LeftShoulderEntityData(nbeet.Nbt)
//   RightShoulderEntityData(nbeet.Nbt)
//   // Mob
//   MobBitMask(no_ai: Bool, left_handed: Bool, agressive: Bool)
//   // Ageable Mob
//   Baby(Bool)
//   // Pig
//   BoostTime(Int)
// }

// pub fn get_index(value: Value) {
//   case value {
//     EntityBitMask(..) -> 0
//     AirTicks(..) -> 1
//     CustomName(..) -> 2
//     CustomNameVisible(..) -> 3
//     Silent(..) -> 4
//     Weightless(..) -> 5
//     Pose(..) -> 6
//     PowderedSnowTicks(..) -> 7
//     LivingEntityBitMask(..) -> 8
//     Health(..) -> 9
//     PotionEffectColor(..) -> 10
//     AmbientPotionEffect(..) -> 11
//     ArrowCount(..) -> 12
//     BeeStingerCount(..) -> 13
//     SleepingPosition(..) -> 14
//     AdditionalHearts(..) | MobBitMask(..) -> 15
//     Score(..) | Baby(..) -> 16
//     ModelCustomization(..) | BoostTime(..) -> 17
//     MainHand(..) -> 18
//     LeftShoulderEntityData(..) -> 19
//     RightShoulderEntityData(..) -> 20
//   }
// }
