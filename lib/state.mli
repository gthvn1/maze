type t

val new_state : ?robot:Pos.t -> ?boxes:PosSet.t -> t -> t

val is_box_at : t -> pos:Pos.t -> bool

val robot_pos : t -> Pos.t

val iter_boxes : t -> f:(Pos.t -> unit) -> unit

val of_list : string list -> t
