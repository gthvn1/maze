module D = Maze.Draw
module G = Maze.Game

let () =
  let board, state = "maze.txt" |> G.of_file in
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
