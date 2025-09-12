open Graphics

type cell =
  | Wall
  | Floor

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

let draw_cell (x, y) ~(ty : cell) : unit =
  let color =
    match ty with
    | Wall -> black
    | Floor -> white
  in
  set_color color;
  fill_rect x y cell_size cell_size
;;

let draw_board (board : cell array array) : unit =
  Array.iteri
    (fun y row ->
       Array.iteri (fun x c -> draw_cell ~ty:c (x * cell_size, y * cell_size)) row)
    board
;;

let () =
  let board = "maze.txt" |> read_maze_from_file |> of_string_list in
  let height = Array.length board * cell_size in
  let weight = Array.length board.(0) * cell_size in
  Printf.printf "Window size (weight: %d, height: %d)\n" weight height;
  open_graph (Printf.sprintf " %dx%d" weight height);
  Printf.printf "Cursot at (%d, %d)\n" (current_x ()) (current_y ());
  flush_all ();
  draw_board board;
  let rec loop () =
    match read_key () with
    | 'q' -> close_graph ()
    | c ->
      Printf.printf "%c pressed\n" c;
      flush_all ();
      loop ()
  in
  loop ()
;;
