type cell = Wall | Floor

type t

val cell_size : int

val of_file : string -> t

val width : t -> int

val height : t -> int

val iteri_cells : (int -> int -> cell -> unit) -> t -> unit
