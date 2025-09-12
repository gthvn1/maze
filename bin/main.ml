open Graphics

let cell_size = Maze.cell_size

let draw_cell (x, y) ~(ty : Maze.cell) : unit =
  let color =
    match ty with
    | Wall -> black
    | Floor -> white
  in
  set_color color;
  fill_rect x y cell_size cell_size
;;

let draw_board (board : Maze.t) : unit =
  Array.iteri
    (fun y row ->
       Array.iteri (fun x c -> draw_cell ~ty:c (x * cell_size, y * cell_size)) row)
    board
;;

let () =
  let board = Maze.("maze.txt" |> read_maze_from_file |> of_string_list) in
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
