let of_file (filename : string) : Board.t * State.t =
  (* we will go through the list twice but it allows a clean separation of concerns.
     Board cares only about walls/floors.
     State cares only about player/boxes.
     The cost is negligible for maze files (a few KB) *)
  let ic = open_in filename in
  let rec loop acc =
    try
      let s = input_line ic in
      loop (s :: acc)
    with End_of_file -> close_in ic ; List.rev acc
  in
  let lst = loop [] in
  let board = Board.of_list lst in
  let state = State.of_list lst in
  (board, state)

let move_left ~(board : Board.t) ~(state : State.t) : State.t =
  let _ = board in
  print_endline "TODO: move robot left" ;
  state

let move_down ~(board : Board.t) ~(state : State.t) : State.t =
  let _ = board in
  print_endline "TODO: move robot down" ;
  state

let move_up ~(board : Board.t) ~(state : State.t) : State.t =
  let _ = board in
  print_endline "TODO: move robot up" ;
  state

let move_right ~(board : Board.t) ~(state : State.t) : State.t =
  let _ = board in
  print_endline "TODO: move robot right" ;
  state
