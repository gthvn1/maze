type cell =
  | Wall
  | Floor

type t = cell array array

let cell_size : int = 10
(* in pixels *)

(** [of_string str] converts a string [str] into an array of cells. *)
let of_string (str : string) : cell array =
  str
  |> String.to_seq
  |> Seq.map (fun c -> if c = '#' then Wall else Floor)
  |> Array.of_seq
;;

(** [of_file filename] returns a list of string read from [filename]. *)
let of_file (filename : string) : t =
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
  loop [] |> List.map of_string |> Array.of_list
;;

let iteri_cells f (board : t) : unit =
  Array.iteri (fun y row -> Array.iteri (fun x cell -> f x y cell) row) board
;;

let width (board : t) : int = Array.length board.(0)
let height (board : t) : int = Array.length board
