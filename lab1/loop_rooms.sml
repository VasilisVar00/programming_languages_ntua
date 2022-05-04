fun loop_rooms (file : string) =
  let
    val counter = ref 0

    fun parse (file) =
      let

        fun readInt input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

        val inStream = TextIO.openIn file
        val (n , m) = (readInt inStream, readInt inStream)
        val _ = TextIO.inputLine inStream

        fun readLines acc =
        case TextIO.inputLine inStream of
          NONE => rev acc
          | SOME line => readLines (explode (String.substring (line, 0, m)) :: acc)

        val inputList = readLines []: char list list
        val _ = TextIO.closeIn inStream

      in
        (n, m, inputList)
      end

    val tuple = parse file;
    val N = #1 tuple;
    val M = #2 tuple;
    val maze = Array2.fromList (#3 tuple);
    val visited = Array2.array (N, M, 0);

    fun print_arr_char (arr, i, j) = (
      if i < N then
        if j < M then (
          print (Char.toString(Array2.sub(arr, i, j)) ^ " ");
          print_arr_char (arr, i, j + 1)
          )
        else (
          print("\n");
          print_arr_char (arr, i + 1, 0)
          )
      else
        ()
    );

    fun print_arr_int (arr, i, j) = (
      if i < N then
        if j < M then (
          print (Int.toString(Array2.sub(arr, i, j)) ^ " ");
          print_arr_int (arr, i, j + 1)
          )
        else (
          print("\n");
          print_arr_int (arr, i + 1, 0)
          )
      else
        ()
    );

    fun path (i, j, arr1, arr2, count : int ref) = (
      if Array2.sub(arr2, i, j) = 0 then
        count := !count + 1
      else ();
      Array2.update(arr2, i, j, 1);
      if j < M - 1 andalso Array2.sub(arr1, i, j + 1) = #"L" then
        path(i, j + 1, arr1, arr2, count)
      else ();
      if j > 0 andalso Array2.sub(arr1, i, j - 1) = #"R" then
        path(i, j - 1, arr1, arr2, count)
      else ();
      if i < N - 1 andalso Array2.sub(arr1, i + 1, j) = #"U" then
        path(i + 1, j, arr1, arr2, count)
      else ();
      if i > 0 andalso Array2.sub(arr1, i - 1, j) = #"D" then
        path(i - 1, j, arr1, arr2, count)
      else ();
      ()
      )

      fun loop_cols (arr1, arr2, j) = (
        if j < M then (
          if Array2.sub(arr1, 0, j) = #"U" then
            let val count_path = ref 0
            in
              path (0, j, arr1, arr2, count_path);
              counter := !counter + !count_path
            end
          else
            ();
        if Array2.sub(arr1, N - 1, j) = #"D" then
          let val count_path = ref 0
          in
            path (N - 1, j, arr1, arr2, count_path);
            counter := !counter + !count_path
          end
          else
            ();
        loop_cols (arr1, arr2, j + 1)
        )
        else
          ()
      );

      fun loop_rows (arr1, arr2, i) = (
        if i < N then (
          if Array2.sub(arr1, i, 0) = #"L" then
            let val count_path = ref 0
            in
              path (i, 0, arr1, arr2, count_path);
              counter := !counter + !count_path
            end
          else
            ();
        if Array2.sub(arr1, i, M - 1) = #"R" then
          let val count_path = ref 0
          in
            path (i, M - 1, arr1, arr2, count_path);
            counter := !counter + !count_path
          end
        else
          ();
        loop_rows (arr1, arr2, i + 1)
        )
        else
          ()
      );

      fun doAll () = (
        loop_cols (maze, visited, 0);
        loop_rows (maze, visited, 0);
        print (Int.toString((N * M) - !counter) ^ "\n")
        )
  in
    doAll ()
  end;
