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

let move_robot (board : Board.t) (state : State.t) (direction : Pos.t) : State.t
    =
  let _ = board in
  let rx, ry = State.robot_pos state in
  let dx, dy = direction in
  let dest_x, dest_y = (rx + dx, ry + dy) in
  Printf.printf "Trying from (%d,%d) to (%d,%d)\n" rx ry dest_x dest_y ;
  (* Checking if we reach a floor *)
  let new_state =
    match Board.is_floor board ~x:dest_x ~y:dest_y with
    | false ->
        Printf.printf "Robot cannot move\n" ;
        state
    | true ->
        Printf.printf "TODO: check the floor\n" ;
        state
  in
  flush stdout ; new_state

let move_left ~(board : Board.t) ~(state : State.t) : State.t =
  move_robot board state (-1, 0)

let move_down ~(board : Board.t) ~(state : State.t) : State.t =
  move_robot board state (0, 1)

let move_up ~(board : Board.t) ~(state : State.t) : State.t =
  move_robot board state (0, -1)

let move_right ~(board : Board.t) ~(state : State.t) : State.t =
  move_robot board state (1, 0)
