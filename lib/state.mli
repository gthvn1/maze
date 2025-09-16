type t

val new_state : ?robot:Pos.t -> ?boxes:PosSet.t -> t -> t

val is_box_at : t -> x:int -> y:int -> bool

val robot_pos : t -> Pos.t

val boxes : t -> PosSet.t

val of_list : string list -> t
