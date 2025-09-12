module PosSet = Set.Make (Pos)

type t = {robot: Pos.t; boxes: PosSet.t}

let is_box_at (s : t) ~(x : int) ~(y : int) : bool = PosSet.mem (x, y) s.boxes

let robot_pos (s : t) : Pos.t = s.robot

let boxes (s : t) : PosSet.t = s.boxes

let of_string (str : string) (row : int) : Pos.t option * PosSet.t =
  let robot = ref None in
  let boxes = ref PosSet.empty in
  String.to_seq str
  |> Seq.iteri (fun x c ->
         match c with
         | '@' ->
             robot := Some (x, row)
         | 'O' ->
             boxes := PosSet.add (x, row) !boxes
         | _ ->
             () ) ;
  (!robot, !boxes)

let of_list (lst : string list) : t =
  let robot = ref None in
  let boxes = ref PosSet.empty in
  List.iteri
    (fun y row_str ->
      let r', b' = of_string row_str y in
      (* TODO: check that we have only one robot. Meaning only set robot if it is None. *)
      if Option.is_some r' then robot := r' ;
      boxes := PosSet.union !boxes b' )
    lst ;
  (* let's raise an exception if robot is None *)
  {robot= Option.get !robot; boxes= !boxes}
