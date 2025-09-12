type cell =
  | Wall
  | Floor

type t = cell array array

let cell_size : int = 20 (* pixels *)

(* let board_str : string list = *)
(*   [ "########" *)
(*   ; "#..O.O.#" *)
(*   ; "##O.O..#" *)
(*   ; "#.O.O..#" *)
(*   ; "#.@.O..#" *)
(*   ; "#...O..#" *)
(*   ; "#......#" *)
(*   ; "########" *)
(*   ] *)
(* ;; *)

let read_maze_from_file (filename : string) : string list =
  let ic = open_in filename in
  let rec loop acc =
    try
      let s = input_line ic in
      loop (s :: acc)
    with
    | End_of_file ->
      close_in ic;
      List.rev acc
  in
  loop []
;;

(** [of_string str] converts a string [str] into an array of cells. *)
let of_string (str : string) : cell array =
  str
  |> String.to_seq
  |> Seq.map (fun c -> if c = '#' then Wall else Floor)
  |> Array.of_seq
;;

let of_string_list (lst : string list) : cell array array =
  List.map of_string lst |> Array.of_list
;;
