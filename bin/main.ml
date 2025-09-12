module B = Maze.Board
module D = Maze.Draw

let () =
  let board = B.("maze.txt" |> of_file) in
  D.init_window board;
  D.render board;
  let rec loop () =
    match D.read_key () with
    | 'q' -> D.close_window ()
    | c ->
      Printf.printf "%c pressed\n%!" c;
      loop ()
  in
  loop ()
;;
