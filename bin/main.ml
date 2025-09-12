module D = Maze__.Draw

let () =
  let board, state = "maze.txt" |> Maze.of_file in
  D.init_window board ;
  D.render board state ;
  let rec loop () =
    match D.read_key () with
    | 'q' ->
        D.close_window ()
    | c ->
        Printf.printf "%c pressed\n%!" c ;
        loop ()
  in
  loop ()
