open Graphics
module B = Board

(* Initialize graphics window *)
let init_window (board : B.t) : unit =
  let height = B.(height board * cell_size) in
  let width = B.(width board * cell_size) in
  open_graph (Printf.sprintf " %dx%d" width height);
  Printf.printf "Window size (width: %d, height: %d)\n" width height;
  Printf.printf "Press q to quit...\n%!"
;;

(* Draw a single cell *)
let draw_cell (x, y) ~(ty : B.cell) : unit =
  let color =
    match ty with
    | Wall -> black
    | Floor -> white
  in
  set_color color;
  fill_rect x y B.cell_size B.cell_size
;;

let draw_board (board : B.t) : unit =
  B.iteri_cells
    (fun x y cell -> draw_cell ~ty:cell (x * B.cell_size, y * B.cell_size))
    board
;;

(* Render the full state *)
let render board = draw_board board

(* Read key press *)
let read_key () = Graphics.read_key ()

(* Close graphics *)
let close_window () = Graphics.close_graph ()
