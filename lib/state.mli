(* Expose the type of sets of positions *)
module PosSet : sig
  type elt = Pos.t

  type t

  val empty : t

  val add : elt -> t -> t

  val mem : elt -> t -> bool

  val remove : elt -> t -> t

  val iter : (elt -> unit) -> t -> unit
end

type t

val is_box_at : t -> x:int -> y:int -> bool

val robot_pos : t -> Pos.t

val boxes : t -> PosSet.t

val of_list : string list -> t
