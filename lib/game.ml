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
